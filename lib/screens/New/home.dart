import 'package:flutter/material.dart';
import 'package:potholedetection/screens/TestNew/alerttry.dart';
import 'package:potholedetection/screens/dashboard.dart';
import 'package:potholedetection/screens/maps.dart';
import 'package:potholedetection/screens/newtravel.dart';
import 'package:potholedetection/travelstart.dart';
import 'package:potholedetection/screens/TestNew/travintro.dart';
import 'package:potholedetection/screens/TestNew/camintro.dart';
// import 'package:potholedetection/screens/TestNew/alertintro.dart';

class HomePage extends StatefulWidget {
  final String uid, ind;
  HomePage(this.uid, this.ind);
  @override
  _HomePageState createState() => _HomePageState(this.uid, this.ind);
}

class _HomePageState extends State<HomePage> {
  
  final String uid, ind;
  int _selectedItemIndex;

  _HomePageState(this.uid, this.ind);

  @override
  void initState() {
    // TODO: implement initState
    _selectedItemIndex = int.parse(ind);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final List pages = [
      // TravelStart(uid),
      TravelIntro(uid),
      // CameraMode(uid),
      CameraIntro(uid),
      MainDashboard(uid),
      // AlertMode("50"),
      AlertIntro(uid),
      ViewMap(uid: uid),
      // TestOnboardingScreen()
    ];

    return Scaffold(
        bottomNavigationBar: Row(
          children: <Widget>[
            buildNavBarItem(
              Icons.directions_car,
              0,
            ),
            buildNavBarItem(
              Icons.photo_camera,
              1,
            ),
            buildNavBarItem(
              Icons.home,
              2,
            ),
            buildNavBarItem(
              Icons.warning,
              3,
            ),
            buildNavBarItem(
              Icons.pin_drop,
              4,
            ),
          ],
        ),
        body: pages[_selectedItemIndex]);
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 5,
        decoration: BoxDecoration(
          color:
              // (index == _selectedItemIndex) ? Colors.red :
              Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(
              bottom: (index == _selectedItemIndex) ? 7.0 : 0.0),
          child: Icon(
            icon,
            color: index == _selectedItemIndex ? Color(0xFF89216B) : Colors.grey,
            size: 25.0,
          ),
        ),
      ),
    );
  }
}
