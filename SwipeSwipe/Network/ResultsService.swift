//
//  ResultsService.swift
//  SwipeSwipe
//
//  Created by Abhilash Ghogale on 15/09/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import UIKit

enum Response<T> {
    case Success(T)
    case Failure(String)
    case Error(String)
}

class ResultsService {
    
    func getResults(complition: @escaping ((Response<Results>) -> Void) ) {
        let url = URL(string: "https://randomuser.me/api/?results=50")!
        
        let req = URLRequest(url: url)
        
        let urlTask = URLSession.shared.dataTask(with: req) { (data, response, error) in
            
            guard error == nil else {
                return complition(.Failure(error?.localizedDescription ?? ""))
            }
            
            guard let data = data else {
                return complition(.Failure(error?.localizedDescription ?? ""))
            }
//
            guard let results = self.processResponse(data) else {
                return complition(.Failure(error?.localizedDescription ?? "Parsing Error"))
            }
            complition(.Success(results))
        }
        
        urlTask.resume()
    }
    
    func processResponse(_ data: Data) -> Results? {
        do {
            let responseModel = try JSONDecoder().decode(Results.self, from: data)
            return responseModel
            
        } catch {
            print("Data parsing error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func downloadImage(_ urlString: String, completion: @escaping (Response<UIImage>, _ url:String) -> Void) {
        
        if let img = ImageChache.shared.getImageFromCache(key: urlString) {
            completion(.Success(img), urlString)
            return
        }

        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        guard let url =  URL.init(string: urlString) else {
            return completion(.Failure(""), urlString)
        }
        
        
        session.downloadTask(with: url) { (url, reponse, error) in
            
            
            do {
                guard let url = url else {
                    return completion(.Failure("Something Went Wrong!"), urlString)
                }
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    ImageChache.shared.saveImageToCache(key: urlString, image: image)
                    return completion(.Success(image), urlString)
                } else {
                    return completion(.Failure("Something Went Wrong!"), urlString)
                }
            } catch {
                return completion(.Error("Something Went Wrong!"), urlString)
            }
        }.resume()
        
    }


}
