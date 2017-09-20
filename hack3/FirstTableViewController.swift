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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
