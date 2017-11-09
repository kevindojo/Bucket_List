//
//  ViewController.swift
//  BucketList
//
//  Created by Kevin Pham on 11/6/17.
//  Copyright © 2017 Kevin Pham. All rights reserved.
//

import UIKit
import CoreData


//==============================================================//
//========================= Main page view =====================//
//==============================================================//
class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {

    
    // variable created = AddItemButton
    @IBOutlet weak var AddItemButton: UIBarButtonItem!
    
    
    // performSegue ==============================================
    // function for the actual button being pressed
    @IBAction func AddItemPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "itemSegue", sender: AddItemButton)
        // performSegue is a function that takes in 2 arguments( "itemSegue" is the connectiong between table views)
        
    }
    
    var items = [BucketListItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
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
        cell.textLabel?.text = items[indexPath.row].text!
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("selected")
        // used to have "performSegue.... Identifier "itemSegue"
            // moved it below because "accessoryButton" has been added!
            // because of the "accessoryButton" this func is no longer needed! ==**==========

    }
    
    
    
    // edit item for row selected
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "itemSegue", sender: indexPath)
        // this func listens for the user to press the acessoryButton. THEN activates the Identifier "itemSegue"
    }
    
    
    // just having this func, gives functionality for  > swipe left for delete button
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let item = items[indexPath.row]
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    
    
    //PREPARE SEGUE =============================================================

        // for segue: specifically looking for segues in storyboard
        //sender: what object type sent the request(i.e. bar button item or button, any object,....)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        //storyboard path way
        // *identifier* is important so that you can access different segues.
        if segue.identifier == "itemSegue" {
            
            // segue'd from ADD button
            let navigationController = segue.destination as! UINavigationController
            let AddItemTableViewController = navigationController.topViewController as! AddItemTableViewController
            AddItemTableViewController.delegate = self
            
            // segue'd from EDIT button
            if let indexPath = sender as? NSIndexPath{
                let item = items[indexPath.row]
                
                AddItemTableViewController.item = item.text!                         // add .text!, previously a bug
                AddItemTableViewController.indexPath = indexPath
                // the index [] in the array of "items".
            }
        }
    }
    
    
    //CORE DATA ============================================================= CORE DATA//
    
    func fetchAllItems() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let result = try managedObjectContext.fetch(request)
            items = result as! [BucketListItem]
        } catch {
            print("\(error)")
        }            
    }
    
    //CORE DATA ============================================================= CORE DATA//
    
    
    
    
    
    
    
    
    // functions below should go into Extension, which exists outside of the class ==========****===========
    
    func CancelButtonPressed(by controller: AddItemTableViewController) {
        print ("I'm the hidden controller, BUT I am responding to the CANCEL button press on the top view controller.")
        dismiss(animated: true, completion: nil)
        // dismiss the top view controller, because it cannot do that action itself.
    }
    
    
    
    
    func itemSaved(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
        print ("Received Text From Top View: \(text)")
        
        if let ip = indexPath{
            let item = items[ip.row]
            //updates the old entry "overwrite existing
            
            item.text = text
            // text is an atribute from BucketList data file
            
            
            
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            // text is an atribute from BucketList data file
            
            items.append(item)
            //creates a new entry at the end of the items array
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        
  
        tableView.reloadData()
            // this reloads the page so the new data is added and seen
        
        dismiss(animated: true, completion: nil)
    }
    
} // end of class

