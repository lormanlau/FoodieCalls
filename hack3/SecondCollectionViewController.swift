//
//  SecondTableViewController.swift
//  hack3
//
//  Created by havisha tiruvuri on 9/19/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit

class SecondCollectionViewController: UICollectionViewController {
    
    var delegate: FirstTableViewController?
    var url: URL?

    var foodlist = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAPIResponse()
    }
    
    func getAPIResponse(){
        
        let session = URLSession.shared
        // Create a "data task" which will request some data from a URL and then run a completion handler after it is done
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            // We get data, response, and error back. Data contains the JSON data, Response contains the headers and other information about the response, and Error contains an error if one occured
            // A "Do-Try-Catch" block involves a try statement with some catch block for catching any errors thrown by the try statement.
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] as? NSArray {
                        for foods in results {

                            let food = foods as! NSDictionary
                            let title = food.value(forKey: "title") as! String
                            self.foodlist.append(title)
                        }
                    }
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
            } catch {
                print("Something went wrong")
            }
        })
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodlist.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CustomCollectionCell
        cell.titleLabel.text = foodlist[indexPath.row]
        return cell
    }

}
