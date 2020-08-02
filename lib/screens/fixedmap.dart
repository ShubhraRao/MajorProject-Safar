import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:potholedetection/screens/New/home.dart';
import 'package:potholedetection/screens/try2.dart';
import 'package:potholedetection/screens/maps.dart';
import 'package:potholedetection/screens/usermap.dart';

class FixedMap extends StatelessWidget {
  final String uid;

  const FixedMap({Key key, this.uid}) : super(key: key);
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
        home: FixedMapPage(),
      ),
    );
  }
}

class FixedMapPage extends StatefulWidget {
  final String uid;

  const FixedMapPage({Key key, this.uid}) : super(key: key);
  @override
  _FixedMapPageState createState() => _FixedMapPageState();
}

class _FixedMapPageState extends State<FixedMapPage> {
  BitmapDescriptor pinLocationIcon;
  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> dropdownSort = [
    'Priority',
    'Oldest to Newest',
    'Newest to Oldest'
  ];
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
    setCustomMapPin();
    getLocImage().then((results) {
      setState(() {
        querySnapshot = results;
        print(querySnapshot.documents);
      });
    });

    getLocTravel().then((results1) {
      setState(() {
        querySnapshot1 = results1;
        print(querySnapshot1.documents);
        isLoading = true;
      });
    });
  }

   void setCustomMapPin() async {
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/bgimages/destination_map_marker.png');
   }

  getLat() {
    int len = querySnapshot.documents.length;
    print(len);
    for (int i = 0; i < len; i++) {
      lat1 = parseDouble(querySnapshot.documents[i].data['lat']);
      lon1 = parseDouble(querySnapshot.documents[i].data['lon']);
      print(lat1);
      print(lon1);
      print(lat1.runtimeType);
      print(lon1.runtimeType);

      allMarkers.add(Marker(
          markerId: MarkerId(i.toString()),
          draggable: true,
          onTap: () {
            // _scaffoldKey.currentState.showSnackBar(SnackBar(
            //   content: Text("Pothole!"),
            // ));
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ShowData()));
            CameraPosition(target: LatLng(lat1, lon1), zoom: 12.0);
          },
          position: LatLng(lat1, lon1)));
    }
    print(allMarkers);
  }

  getLon() {
    int len = querySnapshot1.documents.length;
    print(len);
    for (int i = 0; i < len; i++) {
      lat1 = parseDouble(querySnapshot1.documents[i].data['lat']);
      lon1 = parseDouble(querySnapshot1.documents[i].data['lon']);
      print(lat1);
      print(lon1);
      print(lat1.runtimeType);
      print(lon1.runtimeType);

      allMarkers.add(Marker(
          markerId: MarkerId(i.toString()),
          draggable: true,
          onTap: () {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Pothole!"),
            ));
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ShowData()));
            CameraPosition(target: LatLng(lat1, lon1), zoom: 12.0);
          },
          position: LatLng(lat1, lon1)));
    }
    print(allMarkers);
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

  getLocImage() async {
    return await Firestore.instance.collection('fixed_potholes').getDocuments();
  }

  getLocTravel() async {
    return await Firestore.instance
        .collection('fixed_potholes')
        .getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    LatLng pinPosition = LatLng(37.3797536, -122.1017334);
    if (querySnapshot != null) {
      print("AAadsadadd");
      getLat();
      getLon();
    }
    // getLat();
    return (!isLoading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
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
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserMap(uid: widget.uid)));
                        },
                        child: Text("ALL")),
                    RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserMap(uid: widget.uid)));
                        },
                        child: Text("YOU")),
                    RaisedButton(
                      color: Colors.blue[400],
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FixedMap()));
                        },
                        child: Text("FIXED")),
                  ],
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