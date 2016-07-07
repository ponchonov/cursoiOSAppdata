//
//  ViewController.swift
//  Agenda
//
//  Created by Héctor Cuevas Morfín on 7/5/16.
//  Copyright © 2016 AppData. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    //New code
    var arrayWithContacts = NSMutableArray()
    var indexPathSelected = NSIndexPath()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let array = NSUserDefaults.standardUserDefaults().objectForKey("contacts")
        
        if array?.count > 0 {
            arrayWithContacts = (array?.mutableCopy() as? NSMutableArray)!
        }
        
     tableView.dataSource = self
     tableView.delegate = self
    // doDownloadContacts()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        doDownloadContacts()
    }
  
    func doDownloadContacts() {
        Alamofire.request(.GET, "https://appdatamxios.herokuapp.com/contacts", parameters: nil, encoding: .URL, headers: nil).response { (request, response, data, error) in
            
            do{
                let jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSArray
                
                
                if jsonDict?.count>0{
                    
                    NSUserDefaults.standardUserDefaults().setObject(jsonDict, forKey: "contacts")
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                
                
                self.arrayWithContacts = (jsonDict?.mutableCopy())! as! NSMutableArray
                dispatch_async(dispatch_get_main_queue(), { 
                    self.tableView.reloadData()
                })
                 print(jsonDict)
                
            } catch let dataError {
                
                print(dataError)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "doShowContact"
        {
         let controller = segue.destinationViewController as? DetailContactViewController
            
            controller?.dictWithInfo = arrayWithContacts.objectAtIndex(indexPathSelected.row) as! NSMutableDictionary
        }else
        {
            if(segue.identifier == "doShowMap")
            {
                let mapController = segue.destinationViewController as? MapViewController
                
                mapController?.arrayWithInfo = arrayWithContacts
                
            }
        }
        
        
    }


}

//Extension de ViewController

extension ViewController:UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayWithContacts.count
    }
    
    //configuration
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let customCell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as? CustomTableViewCell
        
        let dict = arrayWithContacts.objectAtIndex(indexPath.row) as! NSDictionary
        customCell?.labelName.text = dict.objectForKey("firstName") as? String
        customCell?.labelPhone.text = dict.objectForKey("phoneNumbers")?.objectForKey("mobile") as? String
        customCell?.imageViewContact.image = UIImage(named: "contact.png")
        return customCell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        indexPathSelected = indexPath
        self.performSegueWithIdentifier("doShowContact", sender: nil)
        
    }
    
    
}



