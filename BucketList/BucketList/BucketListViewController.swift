//
//  ViewController.swift
//  BucketList
//
//  Created by Kevin Pham on 11/6/17.
//  Copyright © 2017 Kevin Pham. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {

    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    // this func is "override" bc we are inheriting from UITableViewController
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    // "->" asks for a return
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("selected")
        // used to have "performSegue.... Identifier "EditItemSegue"
            // moved it below because "accessoryButton" has been added!
            // because of the "accessoryButton" this func is no longer needed! ==**==========

    }
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "EditItemSegue", sender: indexPath)
        // this func listens for the user to press the acessoryButton. THEN performs the segue for the Identifier
    }
    
    
    // just having this func, gives functionality for  > swipe left for delete button
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddItemSegue" {
            let navigationController = segue.destination as! UINavigationController
            let AddItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            AddItemTableViewController.delegate = self
        }
        else if segue.identifier == "EditItemSegue" {
            let navigationController = segue.destination as! UINavigationController
            let AddItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            AddItemTableViewController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            let item = items[indexPath.row]
            AddItemTableViewController.item = item
            AddItemTableViewController.indexPath = indexPath
                                        // the index [] in the array of "items".

        }

        
    }
    
    func CancelButtonPressed(by controller: AddItemTableViewController) {
        print ("I'm the hidden controller, BUT I am responding to the CANCEL button press on the top view controller.")
        dismiss(animated: true, completion: nil)
        // dismiss the top view controller, because it cannot do that action itself.
    }
    
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        print ("Received Text From Top View: \(text)")
        
        if let ip = indexPath{
            items[ip.row] = text
            //updates the old entry "overwrite existing"
            
        } else {
            items.append(text)
            //creates a new entry at the end of the items array
        }
  
        tableView.reloadData()
            // this reloads the page so the new data is added and seen
        
        dismiss(animated: true, completion: nil)
    }
    
} // end of class
