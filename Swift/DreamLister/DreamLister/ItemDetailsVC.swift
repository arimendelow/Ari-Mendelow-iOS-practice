//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Ari Mendelow on 3/14/17.
//  Copyright © 2017 Ari Mendelow. All rights reserved.
//

import UIKit
import CoreData //needed to use coredata

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var thumbImg: UIButton!
    
    
    var stores = [Store]()
    var itemToEdit: Item? //optional because when we go over to this view we aren't always editing
    var imagePicker: UIImagePickerController! //requires creating a new key (in info.plist) to notify the user that we are going to use the camera roll

    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            //replacing back bar button with one that doesn't have a title
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
//        generateTestStores()
        
        getStores()
        
        //load item if itemToEdit isn't nil - when we pass over an item, we will load it into the view
        if itemToEdit != nil {
            loadItemData()
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
    }
    
    //how many rows there are
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
    }
    
    
    //how many columns there are
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //update when selected
    }
    
    func generateTestStores() {
        
        let store = Store(context: context)
        store.name = "Best Buy"
        let store2 = Store(context: context)
        store2.name = "Tesla Dealership"
        let store3 = Store(context: context)
        store3.name = "Frys Electronics"
        let store4 = Store(context: context)
        store4.name = "Target"
        let store5 = Store(context: context)
        store5.name = "Amazon"
        let store6 = Store(context: context)
        store6.name = "K-Mart"
        
        ad.saveContext()
        
    }
    
    func getStores() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents() //reloads all of the components inside of the store picker
            
        } catch {
            
            //handle the error
            
        }
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        //insert object into the managed object context, assign the details in the title/price/details text field to the attributes of that object, and then save the obejct to the database:
        
        var item: Item! //create image entity
        let picture = Image(context: context) //create image entity
        picture.image = thumbImg.currentImage
        
        
        //are we editing an existing item or creating a new one?
        if itemToEdit == nil {
            
            item = Item(context: context)
            
        } else {
            
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            item.title = title
        }
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue //doubleValue is a property of NSString
        }
        if let details = detailsField.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)] //inCompnent is col, only one col -> 0
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    func loadItemData() {
        
        if let item = itemToEdit { //just so i dont need to retype itemToEdit every time
            
            titleField.text = item.title
            priceField.text = "\(item.price)" //string interpolation rather than casting as string
            detailsField.text = item.details
            
            thumbImg.setImage(item.toImage?.image as? UIImage, for: UIControlState.normal)
            
            //now making sure that the correct store is selected:
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < stores.count)
                
            }
        }
        
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        
        //only want to delete if we've passed an exiting object over - shouldn't delete a new object
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //returns a dictionary of objects, we need to extract the image
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumbImg.setImage(img, for: UIControlState.normal)
            imagePicker.dismiss(animated: true, completion: nil)
        }

    }
    
    
    
    
    
    
    
    


}
