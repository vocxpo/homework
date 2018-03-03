//
//  ViewController.swift
//  NewsDemo
//
//  Created by dev on 2018/02/24.
//  Copyright © 2018年 oopx. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var tblViewNews: UITableView!
    
    var articles = [Article]() {
        didSet {
            tblViewNews.reloadData()
            print(articles.count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "俺のニューズ"
        reqNews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func reqNews() {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines") else { return }
        
        let parameters: Parameters = [
            "country": "jp",
            "apiKey": "d5de8d5ab79e4fdba2cc69cba94b6c8b"
        ]
        
        Alamofire
            .request(url,
                     method: .get,
                     parameters: parameters)
            // weak self: self may not exist
            // weak: do not count reference
            .responseData(completionHandler: { [weak self] res in
                let decoder = JSONDecoder()
                if let data = res.data {
                    do {
                        // NewsResponse.self: type
                        let result = try decoder.decode(NewsResponse.self, from: data)
                        // if self does not exist, this will not be executed
                        self?.articles = result.articles
                    } catch {
                        // json decode error
                    }
                } else {
                    // no data response
                }
            })
    }

    // pass params to the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let destination = segue.destination as? DetailViewController else { return }
            guard let article = sender as? Article else { return }
            
            destination.urlString = article.url
        }
    }
    
}

extension ViewController {

    // how many cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    // what to show in the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        // as? / as!: cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let article = articles[row]
        cell.lblTitle.text = article.title
        cell.lblDescription.text = article.description
        
        if let urlToImage = article.urlToImage,
            let url = URL(string: urlToImage) {
            cell.imgNews.af_setImage(withURL: url, placeholderImage: nil)
        } else {
            cell.imgNews.image = nil
        }
        
        return cell
    }
    
    // what to do if the cell is touched
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = articles[indexPath.row]
        performSegue(withIdentifier: "ShowDetail", sender: article)
    }
}

