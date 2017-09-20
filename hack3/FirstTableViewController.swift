//
//  FirstTableViewController.swift
//  hack3
//
//  Created by havisha tiruvuri on 9/19/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit
import CoreData
import SpriteKit

class FirstTableViewController: UITableViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var ingredient: [String] = [""]

    override func viewDidLoad() {
        super.viewDidLoad()
        var imagesNames = ["chef-animation-1.tiff","chef-animation-2.tiff","chef-animation-3.tiff","chef-animation-4.tiff","chef-animation-5.tiff","chef-animation-6.tiff","chef-animation-7.tiff","chef-animation-8.tiff","chef-animation-9.tiff","chef-animation-10.tiff","chef-animation-11.tiff","chef-animation-12.tiff"]
    
        var images3 = [UIImage]()
        for i in 0..<imagesNames.count {
            images3.append(UIImage(named: imagesNames[i])!)
        self.imageView.animationImages = images3
        self.imageView.animationDuration = 4.0
        self.imageView.startAnimating()
        }
       
    }

    
    @IBAction func AddButton(_ sender: UIButton) {
        ingredient.append("")
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "done" {
            for i in 0..<ingredient.count {
                let indexPath = IndexPath(row: i, section: 0)
                let cell = tableView.cellForRow(at: indexPath) as! FirstTableViewCell
                ingredient[i] = cell.EnterTextField.text!
            }
            print(ingredient)
            let controller = segue.destination as! SecondCollectionViewController
            controller.delegate = self
            controller.url = apiCall(array: ingredient)
        }
    }
    
    func apiCall(array: [String]) -> URL{
        var extra = String()
        for ingred in ingredient {
            extra += ingred
            if ingred != ingredient[ingredient.count-1]{
                extra += ","
            }
        }
        let url = URL(string: "http://www.recipepuppy.com/api/?i=\(extra)")
        return url!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ingredient.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dishcell1", for: indexPath) as! FirstTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row >= 1 {
            ingredient.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

}
