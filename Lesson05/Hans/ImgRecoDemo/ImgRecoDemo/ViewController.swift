//
//  ViewController.swift
//  ImgRecoDemo
//
//  Created by dev on 2018/03/04.
//  Copyright © 2018年 oopx. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var chooseImgButton: UIButton!
    @IBOutlet weak var chosenImg: UIImageView!
    @IBOutlet weak var imgUploadProgress: UIProgressView!
    @IBOutlet weak var imgUploadIndicator: UIActivityIndicatorView!
    
    var tags: [String]?
    var colors: [PhotoColor]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        let picker = UIImagePickerController()
        // delegate(now is self) must implement UIImagePickerControllerDelegate and UINavigationControllerDelegate
        picker.delegate = self
        // not able to delete or edit
        picker.allowsEditing = false
        
        // simulator can not use camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .fullScreen
        }
        
        present(picker, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResult" {
            let controller = segue.destination as! TabViewController
            controller.tags = tags
            controller.colors = colors
        }
    }

}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // image is in info dict
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        else {
            dismiss(animated: true)
            return
        }
        
        chosenImg.image = image
        
        chooseImgButton.isHidden = true
        imgUploadProgress.progress = 0.0
        imgUploadProgress.isHidden = false
        imgUploadIndicator.startAnimating()
        
        uploadImg(image: image,
                  progressCompletion: { [unowned self] percent in
                    self.imgUploadProgress.setProgress(Float(percent), animated: true)
        }) { [unowned self] tags, colors in
            self.imgUploadIndicator.stopAnimating()
            self.imgUploadProgress.isHidden = true
            self.chooseImgButton.isHidden = false
            
            self.tags = tags
            self.colors = colors
            
            self.performSegue(withIdentifier: "ShowResult", sender: self)
        }
        
        dismiss(animated: true)
    }
}

extension ViewController: UINavigationControllerDelegate {}

extension ViewController {
    
    // @escaping: preserve the closure in async process
    func uploadImg(image: UIImage,
                   // upload in progress
        progressCompletion: @escaping (_ percent: Float) -> Void,
        // upload complete
        // can not add indicator to closure
        completion: @escaping (_ tags: [String], _ colors: [PhotoColor]) -> Void) {
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
            print("Failed to get JPEG representation of selected image.")
            return
        }
        
        Alamofire.upload(
            multipartFormData: { data in
                // use closure so as to be able to append multi times
                data.append(imageData,
                            // key of imagga
                    withName: "imagefile",
                    fileName: "image.jpg",
                    mimeType: "image/jpeg")
        },
            // add Allow Arbitrary Loads: YES to allow http transport
            to: "http://api.imagga.com/v1/content",
            // method is defaulted to post
            // method:
            headers: ["Authorization": "Basic YWNjX2QyZWVhNjYxYzZlOTA4MDplMjk5NDhkYTExOTQwMTE0OTc5MzAxODJjMjZlYTRhZg=="])
            
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
        
                            self.getTags(contentID: firstFileID) { tags in
                                self.getColors(contentID: firstFileID) {colors in
                                    completion(tags, colors)
                                }
                            }
        
                            completion([String](), [PhotoColor]())
                        } catch {
                            print("Failed to parse result json.")
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

    func getTags(contentID: String, completion: @escaping ([String]) -> Void) {
    }
    
    func getColors(contentID: String, completion: @escaping ([PhotoColor]) -> Void) {
    }

}

