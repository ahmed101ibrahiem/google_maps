import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  var myMarker = HashSet<Marker>(); // collection
  Set<Polygon> myPolygon() {
    var polygonCoords =  <LatLng>[];
    polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));
    polygonCoords.add(LatLng(37.43006265331129, -122.08832357078792));
    polygonCoords.add(LatLng(37.43006265331129, -122.08332357078792));
    polygonCoords.add(LatLng(37.43296265331129, -122.08832357078792));

    Set<Polygon> polygonSet =  <Polygon>{};
    polygonSet.add(Polygon(
        polygonId: PolygonId('test'),
        points: polygonCoords,

        strokeColor: Colors.red));

    return polygonSet;
  }

  Set<Circle> circles = {  Circle(
    fillColor: Colors.blue.shade50,
    strokeColor: Colors.lightBlueAccent,
    strokeWidth: 3,
    circleId: CircleId('1'),
    center: LatLng(30.91201499149806, 31.57850452584796),
    radius: 9000,
  )};

  myPolyLine(){
    var point = <LatLng>[];
    point.add(LatLng(30.91201499149806, 31.57850452584796));
    point.add(LatLng(30.882754067321617, 31.460233233335458));
    var point2 = <LatLng>[];
    point.add(LatLng(30.91201499149806, 31.57850452584796));
    point.add(LatLng(30.94235003487579, 31.527495588985346));
    var myPolylyne = <Polyline>{};
    myPolylyne.add(Polyline(
      color: Colors.red,
      width: 4,
      points: point,
      polylineId: PolylineId('1'),
      patterns: [PatternItem.dash(16.0),PatternItem.gap(10.0)]
    ),);
    myPolylyne.add(Polyline(polylineId: PolylineId('2'),points: point2,
        color: Colors.green,
        width: 8,
      patterns: [PatternItem.dash(20.0),PatternItem.gap(16.0)]
        ));
    return myPolylyne;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Google Maps'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(30.91201499149806, 31.57850452584796),
              zoom: 13.0,
            ),
            onMapCreated: (GoogleMapController goMapController) {
              setState(() {
                myMarker.add(Marker(
                  markerId: MarkerId('1'),
                  position: LatLng(30.91201499149806, 31.57850452584796),
                  infoWindow: InfoWindow(
                    title: 'Learn Maps',
                    snippet: 'how to create google maps in your flutter project.',
                    onTap: (){
                      print('Learn maps');
                    }
                  )
                ));
              });
            },
            markers: myMarker,
            polygons: myPolygon(),
            circles: circles,
            polylines: myPolyLine(),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.bottomCenter,
            child: Text(
              'Elsab3 Maps',
              style: TextStyle(color: Colors.red, fontSize: 40),
            ),
          )
        ],
      ),
    );
  }
}
