import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';

class SharedImageProvider extends ChangeNotifier {
  List<dynamic> stackWidgets = [];
  double posx = 10.0;
  double posy = 10.0;

  void setpositions(double x, double y) {
    posx = x;
    posy = y;
    notifyListeners();
  }

  removeLast() {
    if (stackWidgets.length > 1) {
      stackWidgets.removeLast();
    }
    notifyListeners();
  }

  void addTapWidgets() {
    stackWidgets.add(Positioned(
        left: posx,
        top: posy,
        child: Container(
          height: 10,
          width: 10,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        )));
    notifyListeners();
  }

  clearWidgets() {
    stackWidgets.clear();
    notifyListeners();
  }

  addwidgets(double width, File photo, VoidCallback onTap) {
    if (stackWidgets.isEmpty) {
      stackWidgets.add(Material(
        color: Color.fromARGB(0, 26, 14, 14),
        child: Container(
          height: 500,
          width: 100.w,
          child: GestureDetector(
            onTapDown: (details) {
              print(details.localPosition.dx);
              //global position
              print(details.localPosition.dy);
              // setState(() {
              posx = details.localPosition.dx;
              posy = details.localPosition.dy;
              setpositions(details.localPosition.dx, details.localPosition.dy);
              print(stackWidgets.length);
              addTapWidgets();
            },
            onTap: onTap,
            child: PhotoView(
              imageProvider: FileImage(photo, scale: 1.0),
            ),
          ),
        ),
      ));
    } else {
      addTapWidgets();
    }

    // if (stackWidgets.contains(
    //   Material(
    //     color: Color.fromARGB(0, 26, 14, 14),
    //     child: Container(
    //       height: 500,
    //       width: 100.w,
    //       child: GestureDetector(
    //         onTapDown: (details) {
    //           print(details.localPosition.dx);
    //           //global position
    //           print(details.localPosition.dy);
    //           // setState(() {
    //           posx = details.localPosition.dx;
    //           posy = details.localPosition.dy;
    //           setpositions(details.localPosition.dx, details.localPosition.dy);
    //           print(stackWidgets.length);
    //           addTapWidgets();
    //         },
    //         onTap: onTap,
    //         child: Image.file(
    //           photo,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //     ),
    //   ),
    // )) {
    //   addTapWidgets();
    // } else {
    //   stackWidgets.add(
    //     Material(
    //       color: Color.fromARGB(0, 26, 14, 14),
    //       child: Container(
    //         height: 500,
    //         width: 100.w,
    //         child: GestureDetector(
    //           onTapDown: (details) {
    //             print(details.localPosition.dx);
    //             //global position
    //             print(details.localPosition.dy);
    //             // setState(() {
    //             posx = details.localPosition.dx;
    //             posy = details.localPosition.dy;
    //             setpositions(
    //                 details.localPosition.dx, details.localPosition.dy);
    //             print(stackWidgets.length);
    //             addTapWidgets();
    //             // setState(() {
    //             //   stackWidgets.add(Positioned(
    //             //       left: posx,
    //             //       top: posy,
    //             //       child: Container(
    //             //         height: 10,
    //             //         width: 10,
    //             //         decoration: BoxDecoration(
    //             //             shape: BoxShape.circle, color: Colors.white),
    //             //       )));
    //             // });
    //             //local position
    //           },
    //           onTap: onTap,
    //           child: Image.file(
    //             photo,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }
    notifyListeners();
  }

  int get widgetsLength => stackWidgets.length;

  List get widgetList => stackWidgets;
}
