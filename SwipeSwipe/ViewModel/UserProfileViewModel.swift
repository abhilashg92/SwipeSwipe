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
    private var pageNo = 1
    private var totalPageNo = 50

    
    func getProfiles() {
        
        ResultsService().getResults(pages: pageNo) { (results) in
            
            DispatchQueue.main.async {
                switch results {
                case .Success(let results):
                    self.totalPageNo += 50
                    if self.results == nil {
                        self.results = results
                    }
                    self.results?.results.append(contentsOf: results.results)
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
    
    
    func fetchNextPage(completion:@escaping () -> Void) {
        if totalPageNo >= 500 {
            return
        }
        
        if pageNo < totalPageNo {
            pageNo += 10
            self.getProfiles()
        } else {
            completion()
        }
    }


    
    
}
