

import UIKit
import GoogleMaps
import ObjectMapper
class MapController: BaseController {
    var infoWindow = CustomInforWindowViewController()
       //var viewMaps: GMSMapView?
       var isShowInfo : Bool  = false
       let ARC4RANDOM_MAX   = 0x100000000
    var mountainList : [MountainModel] = [MountainModel]()


       @IBOutlet var viewMaps: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cameraPosition = GMSCameraPosition.camera(withLatitude:19.8507239, longitude: 105.2777759, zoom: 5.7)
        viewMaps.animate(to: cameraPosition)
                self.viewMaps.delegate = self
                    //self.navigationController?.navigationBar.isHidden = true
        //self.getDataPost()
        var jsonData = self.readJSONFromFile(fileName: "Mountain") as! NSDictionary
        let dict = jsonData["mountain"] as? Array<Any>
        for item in dict! {
            if let noti = Mapper<MountainModel>().map(JSONObject: item){
                
                    self.mountainList.append(noti)

            }
            
        }
        self.setMarker()

        print(mountainList.count)
    }
    
    
    func setMarker(){
        for i  in mountainList {
                let marker1 = GMSMarker()

            marker1.position = CLLocationCoordinate2D(latitude: Double(i.lat) as! CLLocationDegrees, longitude: Double(i.lng) as! CLLocationDegrees )
            marker1.title = i.name
            
                                                   marker1.snippet = ""
                                                   marker1.icon = UIImage(named: "ic_pin_mountain")
                                            //marker1.appearAnimation  = GMSMarkerAnimation.pop
                                                   marker1.map = self.viewMaps
              }
    }
    

    func showInfoWindow(for marker: GMSMarker) -> Void {
           let location = CLLocationCoordinate2D(latitude: 21.027763 , longitude: 105.834160)
          // self.tappedMarker = marker
           
           self.infoWindow = Bundle.main.loadNibNamed("CustomInforWindow", owner: self, options: nil)?.first as! CustomInforWindowViewController
           //self.infoWindow.delegate = self
        infoWindow.translatesAutoresizingMaskIntoConstraints = false
        self.infoWindow.layer.cornerRadius = 5.0
               self.infoWindow.center = viewMaps.projection.point(for: location)
               self.infoWindow.center.y -= ((self.navigationController?.navigationBar.frame.size.height)! + 20)
        

           DispatchQueue.main.async {
            self.viewMaps!.addSubview(self.infoWindow)
            print(self.infoWindow.frame.height)
           }
        
       }
    
    
    
     func readJSONFromFile(fileName: String) -> Any?
      {
          var json: Any?
          if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
              do {
                  let fileUrl = URL(fileURLWithPath: path)
                  // Getting data from JSON file using the file URL
                  let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                  json = try? JSONSerialization.jsonObject(with: data)
                
              } catch {
                  // Handle error here
              }
          }
        print(json)
          return json
      }

    
    
    
    func removeInfoWindow() -> Void {
        isShowInfo = false
        infoWindow.removeFromSuperview()
    }
}


extension MapController : GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("tapMaker")
//        if isShowInfo {
//
//            self.removeInfoWindow()
//            return true
//        }
        print(self.viewMaps.camera.zoom )
        if(self.viewMaps.camera.zoom > 6 && self.viewMaps.camera.zoom < 10){
            let cameraPosition = GMSCameraPosition.camera(withLatitude:marker.position.latitude + 0.5, longitude: marker.position.longitude, zoom: self.viewMaps.camera.zoom)
            viewMaps.animate(to: cameraPosition)

        }
        else if(self.viewMaps.camera.zoom  < 6){
            let cameraPosition = GMSCameraPosition.camera(withLatitude:marker.position.latitude+5, longitude: marker.position.longitude, zoom: 5)
            viewMaps.animate(to: cameraPosition)
        }
       
        else {
            let cameraPosition = GMSCameraPosition.camera(withLatitude:marker.position.latitude+0.5, longitude: marker.position.longitude, zoom: 8)
            viewMaps.animate(to: cameraPosition)

        }
        

       // self.showInfoWindow(for: marker)
        
        isShowInfo  = true
        self.viewMaps.selectedMarker = marker
        return true
    }
    
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        if isShowInfo {

            self.removeInfoWindow()
            
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if isShowInfo {

                   self.removeInfoWindow()
                   
               }
    }
    
    
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        if isShowInfo {

                          self.removeInfoWindow()
                          
                      }
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        
        let mountainController = MountainDetailController()
        mountainController.hidesBottomBarWhenPushed = true
        
        for (index, element) in mountainList.enumerated() {
            if(element.name == marker.title){
                mountainController.model = element
                self.navigationController?.pushViewController(mountainController, animated: true)

            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let placeMarker = marker

        let infoView = Bundle.main.loadNibNamed("CustomInforWindow", owner: self, options: nil)?.first as! CustomInforWindowViewController
           // infoView.nameLabel.text = placeMarker.place.name

//            if let photo = placeMarker.place.photo {
//                infoView.placePhoto.image = photo
//            } else {
//                infoView.placePhoto.image = UIImage(named: "generic")
//            }
        marker.tracksInfoWindowChanges = true;

        for (index, element) in mountainList.enumerated() {
            if(element.name == marker.title){
                infoView.lblTittile.text = marker.title
                switch element.difficult {
                case 3:
                    infoView.imgRatingStar.image = UIImage.init(named: "ic_3_star")
                    break
                case 4:
                    infoView.imgRatingStar.image = UIImage.init(named: "ic_4_star")

                    break
                case 5:
                    infoView.imgRatingStar.image = UIImage.init(named: "ic_5_star")

                    break
                default:
                    break
                }
                infoView.imgRatingStar.image =  infoView.imgRatingStar.image!.withRenderingMode(.alwaysTemplate)
                infoView.imgRatingStar.tintColor = .mainColor()
                infoView.lbContent.text = element.content
                infoView.lbHeight.text = "Độ cao: " + element.height
                infoView.delegate = self
                infoView.imgInfo.sd_setImage(with: URL(string: element.featured_image), placeholderImage: UIImage.init(named: "ic_place_holder"))
                
            }
        }
        
     

        

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
           view.addSubview(infoView)

            return view
        
    }
    
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}


extension MapController : CustomInfoWindowViewDelegate{
    func tappedViewBackground(_ view: CustomInforWindowViewController) {
        let mountainController = MountainDetailController()
        mountainController.hidesBottomBarWhenPushed = true
               self.navigationController?.pushViewController(mountainController, animated: true)
    }
    
    
}
