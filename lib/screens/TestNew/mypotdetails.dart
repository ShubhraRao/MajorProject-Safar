import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import 'mapsingle.dart';


class MyPotDetails extends StatefulWidget {
  final String uid;
  final DocumentSnapshot list;

  const MyPotDetails({Key key, this.list, this.uid}) : super(key: key);
  @override
  _MyPotholesState createState() => _MyPotholesState(list);
}

class _MyPotholesState extends State<MyPotDetails> {
  final DocumentSnapshot list;

  _MyPotholesState(this.list);

  void initState(){
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(list.data["lon"]);
    print(list.data["status"]);
    return Scaffold(
        appBar: AppBar(
           flexibleSpace: Container(
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
      ),
          title: Text("Details"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewMapSingle(
                              uid: widget.uid,
                              reclat: list.data["lat"],
                              reclon: list.data["lon"],
                            )));
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Column(
          children: <Widget>[
            (list.data["status"]!=null) ? DataTable(
              columns: [
                DataColumn(label: Text("DETAILS")),
                DataColumn(label: SizedBox(height: 0.0))
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("Address: ")),
                  DataCell(Text(list.data["address"])),
                ]),
                DataRow(cells: [
                  DataCell(Text("Date: ")),
                  DataCell(
                    Text(Jiffy(DateTime.parse(
                            list.data["timeStamp"].toDate().toString()))
                        .yMMMMEEEEdjm),
                  ),
                ]),
                
              DataRow(cells: [
                  DataCell(Text("Source: ")),
                  (list.data['source'] == "Sensor" || list.data['Source'] == "Sensor" || list.data['source'] == "sensor" || list.data['Source'] == "sensor") ?
                  DataCell(Text("Travel Mode")) : 
                  DataCell(
                    (list.data["SurveyPriority"]!=null)?
                    Text("Camera Mode (" + list.data["SurveyPriority"].toString().toUpperCase() +" PRIORITY)"): Text("Camera Mode")) 
                ]),
                DataRow(cells: [
                  DataCell(Text("Status: ")),
                  DataCell(Column(
                    children: <Widget>[
                      (list.data["erSeen"] == "YES") ? Text("ER Seen") : Text(""),
                      (list.data["status"] == "STARTED") ? Text("Fixing in progress") : Text("Pending"),
                    ],
                  )
                    ),
                ]),
          ],
        ) :

        DataTable(
              columns: [
                DataColumn(label: Text("DETAILS")),
                DataColumn(label: SizedBox(height: 0.0))
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("Address: ")),
                  DataCell(Text(list.data["address"])),
                ]),
                DataRow(cells: [
                  DataCell(Text("Date: ")),
                  DataCell(
                    Text(Jiffy(DateTime.parse(
                            list.data["timeStamp"].toDate().toString()))
                        .yMMMMEEEEdjm),
                  ),
                ]),
                
              DataRow(cells: [
                  DataCell(Text("Source: ")),
                  (list.data['source'] == "Sensor" || list.data['Source'] == "Sensor" || list.data['source'] == "sensor" || list.data['Source'] == "sensor") ?
                  DataCell(Text("Travel Mode")) : 
                  DataCell(
                    (list.data["SurveyPriority"]!=null)?
                    Text("Camera Mode (" + list.data["SurveyPriority"].toString().toUpperCase() +" PRIORITY)"): Text("Camera Mode")) 
                ]),
                DataRow(cells: [
                  DataCell(Text("Status: ")),

                  DataCell(Column(
                    children: <Widget>[
                      (list.data["erSeen"] == "YES") ? Text("ER Seen") : Text(""),
                      Text("Pending"),
                    ],
                  )),
                ]),
                
          ],
        )

          ])]
          ));
  }
}
