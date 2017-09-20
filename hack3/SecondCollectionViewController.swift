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
    var foodlistDic = [NSDictionary]()
    
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
                            self.foodlistDic.append(food)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pagesegue"{
            let controller = segue.destination as! PageViewController
            if let indexPath = sender as? IndexPath {
                controller.food = foodlistDic[indexPath.row]
                let temp = foodlistDic[indexPath.row].value(forKey: "ingredients") as! String
                let ingredients = temp.components(separatedBy: ",")
                controller.ingredients = ingredients
            }
        }
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
        if let imgURL = URL(string: foodlistDic[indexPath.row].value(forKey: "thumbnail") as! String) {
            let imgData = NSData(contentsOf: imgURL)
            cell.imageView.image = UIImage(data: imgData as! Data)
        }
        cell.imageView.layer.zPosition = -1
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let url = NSURL(string: foodlistDic[indexPath.row].value(forKey: "href") as! String)
//        if UIApplication.shared.canOpenURL(url! as URL){
//            UIApplication.shared.openURL(url! as URL)
//        }
        performSegue(withIdentifier: "pagesegue", sender: indexPath)
    }
}
