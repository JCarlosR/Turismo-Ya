import UIKit
import Alamofire
import GoogleMaps
import RealmSwift

class MapAndPlacesVController: UIViewController, ShowPlaceInfoDelegate {

    var placesList = PlacesList()
    var selectedCategoryId: Int16 = 0
    
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet weak var tableViewPlaces: UITableView!
    
    let defaultZoom: Float = 13
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // remove padding top (table view places)
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.placesList.delegate = self
        loadPlaces()
    }

    func loadPlaces() {
        // setup table view of places
        tableViewPlaces.dataSource = placesList
        tableViewPlaces.delegate = placesList
        tableViewPlaces.rowHeight = UITableViewAutomaticDimension
        tableViewPlaces.estimatedRowHeight = 320
        
        if Connectivity.isConnectedToInternet() {
            // load the places of the category \(selectedCategoryId)
            Alamofire.request(Global.urlPlaces + "&idLinea=\(selectedCategoryId)").responseJSON { response in
                
                // print("Places result:", response.result)
                
                if let result = response.result.value {
                    let placesData: NSArray = result as! NSArray
                    for placeData: NSDictionary in placesData as! [NSDictionary] {
                        let place = Place()
                        place.id = Int16(placeData["idProducto"]! as! String)!
                        place.idSubLinea = Int16(placeData["idSubLinea"]! as! String)!
                        place.abrev = placeData["Abrev"]! as! String
                        place.idValoracion = Int16(placeData["idValoracion"]! as! String)!
                        place._descripcion = placeData["Descripcion"]! as! String
                        place.telefono = placeData["Telefono"] as? String ?? ""
                        place.website = placeData["Website"]! as? String ?? ""
                        place.address = placeData["Direccion"]! as? String ?? ""
                        
                        place.horaAbre = placeData["HoraAbierto"]! as? String ?? ""
                        place.horaCierra = placeData["HoraCierre"]! as? String ?? ""
                        place.tenedor = placeData["Tenedor"]! as? String ?? ""
                        
                        place.latitud = placeData["Latitud"]! as! String
                        place.longitud = placeData["Altitud"]! as! String
                        place.imageUrl = placeData["Imagen"]! as! String
                        
                        self.placesList.addPlace(place: place)
                    }
                    
                    self.tableViewPlaces.reloadData()
                    self.setupMarkers()
                    
                    // persist data
                }
            }
        } else {
            let realm = try! Realm()
            // print("read Place objects from realm")
            let places = realm.objects(Place.self).filter("idLinea = '\(selectedCategoryId)'")
            //
            self.placesList.places = Array(places)
            self.placesList.filteredPlaces = Array(places)
            
            self.tableViewPlaces.reloadData()
            self.setupMarkers()
        }
        
        
    }
    
    func setupMarkers() {
        if self.placesList.places.count > 0 {
            let latitudeCenter = Double(self.placesList.places[0].latitud)!
            let longitudeCenter = Double(self.placesList.places[0].longitud)!
            let camera = GMSCameraPosition.camera(withLatitude: latitudeCenter,
                                                  longitude: longitudeCenter, zoom: self.defaultZoom)
            
            self.mapView.camera = camera
            
            for place in self.placesList.places {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: Double(place.latitud)!, longitude: Double(place.longitud)!)
                marker.snippet = place.abrev
                marker.appearAnimation = GMSMarkerAnimation.pop
                marker.map = self.mapView
            }
        }
    }
    
    var place: Place?
    func didSelectPlace(place: Place) {
        self.place = place
        performSegue(withIdentifier: "fromMapShowPlaceInfoSegue", sender: self)
    }
    
    // pass parameters via segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromMapShowPlaceInfoSegue" {
            if let destinationVC = segue.destination as? PlaceInfoViewController {
                destinationVC.place = self.place
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
 

}
