import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:potholedetection/screens/New/home.dart';
import 'package:potholedetection/screens/try2.dart';

class ViewMapSingle extends StatelessWidget {
  final double reclat, reclon;
  final String uid;

  const ViewMapSingle({Key key,this.uid, this.reclat, this.reclon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(uid, "2")));
      },
      child: MaterialApp(
        title: "Safar",
        debugShowCheckedModeBanner: false,
        home: ViewMapPage(reclat: reclat, reclon: reclon),
      ),
    );
  }
}

class ViewMapPage extends StatefulWidget {
  final double reclat, reclon;

  const ViewMapPage({Key key, this.reclat, this.reclon}) : super(key: key);
  @override
  _ViewMapPageState createState() => _ViewMapPageState();
}

class _ViewMapPageState extends State<ViewMapPage> {
  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Marker> allMarkers = [];
  double lat, lon;
  double lat1, lon1;

  GoogleMapController _controller;
  QuerySnapshot querySnapshot;
  QuerySnapshot querySnapshot1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print(widget.reclat);
    print(widget.reclon);
    allMarkers.add(Marker(
      position: LatLng(widget.reclat,widget.reclon), 
      markerId: MarkerId("pothole"),
          draggable: true,
          onTap: () {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Pothole!"),
            ));
          }));
   
  }


  
  double parseDouble(dynamic value) {
    try {
      if (value is String) {
        return double.parse(value);
      } else if (value is double) {
        return value;
      } else {
        return 0.0;
      }
    } catch (e) {
      // return null if double.parse fails
      return null;
    }
  }

  // getLocImage() async {
  //   return await Firestore.instance.collection('location_image').getDocuments();
  // }

  // getLocTravel() async {
  //   return await Firestore.instance
  //       .collection('location_travel')
  //       .getDocuments();
  // }

  @override
  Widget build(BuildContext context) {
  
    // getLat();
    return Scaffold(
            key: _scaffoldKey,
            // appBar: AppBar(
            //   title: Text('Maps'),
            // ),
            body: SafeArea(
              child: Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(12.9767, 77.5713), zoom: 10.0),
                    markers: Set.from(allMarkers),
                    onMapCreated: mapCreated,
                  ),
                ),
              ]),
            ),
          );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
}
