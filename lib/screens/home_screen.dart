import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Position _currentPosition;
  Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController myMapController;
  DatabaseReference driver = FirebaseDatabase.instance.reference();
  LatLng startP;
  bool block = true;
  bool check = true;
  bool status = false;
  StreamSubscription<Position> positionStream;
  void myPosition() async {
    print("position is called");
    // bool check = true;

    // if (block) {
    //   positionStream =
    //       Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high)
    //           .listen((Position position) {
    //     if (position != null) {
    //       // print(position.latitude.toString());
    //       driver.child("availableDriver").child("driver1").update({
    //         'lat': position.latitude,
    //         'lng': position.longitude,
    //       });
    //       // print("Speed maloon");
    //       if (check) {
    //         setState(() {
    //           _currentPosition = position;
    //           check = false;
    //         });
    //         print("Condition printed");
    //         print({_currentPosition.latitude, " with latlng "});
    //         CameraPosition newCameraPosition = CameraPosition(
    //           target: LatLng(
    //             _currentPosition.latitude,
    //             _currentPosition.longitude,
    //           ),
    //           zoom: 16,
    //         );
    //         myMapController.animateCamera(
    //           CameraUpdate.newCameraPosition(newCameraPosition),
    //         );
    //       }
    //       // Geofire.initialize("availableDriver");
    //       // Geofire.setLocation("12345", position.latitude, position.longitude);
    //       // setState(() {
    //       //   startP = LatLng(position.latitude, position.longitude);
    //       //   // _setAddress();
    //       //   // print("I can listen from here too");
    //       // });
    //     } else {
    //       print("its null bro");
    //     }
    //   });
    // }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      startP = LatLng(position.latitude, position.longitude);
      print(position.latitude);
      print(position.longitude);

      startP = LatLng(
        _currentPosition.latitude,
        _currentPosition.longitude,
      );
    });
    if (check && position != null) {
      check = false;
      print("Condition printed");
      print({_currentPosition.latitude, " with latlng "});
      CameraPosition newCameraPosition = CameraPosition(
        target: LatLng(
          _currentPosition.latitude,
          _currentPosition.longitude,
        ),
        zoom: 16,
      );
      myMapController.animateCamera(
        CameraUpdate.newCameraPosition(newCameraPosition),
      );
    }
    // _setAddress();
  }

  //Coding for custom truck icon
  Set<Marker> markers = Set<Marker>();
  void addMarker() {
    if (startP != null) {
      setState(() {
        markers.clear();
        markers.add(
          Marker(
              markerId: MarkerId("myPosition"),
              position: startP,
              icon: BitmapDescriptor.defaultMarker),
        );
      });
      // print(markers.length);
    }
  }

  BitmapDescriptor customIcon1;
  void createMarker(context) {
    if (customIcon1 == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'img/truck1.png')
          .then((icon) {
        setState(() {
          customIcon1 = icon;
        });
      });
    }
  }

  // void availableDriver() {
  //   driver.child("availableDriver").child("driver1").onValue.listen((event) {
  //     var snapshot = event.snapshot;
  //     print(snapshot.value);

  //     // print("Valued Changed");
  //   });
  // }

  void updateDriverStatus(value) {
    setState(() {
      status = value;
    });
    if (value) {
      positionStream =
          Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high)
              .listen((Position position) {
        if (position != null) {
          // print(position.latitude.toString());
          driver.child("availableDriver").child("driver1").update({
            'lat': position.latitude,
            'lng': position.longitude,
          });
        }
      });
      // driver.child("availableDriver").child("driver1").set({
      //   "lat": _currentPosition.latitude,
      //   "lng": _currentPosition.longitude
      // });

    } else {
      driver.child("availableDriver").child("driver1").remove();
      positionStream.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    // createMarker(context);
    // addMarker();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(0, 0), zoom: 16),
              // LatLng(28.2752954, 68.4350972), zoom: 16),
              onMapCreated: (GoogleMapController controller) {
                _googleMapController.complete(controller);
                myMapController = controller;

                // print("Better be printed");
                myPosition();
              },
              myLocationEnabled: true,
              markers: markers,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: FlutterSwitch(
                  activeColor: Colors.green,
                  inactiveColor: Colors.redAccent,
                  activeText: "Online",
                  inactiveText: "Offline",
                  value: status,
                  valueFontSize: 20.0,
                  width: 150,
                  borderRadius: 30.0,
                  showOnOff: true,
                  onToggle: (val) {
                    updateDriverStatus(val);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
