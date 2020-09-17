//
//  ProfileCardView.swift
//  SwipeSwipe
//
//  Created by Abhilash Ghogale on 16/09/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import UIKit

class ProfileCardView: UIView {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblData: UILabel!
    
    @IBOutlet weak var btnName: UIButton!
    @IBOutlet weak var btnDOB: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnPhone: UIButton!
    
    var infoData: Result? {
        didSet{
            self.nameTapped(btnName)
            self.loadImage(url: infoData?.picture.medium ?? "")
        }
    }
    
    class func instanceFromNib() -> ProfileCardView {
         
         return UINib(nibName: "ProfileCardView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ProfileCardView
     }
    
    func resetButtonColor() {
        self.btnName.backgroundColor = .clear
        self.btnDOB.backgroundColor = .clear
        self.btnLocation.backgroundColor = .clear
        self.btnPhone.backgroundColor = .clear
    }
    
    @IBAction func nameTapped(_ sender: UIButton) {
        resetButtonColor()
        sender.backgroundColor = .black
        let data = "\(infoData?.name.title ?? "")\(infoData?.name.first ?? "") \(infoData?.name.last ?? "")"
        self.updateLabelData(info: "My Name is", data: data)
    }
    
    @IBAction func dobTapped(_ sender: UIButton) {
        resetButtonColor()
         sender.backgroundColor = .black
        let data = "\(infoData?.dob.date.showDate() ?? "")"
        self.updateLabelData(info: "Candle lights on", data: data)

    }
    
    @IBAction func locationTapped(_ sender: UIButton) {
        resetButtonColor()
         sender.backgroundColor = .black
        let data = "\(infoData?.location.city ?? "")"
        self.updateLabelData(info: "Find me in", data: data)

    }
    
    @IBAction func phoneTapped(_ sender: UIButton) {
        resetButtonColor()
         sender.backgroundColor = .black
        let data = "\(infoData?.phone ?? "")"
        self.updateLabelData(info: "Call me on", data: data)
    }
        
    func updateLabelData(info:String, data:String) {
        self.lblInfo.text = info
        self.lblData.text = data
    }
    
    private func loadImage(url:String) {
        self.imgProfile.setCornerRadius(radius: self.imgProfile.bounds.width * 0.5)
        ResultsService().downloadImage(url) { (respose, url) in
            DispatchQueue.main.async {
                switch respose {
                case .Success(let image):
                    self.imgProfile.image = image
                    break
                    
                default:
                    break
                }
                
            }
        }
    }

}
