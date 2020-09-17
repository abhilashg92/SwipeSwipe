//
//  UserProfileViewModel.swift
//  SwipeSwipe
//
//  Created by Abhilash Ghogale on 15/09/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import Foundation

protocol UserProfileDelegate:class {
    func dataSuccess()
    func showAlertMessage(message:String)
}

class UserProfileViewModel {
    
    private(set) var results:Results?
    weak var delegate:UserProfileDelegate?
    private(set) var str = ""
    
    func getProfiles() {
        
        ResultsService().getResults { (results) in
            
            DispatchQueue.main.async {
                switch results {
                case .Success(let results):
                    self.results = results
                    self.delegate?.dataSuccess()
                    break
                case .Failure(let reason):
                    self.delegate?.showAlertMessage(message: reason)
                    break
                case .Error(let error):
                    self.delegate?.showAlertMessage(message: error)
                    break
                }
                
            }
        }
    }
    
    func addProfileToFavourites(index:Int) {
        if let profile = self.results?.results[index] {
        CDManager.shared().addToFavourite(profile: profile)
        }
    }
    
    
}
