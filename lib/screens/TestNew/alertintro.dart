import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:potholedetection/screens/New/home.dart';
import 'package:potholedetection/screens/alertmode.dart';

class AlertIntro extends StatefulWidget {
  final String uid;
  AlertIntro(this.uid);
  @override
  _AlertIntroState createState() => _AlertIntroState();
}

class _AlertIntroState extends State<AlertIntro> {
  List<DocumentSnapshot> listtravel = List();
  List<DocumentSnapshot> newlist = List();
  List<DocumentSnapshot> newlist2 = List();
  bool isLoading = false;

  @override
  void initState() {
    getlist();
    super.initState();
  }

  getlist() async {
    QuerySnapshot querySnapshottravel =
        await Firestore.instance.collection("location_travel").getDocuments();
    listtravel = querySnapshottravel.documents;

    newlist = listtravel.reversed.toList();

    setState(() {
      isLoading = true;
    });
    print(listtravel);
    filterdata();
  }

  filterdata() {
    for (int i = 0; i < newlist.length; i++) {
      if (newlist[i].data["userid"] == widget.uid) {
        newlist2.add(newlist[i]);
      }
    }
  }

  sortbydate(listn) {
    Comparator<DocumentSnapshot> sortById =
        (a, b) => a.data["timeStamp"].compareTo(b.data["timeStamp"]);
    listn.sort(sortById);
    return listn;
  }

  // Widget _showLoading() {
  //   return showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Center(
  //         child: Container(
  //           child: Image(
  //                 width: 200,
  //                 height: 200,
  //                 image: AssetImage(
  //                   'assets/bgimages/lock.png',
  //                 ),
  //               ),
  //         ),
  //       );
  //     },
  //   );
  // }

  bool checkdata() {
    newlist2 = sortbydate(newlist2);

    // for(int i=0; i<newlist2.length; i++)
    // {
    //   if(newlist2[i].data["timeStamp"].toDate().isBefore(DateTime.now().subtract(const Duration(days: 14))))
    //   {

    //   }
    // }
    if (newlist2.length > 10 && 
        newlist2[newlist2.length - 1]
            .data["timeStamp"]
            .toDate()
            .isAfter(DateTime.now().subtract(const Duration(days: 14)))) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget locked = Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFDA4453),
              Color(0xFF89216B),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  width: 200,
                  height: 200,
                  image: AssetImage(
                    'assets/bgimages/lock.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(
                      "Alert mode is a special mode made by  us to thank you for recording potholes and helping us grow our reach. Use this mode when you are travelling, and our app will give you a voice notification if there is a pothole near you.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 17.0,
                      )),
                ),
              ],
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                    side: BorderSide(color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AlertMode(widget.uid)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            )
          ],
        ));

    return WillPopScope(
      onWillPop: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(widget.uid, "2")));
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFF89216B),
            title: new Center(
                child: new Text("ALERT MODE", textAlign: TextAlign.center)),
          ),
          body: (!isLoading) ? Center(child: CircularProgressIndicator()) 
          // : (checkdata()) ? 
          // 
          
                  
                  //  _showLoading()
               : Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFFDA4453),
                            Color(0xFF89216B),
                          ],
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  width: 140,
                                  height: 140,
                                  image: AssetImage(
                                    'assets/bgimages/testalert.png',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Text(
                                      "Alert mode is a special mode made by  us to thank you for recording potholes and helping us grow our reach. Use this mode when you are travelling, and our app will give you a voice notification if there is a pothole near you.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 17.0,
                                      )),
                                ),
                              ],
                            )),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: FlatButton(
                                color: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0),
                                    side: BorderSide(color: Colors.white)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AlertMode(widget.uid)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text(
                                    'GET STARTED',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40.0,
                            )
                          ]))
          ),
    );
  }
}
