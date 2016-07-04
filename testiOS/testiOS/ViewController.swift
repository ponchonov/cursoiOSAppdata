//
//  ViewController.swift
//  testiOS
//
//  Created by Héctor Cuevas Morfín on 7/4/16.
//  Copyright © 2016 AppData. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textFieldName: UITextField!

    @IBOutlet weak var addNameButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayWithName = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func doAddPersonName(sender: AnyObject) {
        
        if textFieldName.text?.characters.count > 0{
            let text = textFieldName.text
            arrayWithName.addObject(text!)
            textFieldName.text = ""
            tableView.reloadData()
            textFieldName.resignFirstResponder()
        }
        
    }
    
    

}
//TableView Datasource
extension ViewController:UITableViewDataSource{
    
    //Numero de filas
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayWithName.count
    }
    //Configuración de la celda
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        cell.textLabel?.text = arrayWithName.objectAtIndex(indexPath.row) as? String
        
        let data = NSData(contentsOfURL: NSURL(string: "http://assets.tiempo.com.mx/uploads/imagen/imagen/24764/Volcan-Colima-3.jpg")!)
        cell.imageView?.image = UIImage(data: data!)
        
        return cell
    }
}

