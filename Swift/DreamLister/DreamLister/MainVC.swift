//
//  MainVC.swift
//  DreamLister
//
//  Created by Ari Mendelow on 3/12/17.
//  Copyright © 2017 Ari Mendelow. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller: NSFetchedResultsController<Item>! //help display data fetched from CoreData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        generateTestData()
        
        attemptFetch()
        tableView.reloadData()
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: ItemCell, indexPath: NSIndexPath) {

        //update cell
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item) //handled in ItemCell custom class
    }
    
    //prepare selected object to be sent to the next view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //make sure didSELECT and not didDEselect
        
        //make sure that there is an object - the "," used to be "where"
        if let objs = controller.fetchedObjects , objs.count > 0 {
            
            let item = objs[indexPath.row]
            
            performSegue(withIdentifier: "ItemDetailsVC", sender: item)
        }
    }
    
    //getting the item ready to be sent
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ItemDetailsVC" {
            if let destination = segue.destination as? ItemDetailsVC {
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        if let sections = controller.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
   
        return 150 //make sure that rows stay at 150 height
    }
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        
        if segment.selectedSegmentIndex == 0 { //default
            
            fetchRequest.sortDescriptors = [dateSort]
            
        } else if segment.selectedSegmentIndex == 1 {
            
            fetchRequest.sortDescriptors = [priceSort]
            
        } else if segment.selectedSegmentIndex == 2 {
            
            fetchRequest.sortDescriptors = [titleSort]
            
        }
        
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self //we hadn't told the methods what really to listen to
        
        self.controller = controller //setting outside contoller to the inside controller
        
        do {
            
            try controller.performFetch()
            
        } catch {
            
            let error = error as NSError
            print("\(error)")
            
        }
        
        tableView.reloadData()
        
        
    }
    
    @IBAction func segmentChange(_ sender: Any) { //whenever someone selects a different segment, we will go through and do the attemptFetch, sorting by the selected thing
        
        attemptFetch()
        
        
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
        case.insert: //putting in new item
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case.delete: //deleting item
            if let indexPath = indexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case.update: //click on existing item and want to update it
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell //casted as ItemCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath) //this is the local configureCell func
            }
            break
            
        case.move: //touch-moving implemented and dragging - delete at current place and insert at new index path
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
        
    }
    
    func generateTestData() {
        
        let item = Item(context: context)
        item.title = "Macbook Pro"
        item.price = 1800
        item.details = "I can't wait until the September event, I hope they release new MBPs"
        
        let item2 = Item(context: context)
        item2.title = "Bose Headphones"
        item2.price = 1800
        item2.details = "But man, it's so nice to be able to block out everyone with the noise cancelling tech"
        
        let item3 = Item(context: context)
        item3.title = "Tesla Model S"
        item3.price = 11000
        item3.details = "Oh man this is a beautiful car. And one day, I will own it."
        
        ad.saveContext()
        
    }
    
    
    
    
}
