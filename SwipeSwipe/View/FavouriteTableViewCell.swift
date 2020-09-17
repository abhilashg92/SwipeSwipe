//
//  FavouriteTableViewCell.swift
//  SwipeSwipe
//
//  Created by Abhilash Ghogale on 17/09/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    
    var favorite:Favourite? {
        didSet {
            lblName.text = favorite?.name
            lblLocation.text = favorite?.location
            lblPhone.text = favorite?.phone
            self.showProfileImage(url:favorite?.imageUrl ?? "")
        }
    }
    
    func showProfileImage(url:String) {
        self.imgProfile.setCornerRadius(radius:self.imgProfile.bounds.width * 0.5)
        ResultsService().downloadImage(favorite?.imageUrl ?? "") { (resp, urlString) in
            
            DispatchQueue.main.async {
                //
                switch resp {
                case .Success(let img):
                    self.imageView?.image = img
                default:
                    break
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
