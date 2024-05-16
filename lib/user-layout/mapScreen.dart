import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  MapScreen(this.latitude, this.longitude);
String latitude;
String longitude;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Location')),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(widget.latitude), double.parse(widget.longitude)), // Replace with your initial position
                zoom: 12,
              ),
              onTap: (latLng){
                print(latLng);
                setState(() {
                  markers.add(Marker(
                    markerId: MarkerId(latLng.toString()),
                    position: latLng,
                  ));
                });
            
              },
            
              markers: markers,
            ),
          ),
          Expanded(child: Container())
        ],
      ),
      
    );
  }


}