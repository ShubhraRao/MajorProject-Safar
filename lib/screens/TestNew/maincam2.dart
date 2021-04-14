//BACK UP SENSOR

  //     if (list.length != null) {
  //       print("Step1");
  //       for (int i = 0; i < list.length; i++) {
  //         uidarr = list[i].data["userid"].split(",");
  //         String u = list[i].data["userid"];
  //         if (list[i].data["lat"].toString().substring(0, 7) ==
  //                     loc_lat.toString().substring(0, 7) &&
  //                 list[i].data["lon"].toString().substring(0, 7) ==
  //                     loc_lon.toString().substring(0, 7) ||
  //             list[i].data["address"] == current_address) {
  //           var p = list[i].data["NumberOfReportings"];
  //           int j;
  //           for (j = 0; j < uidarr.length; j++) {
  //             if (uidarr[j] == uid) break;
  //           }
  //           if (j == uidarr.length) {
  //             databaseReference
  //                 .collection("location_travel")
  //                 .document(list[i].documentID)
  //                 .updateData({
  //               "uid": u + "," + uid,
  //               "NumberOfReportings": p + 1,
  //               "timeStamp": DateTime.now(),
  //             }).then((_) {
  //               print("update success!");
  //             });
  //             break;
  //           }
  //           // else if (list[i].data["lat"].toString().substring(0, 7) ==
  //           //             loc_lat.toString().substring(0, 7) &&
  //           //         list[i].data["lon"].toString().substring(0, 7) ==
  //           //             loc_lon.toString().substring(0, 7) &&
  //           //         list[i].data["userid"] == uid ||
  //           //     list[i].data["address"].toString() == current_address &&
  //           //         list[i].data["userid"] == uid) {
  //           //   print("DO NOT UPDATE");
  //           //   break;
  //           //   // break;
  //           // }
  //         } else if (list[i].data["lat"].toString().substring(0, 7) ==
  //                     loc_lat.toString().substring(0, 7) &&
  //                 list[i].data["lon"].toString().substring(0, 7) ==
  //                     loc_lon.toString().substring(0, 7) ||
  //             list[i].data["address"].toString() == current_address) {
  //           int j;
  //           for (j = 0; j < uidarr.length; j++) {
  //             if (uidarr[j] == uid) break;
  //           }
  //           if (j < uidarr.length - 1) {
  //             print("DO NOT UPDATE");
  //             break;
  //           }
  //         } else {
  //           check = 1;
  //         }
  //       }
  //     } else {
  //       uploadData(uid, loc_lat2, loc_lon2, time, loc_pin, current_address,
  //           place, 1, spriority, sdesc);
  //     }
  //     if (check == 1) {
  //       var priority = 1;

  //       uploadData(uid, loc_lat2, loc_lon2, time, loc_pin, current_address,
  //           place, priority, spriority, sdesc);
  //     }
  //     _image = null;
  //     pothole = 0;
  //   });
  // }
