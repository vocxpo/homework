//
//  ViewController.swift
//  Lesson04
//
//  Created by 呉翰 on 2019/11/17.
//  Copyright © 2019 呉翰. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var newsTable: UITableView!
    
    var articles: [Article]? {
        didSet {
            newsTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "小新闻"
        requestNews()
    }
    
    private func requestNews() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines")!
        
        let parameters: Parameters = [
            "country": "jp",
            "apiKey": "d5de8d5ab79e4fdba2cc69cba94b6c8b",
        ]
        
        Alamofire.request(
            url,
            method: .get,
            parameters: parameters)
            .responseData { respData in
                let decoder = JSONDecoder()
                if let data = respData.data {
                    do {
                        let result = try decoder.decode(NewsResponse.self, from: data)
                        self.articles = result.articles
                    } catch {
                        // json decode error
                    }
                } else {
                    // no data
                }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let articles = self.articles {
            return articles.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! TableViewCell
        
        let article = self.articles![indexPath.row]
        cell.newsTitle.text = article.title
        cell.newsContent.text = article.description
        
        if let urlToImage = article.urlToImage,
            let url = URL(string: urlToImage) {
            cell.newsImage.af_setImage(withURL: url, placeholderImage: nil)
        } else {
            cell.newsImage.image = nil
        }
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let destination = segue.destination as? DetailViewController else { return }
            guard let article = sender as? Article else { return }
            
            destination.urlString = article.url
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = articles?[indexPath.row]
        performSegue(withIdentifier: "ShowDetail", sender: article)
    }

}
