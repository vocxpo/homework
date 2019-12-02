//
//  TagVC.swift
//  ImgRecoDemo
//
//  Created by dev on 2018/03/12.
//  Copyright © 2018年 oopx. All rights reserved.
//

import UIKit

class TagVC: UITableViewController {
    
    var tags: [String] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)
        cell.textLabel?.text = tags[indexPath.row]
        return cell
    }
}
