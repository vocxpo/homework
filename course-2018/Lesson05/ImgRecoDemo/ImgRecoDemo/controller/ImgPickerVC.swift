//
//  ImgPickerVC.swift
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
            let controller = segue.destination as! UITabBarController
            
            let tabTag = controller.viewControllers![0] as! TagVC
            tabTag.tags = tags!
            let tabColor = controller.viewControllers![1] as! ColorVC
            tabColor.colors = colors!
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
        
        chosenImg.isHidden = false
        chosenImg.image = image
        
        chooseImgButton.isHidden = true
        imgUploadProgress.isHidden = false
        imgUploadProgress.progress = 0.0
        imgUploadProgress.isHidden = false
        imgUploadIndicator.startAnimating()
        
        ImaggaService.uploadImage(image: image,
                filename: "image.jpg",
                progressCompletion: { [unowned self] percent in
                    self.imgUploadProgress.setProgress(Float(percent), animated: true)
        }) { [unowned self] tags, colors in
            self.imgUploadIndicator.stopAnimating()
            self.imgUploadProgress.isHidden = true
            self.chooseImgButton.isHidden = false
            self.chosenImg.isHidden = true
            
            self.tags = ImaggaService.convertTags(data: tags)
            self.colors = ImaggaService.convertColors(data: colors)
            
            self.performSegue(withIdentifier: "ShowResult", sender: self)
        }
        
        dismiss(animated: true)
    }
}

extension ViewController: UINavigationControllerDelegate {}
