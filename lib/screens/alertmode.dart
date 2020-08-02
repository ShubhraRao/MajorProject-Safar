import 'dart:async';
import 'dart:io';
// import 'package:audioplayers/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:potholedetection/screens/New/home.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class AlertMode extends StatefulWidget {
  final String uid;

  const AlertMode(this.uid);
  @override
  _AlertModeState createState() => _AlertModeState();
}

class _AlertModeState extends State<AlertMode>
    with SingleTickerProviderStateMixin {
  List<DocumentSnapshot> listtravel = List();
  List<DocumentSnapshot> newlist = List();
  List<DocumentSnapshot> listimage = List();
  List<LocList> listloc = List();
  // double dist;
  bool isLoading = false;
  Position position;
  int alerting = 0;
  AnimationController _animationController;
  Timer timer;
  int check = 1;
  // Widget color=color:Colors.blue;
  Widget wid = Container(color: Colors.blue);
  final player = AudioPlayer();

  initState() {
    getlist();
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat();
    getLocation();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => getLocation());
    

    super.initState();
  }

  getlist() async {
    QuerySnapshot querySnapshottravel =
        await Firestore.instance.collection("location_travel").getDocuments();
    listtravel = querySnapshottravel.documents;
    newlist = listtravel;
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    print(listtravel);
    print(newlist.length);
    putinlist();
  }

  getLocation() async {
    await player.setAsset('assets/alerting.mp3');
    Position _position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (!mounted) return;
    setState(() {
      position = _position;
    });
    int check = 0;
    for (int i = 0; i < listloc.length; i++) {
      double newd;
      // print(i);
      // print(listloc[i].lat);
      newd = calculateDistance(position.latitude, position.longitude,
          listloc[i].lat, listloc[i].lon);
      print(newd);
      if (newd < 1.08
          // )
          &&
          newd > 1.06) {
        print(newd);
        check = 1;
        break;
      } else {
        check = 0;
      } 
    }
    // print("Checkkkk");
    // print(check);
    if (check == 1) {
      if (!mounted) return;
      setState(() {

        //  print(newd);
        alerting = 1;
        Vibrate.vibrate();
        player.play();
      });
      print("Truee");
      return;

      // await

    } else {
      // if (!mounted) return;
      setState(() {
        wid = Container(
          color: Colors.blue,
        );
        alerting = 0;
      });
    }
    // }ss
    setState(() {
      alerting = 0;
    });
  }

  putinlist() {
    print("Putinlist");
    newlist.forEach((element) {
      listloc.add(LocList(element.data["lat"], element.data["lon"]));
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    // if(mounted) return
    if (check == 1) {
      // getLocation();
    }

    return Scaffold(
        body: new Stack(children: <Widget>[
      new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/bgimages/wallpaperdesign.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Center(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (alerting == 1)
                      ? Image(image: AssetImage("assets/bgimages/alerty.png"))
                      : Image(
                          image: AssetImage("assets/bgimages/alertybw.png")),
                ]),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 200.0,
                child: FlatButton(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                        side: BorderSide(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child:
                          Text("STOP", style: TextStyle(color: Colors.white)),
                    ),
                    onPressed: () async {
                      setState(() {
                        timer?.cancel();
                        check = 0;
                      });
                      await player.dispose();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(widget.uid, "2")));
                    }),
              )),
          SizedBox(height: 50.0)
        ],
      ))
    ]));
  }
  //     Column(children: <Widget>[
  //       Expanded(
  //   //     SizedBox(
  //   //       height: MediaQuery.of(context).size.height - 0.5,
  //   //       width: MediaQuery.of(context).size.width,
  //   child: wid,
  //       ),
  //   // Expanded(
  //       // child:
  //        Align(
  //           alignment: Alignment.bottomCenter,
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(vertical: 16.0),
  //             child: RaisedButton(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(0),
  //                 side: BorderSide(color: Color(0XFFFCD42B)),
  //               ),
  //               onPressed: () {

  //     setState(() {
  //       timer?.cancel();
  //       check = 0;
  //     });
  //    Navigator.push(context,
  // MaterialPageRoute(builder: (context) => HomePage(widget.uid)));
  //       },
  //               padding: EdgeInsets.all(12),
  //               color: Colors.white,
  //               child: Text('STOP',
  //                   style: TextStyle(color: Colors.black, fontSize: 16)),
  //             ),
  //           // )
  //           ))
  // ]));
  // }

  void deactivate() {}

  @override
  void dispose() {
    timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }
}

class LocList {
  double lat;
  double lon;

  LocList(this.lat, this.lon);
}
