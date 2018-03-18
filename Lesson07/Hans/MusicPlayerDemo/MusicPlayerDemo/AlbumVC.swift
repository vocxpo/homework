//
//  AlbumVC.swift
//  MusicPlayerDemo
//
//  Created by dev on 2018/03/18.
//  Copyright © 2018年 oopx. All rights reserved.
//

import UIKit

class AlbumVC: UITableViewController {

    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblPublish: UILabel!
    @IBOutlet weak var lblBrief: UILabel!
    
    var albumInfo: Album!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if albumInfo != nil {
            imgCover.image = UIImage(named: albumInfo.cover)
            lblName.text = albumInfo.name
            lblArtist.text = albumInfo.artist
            lblPublish.text = albumInfo.publish
            lblBrief.text = albumInfo.brief
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if albumInfo != nil {
            return albumInfo.songs.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        if albumInfo != nil {
            let songs = albumInfo.songs
            cell.textLabel?.text = songs[indexPath.row].name
        }
        
        return cell
    }
}

