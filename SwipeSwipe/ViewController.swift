//
//  ViewController.swift
//  SwipeSwipe
//
//  Created by Abhilash Ghogale on 15/09/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import UIKit
import Koloda

class ViewController: UIViewController {

    @IBOutlet weak var caroselView: KolodaView!
    var viewModel:UserProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = UserProfileViewModel()
        self.viewModel.getProfiles()
        caroselView.delegate = self
        caroselView.dataSource = self
        viewModel.delegate = self
    }
    @IBAction func onFavouritesTapped(_ sender: Any) {
        let vc = FavouritesViewController()
        self.present(vc, animated: false) {
            //
        }
    }
    
    private func showAlert(title: String = "SwipeSwipe", message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title:NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {(action) in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}

extension ViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        viewModel.fetchNextPage {
            koloda.reloadData()
        }
        
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        print("\(direction.rawValue)")
        
        if direction == .right || direction == .bottomRight || direction == .right {
            // add to favorites
            viewModel.addProfileToFavourites(index: index)
            
        }
    }
    
}

extension ViewController: KolodaViewDataSource {
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let view = ProfileCardView.instanceFromNib()
        view.infoData = viewModel.results?.results[index]
        return view
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return viewModel.results?.results.count ?? 0
    }
    
}

extension ViewController: UserProfileDelegate {
    
    func dataSuccess() {
        // reload data
        caroselView.reloadData()
    }
    
    func showAlertMessage(message: String) {
        self.showAlert(message: message)
    }
    
}
