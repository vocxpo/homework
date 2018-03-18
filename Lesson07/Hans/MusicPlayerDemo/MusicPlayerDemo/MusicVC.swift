//
//  MusicVC.swift
//  MusicPlayerDemo
//
//  Created by dev on 2018/03/18.
//  Copyright © 2018年 oopx. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MusicVC: UICollectionViewController {

    var fileData: Albums!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // needed only if not use stroyboard
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        if let path = Bundle.main.path(forResource: "albums", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                fileData = try decoder.decode(Albums.self, from: data)
            } catch {
                print("Album parse error.")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAlbum" {
            guard let destination = segue.destination as? AlbumVC else { return }
            guard let album = sender as? Album else { return }
            
            destination.albumInfo = album
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        case 2:
            return fileData.albums.count
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        
        switch indexPath.section {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdCell", for: indexPath)
        case 1:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath)
            
            if let cell = cell as? ButtonCell {
                switch indexPath.item {
                case 0:
                    cell.btnButton.setBackgroundImage(#imageLiteral(resourceName: "fm"), for: .normal)
                    cell.btnButton.setTitle(nil, for: .normal)
                    cell.lblButton.text = "私人FM"
                case 1:
                    cell.btnButton.setBackgroundImage(#imageLiteral(resourceName: "suggest"), for: .normal)
                    cell.lblButton.text = "每日推荐"
                    
                    let cal = Calendar.current
                    let now = Date()
                    let day = cal.component(.day, from: now)
                    cell.btnButton.setTitle("\(day)", for: .normal)
                case 2:
                    cell.btnButton.setBackgroundImage(#imageLiteral(resourceName: "list"), for: .normal)
                    cell.btnButton.setTitle(nil, for: .normal)
                    cell.lblButton.text = "歌单"
                case 3:
                    cell.btnButton.setBackgroundImage(#imageLiteral(resourceName: "rank"), for: .normal)
                    cell.btnButton.setTitle(nil, for: .normal)
                    cell.lblButton.text = "排行榜"
                default:
                    break
                }
            }
        case 2:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath)
            
            if let cell = cell as? AlbumCell {
                cell.imgAlbum.image = UIImage(named: "cover\(indexPath.item + 1)")
                let album = fileData.albums[indexPath.item]
                cell.lblAlbum.text = album.name
            }
        default:
            fatalError()
        }
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = fileData.albums[indexPath.item]
        performSegue(withIdentifier: "ShowAlbum", sender: album)
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension MusicVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // UIScreen.main.frame.width
        let screenWidth = UIScreen.main.bounds.width
        
        switch indexPath.section {
        case 0:
            let ratio = CGFloat(170) / CGFloat(740)
            return CGSize(width: screenWidth, height: screenWidth * ratio)
        case 1:
            let cellWidth = (screenWidth - 30) / 4
            let cellHeight = cellWidth
            return CGSize(width: cellWidth, height: cellHeight)
        case 2:
            let cellWidth = (screenWidth - 10) / 3
            let cellHeight = cellWidth + 40
            return CGSize(width: cellWidth, height: cellHeight)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        switch section {
        case 2:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        switch section {
        case 1:
            return 10
        default:
            return 0
        }
    }
}
