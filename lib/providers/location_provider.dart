import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';




class LocationProvider with ChangeNotifier{
  Location _location=  new Location();
  Location get location =>_location;
  LatLng _locationPostion= new LatLng(-12.090437, -77.0672179) ;
  LatLng get locationPosition =>_locationPostion;
  LatLng ?_destination;
  LatLng get destination=>_destination==null?locationPosition:_destination!;

  bool locationServiceActive = true;

  LocationProvider(){
    _location=  new Location();
  }

  initialization() async {
      await getUserLocation();
  }

  set destination(LatLng destination){
    notifyListeners();
    _destination=destination;

  }

 
  getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _perimissionGranted;
    _serviceEnabled= await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled= await location.requestService();
      if(!_serviceEnabled){
        return ;
      }
    }
    _perimissionGranted= await location.hasPermission();
    if(_perimissionGranted==PermissionStatus.denied){
      _perimissionGranted=await location.requestPermission();
      if(_perimissionGranted != PermissionStatus.granted){
        return ;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      _locationPostion=LatLng( currentLocation.latitude! , currentLocation.longitude! );

      notifyListeners();
     });
  }

  
}