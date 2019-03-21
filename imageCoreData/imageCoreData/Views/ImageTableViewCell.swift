//
//  ImageTableViewCell.swift
//  imageCoreData
//
//  Created by Nelson Gonzalez on 3/20/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imageImageView: UIImageView!
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateViews() {
    
        guard let post = post, let idString = post.idString else {return}
    
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = URL(fileURLWithPath: paths).appendingPathComponent(idString).appendingPathExtension("jpeg")
        
        let data = try! Data(contentsOf: url)
        imageImageView.image = UIImage(data: data)
    }

}
