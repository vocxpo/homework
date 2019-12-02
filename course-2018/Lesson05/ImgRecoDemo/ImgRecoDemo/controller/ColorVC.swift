//
//  ColorVC.swift
//  ImgRecoDemo
//
//  Created by dev on 2018/03/12.
//  Copyright © 2018年 oopx. All rights reserved.
//

import UIKit

class ColorVC: UITableViewController {
    
    var colors: [PhotoColor] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let photoColor = colors[indexPath.row]
        let color = ColorUtil.getUIColorFromPhotoColor(photoColor: photoColor)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath)
        
        var red = CGFloat(0.0), green = CGFloat(0.0), blue = CGFloat(0.0), alpha = CGFloat(0.0)
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let threshold = CGFloat(105)
        let bgDelta = ((red * 0.299) + (green * 0.587) + (blue * 0.114))
        let textColor: UIColor = (255 - bgDelta < threshold) ? .black : .white
        
        cell.textLabel?.text = photoColor.name
        cell.textLabel?.textColor = textColor
        cell.backgroundColor = color

        return cell
    }
}
