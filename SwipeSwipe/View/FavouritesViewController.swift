//
//  FavouritesViewController.swift
//  SwipeSwipe
//
//  Created by Abhilash Ghogale on 17/09/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var profileArray = [Favourite]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        let nib = UINib(nibName: "FavouriteTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FavouriteTableViewCell")
        
        CDManager.shared().getFavourite(completion: { (favourites, messgae) in
            if let arry = favourites {
                DispatchQueue.main.async {
                    self.profileArray = arry
                    self.tableView.reloadData()
                }
                self.profileArray = arry
            } else {
                print(messgae ?? "")
            }
        })
        
        
        // Do any additional setup after loading the view.
    }
    

}

extension FavouritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell", for: indexPath) as! FavouriteTableViewCell
        cell.favorite = profileArray[indexPath.row]
        return cell
    }
    
    
}
