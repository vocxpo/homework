//
//  ViewController.swift
//  TableViewDemo
//
//  Created by dev on 2018/02/10.
//  Copyright © 2018年 oopx. All rights reserved.
//

import UIKit
import Foundation

class TableViewController: UITableViewController {
    
    let jsonString = """
         [{"name":"李超逸","gender":"男"},{"name":"王山鹰","gender":"男"},{"name":"马九思","gender":"男"},{"name":"吴翰","gender":"男"},{"name":"王洪璋","gender":"男"},{"name":"娜仁乎","gender":"女"},{"name":"阎晓宁","gender":"女"}]
        """
    
    struct Person: Codable {
        var name: String
        var gender: String
    }
    let testData = [Person(name:"李超逸",gender:"男"),Person(name:"王山鹰",gender:"男"),Person(name:"马九思",gender:"男"),Person(name:"吴翰",gender:"男"),Person(name:"王洪璋",gender:"男"),Person(name:"娜仁乎",gender:"女"),Person(name:"阎晓宁",gender:"女")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            try getJSON(jsonString: jsonString)
        } catch {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellName: String
        let r = indexPath.row
        
        if r % 2 == 0 {
            cellName = "labelCell1"
        } else {
            cellName = "labelCell2"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath)
        
        cell.textLabel?.text = testData[r % 7].name
        cell.detailTextLabel?.text = testData[r % 7].gender
        
        return cell
    }
    
    func getJSON(jsonString: String) throws {

        struct Person: Codable {
            var name: String
            var gender: String
        }
        
        let people = try JSONDecoder().decode([Person].self, from: jsonString.data(using: .utf8)!)
        
        for person in people {
            let name = person.name
            let gender = person.gender
            print("\(name) (\(gender))")
        }

    }
}
