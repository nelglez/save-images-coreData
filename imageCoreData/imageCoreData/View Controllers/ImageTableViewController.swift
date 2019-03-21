//
//  ImageTableViewController.swift
//  imageCoreData
//
//  Created by Nelson Gonzalez on 3/20/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class ImageTableViewController: UITableViewController {
    
    var postController: PostController?

    override func viewDidLoad() {
        super.viewDidLoad()

    //   tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return postController?.post.count ?? 1
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageTableViewCell

        let post = postController?.post[indexPath.row]
        
        cell.post = post

        return cell
    }
  

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let post = postController?.post[indexPath.row] else {return}
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let url = URL(fileURLWithPath: paths).appendingPathComponent(post.idString!).appendingPathExtension("jpeg")
            try! FileManager.default.removeItem(at: url)
           postController?.delete(post: post)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }   
    }
   


}
