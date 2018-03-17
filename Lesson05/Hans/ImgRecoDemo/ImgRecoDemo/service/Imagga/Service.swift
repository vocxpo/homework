//
//  Service.swift
//  Imagga
//
//  Created by oopx on 2018/03/12.
//  Copyright © 2018年 oopx. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ImaggaService {
    
    let uploadKey: String = "imagefile"
    
        // @escaping: preserve the closure in async process
    static func uploadImage(
        image: UIImage,
        filename: String,
        // upload in progress
        progressCompletion: @escaping (_ percent: Float) -> Void,
        // upload complete
        // can not add indicator to closure
        completion: @escaping (_ tags: ImaggaTagResponse, _ colors: ImaggaColorResponse) -> Void)
    {
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
            print("Failed to get JPEG representation of selected image.")
            return
        }
        
        Alamofire.upload(
            multipartFormData: { data in
                // use closure so as to be able to append multi times
                data.append(imageData,
                    withName: "imagefile",
                    fileName: filename,
                    mimeType: "image/jpeg")
            },
            with: ImaggaRouter.content)
            
            // if the last parameter is a closure, it can be written out of the callee
            // encodingCompletion:
        { encodingResult in
            switch encodingResult {
            // if a param is never used, hold the place with _
            // let upload: just remember the syntax
            case .success(let upload, _, _):
                upload.uploadProgress { progress in
                    progressCompletion(Float(progress.fractionCompleted))
                }
                
                upload.validate()
                
                // example of parsing json manaully
                //                upload.responseJSON(completionHandler: { (res) in
                //                    guard res.result.isSuccess else {
                //                        print("Failed to upload image: \(String(describing: res.result.error))")
                //                        completion([String](), [PhotoColor]())
                //                        return
                //                    }
                //
                //                    guard let json = res.result.value as? [String: Any],
                //                        let uploadedFiles = json["uploaded"] as? [[String: Any]],
                //                        let firstFile = uploadedFiles.first,
                //                        let firstFileID = firstFile["id"] as? String else {
                //                            print("Failed to receive valid information from Imagga.")
                //                            completion([String](), [PhotoColor]())
                //                            return
                //                    }
                //
                //                    print("Content uploaded with id: \(firstFileID)")
                //
                //                    self.getTags(contentID: firstFileID) { tags in
                //                        self.getColors(contentID: firstFileID) {colors in
                //                            completion(tags, colors)
                //                        }
                //                    }
                //
                //                    completion([String](), [PhotoColor]())
                //                })
                
                upload.responseJSON(completionHandler: { res in
                    let decoder = JSONDecoder()
                    if let data = res.data {
                        do {
                            let result = try decoder.decode(ImaggaUploadResponse.self, from: data)
                            let firstFileID = result.uploaded[0].id
                            
                            print("Content uploaded with id: \(firstFileID)")
                            
                            getTagging(contentID: firstFileID) { tags in
                                getColor(contentID: firstFileID) {colors in
                                    completion(tags, colors)
                                }
                            }
                        } catch {
                            print("Failed to parse upload result json.")
                        }
                    } else {
                        print("Failed to upload image: \(String(describing: res.result.error))")
                    }
                })
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    static func getTagging(contentID: String, completion: @escaping (ImaggaTagResponse) -> Void) {
        Alamofire.request(ImaggaRouter.tags(contentID))
            .responseJSON { res in
                let decoder = JSONDecoder()
                if let data = res.data {
                    do {
                        let result = try decoder.decode(ImaggaTagResponse.self, from: data)
                        completion(result)
                    } catch {
                        print("Failed to parse tag result json.")
                    }
                } else {
                    print("Failed to get tags info: \(String(describing: res.result.error))")
                }
        }
    }
    
    static func getColor(contentID: String, completion: @escaping (ImaggaColorResponse) -> Void) {
        Alamofire.request(ImaggaRouter.colors(contentID))
            .responseJSON { res in
                let decoder = JSONDecoder()
                if let data = res.data {
                    do {
                        let result = try decoder.decode(ImaggaColorResponse.self, from: data)
                        completion(result)
                    } catch {
                        print("Failed to parse color result json.")
                    }
                } else {
                    print("Failed to get colors info: \(String(describing: res.result.error))")
                }
        }
    }
    
    static func convertTags(data: ImaggaTagResponse) -> [String] {
        let dict = data.results[0].tags
        
        let tags = dict.flatMap({ e in
            if e.confidence > 5 {
                return e.tag
            } else {
                return nil
            }
        })
        
        return tags
    }
    
    static func convertColors(data: ImaggaColorResponse) -> [PhotoColor] {
        let dict = data.results[0].info.image_colors
        
        let colors = dict.flatMap({ e in
            return PhotoColor(r: Int(e.r)!, g: Int(e.g)!, b: Int(e.b)!, name: e.closest_palette_color)
        })
        
        return colors
    }
}
