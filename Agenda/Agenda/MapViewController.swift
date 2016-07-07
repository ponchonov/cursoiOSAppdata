//
//  MapViewController.swift
//  Agenda
//
//  Created by Héctor Cuevas Morfín on 7/5/16.
//  Copyright © 2016 AppData. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    var arrayWithInfo = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera: GMSCameraPosition = GMSCameraPosition.cameraWithLatitude(19.244572, longitude: -103.725520, zoom: 10)
        
        mapView.camera = camera
        
        for element in arrayWithInfo
        {
            let dict = element as? NSDictionary
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake((dict?.objectForKey("lat")?.doubleValue)!,(dict?.objectForKey("lng")?.doubleValue)!)
            marker.title = dict?.objectForKey("firstName") as? String
            marker.snippet = dict?.objectForKey("phoneNumbers")?.objectForKey("mobile") as? String
    
            dispatch_async(dispatch_get_main_queue(), {
                marker.map = self.mapView
            })
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
