//
//  DetailContactViewController.swift
//  Agenda
//
//  Created by Héctor Cuevas Morfín on 7/5/16.
//  Copyright © 2016 AppData. All rights reserved.
//

import UIKit
import Alamofire

class DetailContactViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDirection: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var buttonDelect: UIButton!
    
    var dictWithInfo = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelName.text = dictWithInfo.objectForKey("firstName") as? String
        labelPhone.text = dictWithInfo.objectForKey("phoneNumbers")?.objectForKey("mobile") as? String
        labelDirection.text = dictWithInfo.objectForKey("direction") as? String
        
     
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doDeleteContact() {
        
           let alert = UIAlertController(title: "Aviso", message: "Desea borrar el contacto?", preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Borrar", style: .Destructive) { (delete) in
            Alamofire.request(.DELETE, "https://appdatamxios.herokuapp.com/contacts/\(self.dictWithInfo.objectForKey("_id")!)", parameters: nil, encoding: .URL, headers: nil).response { (request, response, data, error) in
                
                if error == nil{
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
            
        }
        
        let actioCancel = UIAlertAction(title: "Cancelar", style: .Cancel) { (cancelTaped) in

        }
        
        alert.addAction(action)
        alert.addAction(actioCancel)
        
        presentViewController(alert, animated: true, completion: nil)
        
        
        
        
       
    }

    @IBAction func doDeleteContactTaped(sender: AnyObject) {
        doDeleteContact()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
