//
//  ImageView+NetworkImages.swift
//  AppCent-WeatherApp
//
//  Created by Giray Uçar on 12.05.2021.
//

import Foundation
import UIKit

var imageCache = NSMutableDictionary()

extension UIImageView {

    func loadImageUsingCacheWithUrlString(urlString: String) {

        self.image = nil

        if let img = imageCache.value(forKey: urlString) as? UIImage{
            self.image = img
        }
        else{
            let session = URLSession.shared
            let task = session.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

                if(error == nil){

                    if let img = UIImage(data: data!) {
                        imageCache.setValue(img, forKey: urlString)    // Image saved for cache
                        DispatchQueue.main.async {
                            self.image = img
                        }
                    }

                }
            })
            task.resume()
        }
    }
}
