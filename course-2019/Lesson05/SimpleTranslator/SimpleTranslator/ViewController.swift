//
//  ViewController.swift
//  SimpleTranslator
//
//  Created by 呉翰 on 2019/11/23.
//  Copyright © 2019 呉翰. All rights reserved.
//

import Alamofire
import CommonCrypto
import SnapKit
import UIKit

class ViewController: UIViewController {

    var srcTextField: UITextField
    var dstTextField: UITextField

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        srcTextField = UITextField(frame: CGRect(x:60, y:200, width:300, height:30))
        dstTextField = UITextField(frame: CGRect(x:60, y:300, width:300, height:30))
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(srcTextField)
        
        //设置边框样式为圆角矩形
        srcTextField.borderStyle = UITextField.BorderStyle.roundedRect
        
        //修改圆角半径的话需要将masksToBounds设为true
        srcTextField.layer.masksToBounds = true
        srcTextField.layer.cornerRadius = 12.0  //圆角半径
        srcTextField.layer.borderWidth = 2.0  //边框粗细
        srcTextField.layer.borderColor = UIColor.lightGray.cgColor //边框颜色
        
        srcTextField.adjustsFontSizeToFitWidth = true  //当文字超出文本框宽度时，自动调整文字大小
        srcTextField.minimumFontSize = 14  //最小可缩小的字号
        
        srcTextField.textAlignment = .left //水平左对齐
        srcTextField.contentVerticalAlignment = .center  //垂直居中对齐
        
        srcTextField.clearButtonMode = .whileEditing  //编辑时出现清除按钮
//        srcTextField.clearButtonMode = .unlessEditing  //编辑时不出现，编辑后才出现清除按钮
        srcTextField.clearButtonMode = .always  //一直显示清除按钮
        
        let translateButton: UIButton = UIButton(frame: CGRect(x: 160, y: 250, width: 80, height: 30))
        translateButton.backgroundColor = .lightGray
        translateButton.setTitle("Translate!", for: .normal)
        translateButton.addTarget(self, action: #selector(translateButtonAction), for: .touchUpInside)
        self.view.addSubview(translateButton)
        
        
        self.view.addSubview(dstTextField)
        
        //设置边框样式为圆角矩形
        dstTextField.borderStyle = UITextField.BorderStyle.roundedRect
        
        //修改圆角半径的话需要将masksToBounds设为true
        dstTextField.layer.masksToBounds = true
        dstTextField.layer.cornerRadius = 12.0  //圆角半径
        dstTextField.layer.borderWidth = 2.0  //边框粗细
        dstTextField.layer.borderColor = UIColor.lightGray.cgColor //边框颜色
        
        dstTextField.adjustsFontSizeToFitWidth = true  //当文字超出文本框宽度时，自动调整文字大小
        dstTextField.minimumFontSize = 14  //最小可缩小的字号
        
        dstTextField.textAlignment = .left //水平左对齐
        dstTextField.contentVerticalAlignment = .center  //垂直居中对齐
        
        dstTextField.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        dstTextField.clearButtonMode = .always  //一直显示清除按钮
        
    }

    @objc func translateButtonAction() {
        if let t:String = self.srcTextField.text {
            translate(srcText: t)
        } else {
            print("please input source word")
        }
    }
    
    private func translate(srcText src:String) {
        let url = URL(string: "https://fanyi-api.baidu.com/api/trans/vip/translate")!
        let appid = "20191123000359862"
        let secretKey = "XScVzwpHSpTVTYrOYPm3"
        let salt = arc4random()
        let q = src
        let s = appid + q + String(salt) + secretKey
        let sign = s.md5
        
        let parameters: Parameters = [
            "appid": appid,
            "q": q,
            "from": "auto",
            "to": "zh",
            "salt": salt,
            "sign": sign!,
        ]
        
        Alamofire.request(
            url,
            method: .get,
            parameters: parameters)
            .responseData { respData in
                let decoder = JSONDecoder()
                if let data = respData.data {
                    do {
                        let result = try decoder.decode(Translate.self, from: data)
                        self.dstTextField.text = result.trans_result[0].dst
                    } catch {
                        print("Failed to parse response data:")
                        do {
                            let error = try decoder.decode(Error.self, from: data)
                            print(error.error_msg)
                        } catch {
                        }
                    }
                } else {
                    print("Failed to get response data:")
                    print(respData)
                }
        }
    }

}

extension String  {
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)

        CC_MD5(str!, strLen, result)

        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }

        result.deallocate()

        return String(format: hash as String)
    }
}
