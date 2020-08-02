import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:potholedetection/screens/New/home.dart';
import 'package:potholedetection/screens/try2.dart';
import 'package:potholedetection/screens/maps.dart';
import 'package:potholedetection/screens/fixedmap.dart';

class UserMap extends StatelessWidget {
  final String uid;

  const UserMap({Key key, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(uid, "5")));
      },
      child: MaterialApp(
        title: "Safar",
        debugShowCheckedModeBanner: false,
        home: UserMapPage(uid),
      ),
    );
  }
}

class UserMapPage extends StatefulWidget {
  final String uid;
  UserMapPage(this.uid);
  // const ViewMapPage({Key key, this.uid}) : super(key: key);
  @override
  _UserMapPageState createState() => _UserMapPageState(uid);
}

class _UserMapPageState extends State<UserMapPage> {
  final String uid;
  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Marker> allMarkers = [];
  double lat, lon;
  double lat1, lon1;

  GoogleMapController _controller;
  QuerySnapshot querySnapshot;
  QuerySnapshot querySnapshot1;
  bool isLoading = false;

  _UserMapPageState(this.uid);

  @override
  void initState() {
    super.initState();

    getLocTravel().then((results1) {
      setState(() {
        querySnapshot1 = results1;
        print(querySnapshot1.documents);
        isLoading = true;
      });
    });
  }

  // getLat() {
  //   int len = querySnapshot.documents.length;
  //   print(len);
  //   for (int i = 0; i < len; i++) {
  //     if (querySnapshot.documents[i].data['userid'] == widget.uid) {
  //       lat1 = parseDouble(querySnapshot.documents[i].data['lat']);
  //       lon1 = parseDouble(querySnapshot.documents[i].data['lon']);
  //       print(lat1);
  //       print("Helloo");
  //       print(querySnapshot.documents[i].data['userid']);
  //       print(lon1);
  //       print(lat1.runtimeType);
  //       print(lon1.runtimeType);

  //       allMarkers.add(Marker(
  //           markerId: MarkerId(i.toString()),
  //           draggable: true,
  //           onTap: () {
  //             _scaffoldKey.currentState.showSnackBar(SnackBar(
  //               content: Text("Pothole!"),
  //             ));
  //             // Navigator.push(context, MaterialPageRoute(builder: (context) => ShowData()));
  //             CameraPosition(target: LatLng(lat1, lon1), zoom: 12.0);
  //           },
  //           position: LatLng(lat1, lon1)));
  //     }
  //   }
  //   print(allMarkers);
  // }

  getLon() {
    // print("Uid: " + widget.uid);
    int len = querySnapshot1.documents.length;
    print(len);
    for (int i = 0; i < len; i++) {
      if (querySnapshot1.documents[i].data['userid'] == uid) {
        lat1 = parseDouble(querySnapshot1.documents[i].data['lat']);
        lon1 = parseDouble(querySnapshot1.documents[i].data['lon']);
        // print(lat1);
        // print(lon1);
        // print(lat1.runtimeType);
        // print(lon1.runtimeType);

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

  getLocTravel() async {
    return await Firestore.instance
        .collection('location_travel')
        .getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    if (querySnapshot1 != null) {
      //   print("AAadsadadd");
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
                                      ViewMap()));
                        },
                        child: Text("ALL")),
                    RaisedButton(
                        color: Colors.blue[400],
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewMap()));
                        },
                        child: Text("YOU")),
                    RaisedButton(
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

