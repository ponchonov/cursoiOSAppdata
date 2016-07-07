//
//  AddContactViewController.swift
//  Agenda
//
//  Created by Héctor Cuevas Morfín on 7/5/16.
//  Copyright © 2016 AppData. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class AddContactViewController: UIViewController {

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldDirection: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var mapView: GMSMapView! 
    @IBOutlet weak var textFieldMail: UITextField!
    
    let locationManager = CLLocationManager()
    
    //
    
    var lookupAddressResults: Dictionary<NSObject, AnyObject>!
    var fetchedFormattedAddress: String!
    var fetchedAddressLongitude: Double!
    var fetchedAddressLatitude: Double!
    let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"

 
    override func viewDidLoad() {
        super.viewDidLoad()

       // locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        mapView.myLocationEnabled = true
        mapView.delegate = self
        self.textFieldDirection.delegate = self
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(19.244572, longitude: -103.725520, zoom: 10)
        
        mapView.camera = camera
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func doAddContact(sender: AnyObject) {
        
        let dictionary = ["firstName":"\(textFieldName.text!)",
                          "lastName":"",
                          "email":"\(textFieldMail.text!)",
                          "direction":"\(textFieldDirection.text!)",
                          "phoneNumbers":["mobile":"\(textFieldPhone.text!)",
                                          "work":""
                                            ],
                          "lat":"\(fetchedAddressLatitude)",
                          "lng":"\(fetchedAddressLongitude)"]
        
        Alamofire.request(.POST, "https://appdatamxios.herokuapp.com/contacts", parameters: dictionary as? [String : AnyObject], encoding: .JSON, headers: nil).response { (request, response, data, error) in
            
            do{
                let jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                print(jsonDict)
                
            } catch let dataError {
                
                print(dataError)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func geocodeAddress(address: String!, withCompletionHandler completionHandler: ((status: String, success: Bool) -> Void)) {
        if let lookupAddress = address {
            var geocodeURLString = baseURLGeocode + "address=" + lookupAddress
            geocodeURLString = geocodeURLString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            
            let geocodeURL = NSURL(string: geocodeURLString)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let geocodingResultsData = NSData(contentsOfURL: geocodeURL!)
                
                do{
                    let dictionary: Dictionary<NSObject, AnyObject> = try NSJSONSerialization.JSONObjectWithData(geocodingResultsData!, options: .MutableContainers) as! Dictionary<NSObject, AnyObject>
                    
                    // Get the response status.
                    let status = dictionary["status"] as! String
                    
                    if status == "OK" {
                        let allResults = dictionary["results"] as! Array<Dictionary<NSObject, AnyObject>>
                        self.lookupAddressResults = allResults[0]
                        print(self.lookupAddressResults)
                        // Keep the most important values.
                        self.fetchedFormattedAddress = self.lookupAddressResults["formatted_address"] as! String
                        let geometry = self.lookupAddressResults["geometry"] as! Dictionary<NSObject, AnyObject>
                        self.fetchedAddressLongitude = ((geometry["location"] as! Dictionary<NSObject, AnyObject>)["lng"] as! NSNumber).doubleValue
                        self.fetchedAddressLatitude = ((geometry["location"] as! Dictionary<NSObject, AnyObject>)["lat"] as! NSNumber).doubleValue
                        
                        self.mapView.clear()
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2DMake(self.fetchedAddressLatitude, self.fetchedAddressLongitude)
                        marker.title = "Tapped"
                        marker.snippet = "Marker"
                        
                    dispatch_async(dispatch_get_main_queue(), { 
                        marker.map = self.mapView
                    })
                        
                        completionHandler(status: status, success: true)
                    }
                    else {
                        completionHandler(status: status, success: false)
                    }
                    
                }catch{
                    print(error)
                    completionHandler(status: "", success: false)
                }
                
            })
        }else{
            completionHandler(status: "Dirección no valida.", success: false)
        }
    }
}

extension AddContactViewController:GMSMapViewDelegate, UITextFieldDelegate{
    
    func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        
      
        
        //geocodeAddress("av tecnológico 101, Colima, Colima") { (status, success) in
       // }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        geocodeAddress(textFieldDirection.text!) { (status, success) in
            print(success)
        }
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        
        geocodeAddress(textFieldDirection.text!) { (status, success) in
            print(success)
        }
    }
    
   
}
