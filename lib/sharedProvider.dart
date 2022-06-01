import 'dart:io';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';

class SharedImageProvider extends ChangeNotifier {
  List<dynamic> stackWidgets = [];
  double? posx;
  double? posy;
  List<dynamic> positions = [];

  void setpositions(double x, double y) {
    posx = x;
    posy = y;
    notifyListeners();
    positions.add({
      "posx": posx,
      "posy": posy,
    });
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

  // updatePositions(x, y) {
  //   // for
  //   // for (var i = 0; i < positions.length; i++) {
  //   //   positions[i]["posx"] += x;
  //   //   positions[i]["posy"] += y;
  //   //   notifyListeners();
  //   // }
  // }

  ZeroPositions(x, y) {
    // for (var i = 0; i < positions.length; i++) {
    //   positions[i]["posx"] = x;
    //   positions[i]["posy"] = y;
    //   notifyListeners();
    // }
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
              // print(details.localPosition.dx);
              //global position
              // print(details.localPosition.dy);
              // setState(() {
              posx = details.localPosition.dx;
              posy = details.localPosition.dy;

              setpositions(details.localPosition.dx, details.localPosition.dy);
              // print(stackWidgets.length);
              // print(positions.length);
              // print(positions);
              addTapWidgets();
            },
            onTap: onTap,
            child: Zoom(
                width: 100.w,
                height: 100.h,
                maxZoomWidth: 1700,
                maxZoomHeight: 1700,
                // canvasColor: Colors.grey,
                // backgroundColor: Colors.orange,
                colorScrollBars: Colors.purple,
                opacityScrollBars: 0.4,
                scrollWeight: 0.0,
                // centerOnScale: true,
                enableScroll: true,
                doubleTapZoom: true,
                zoomSensibility: 2,
                initZoom: 0.0,
                onTap: () {
                  // print("Widget clicked");
                },
                onPositionUpdate: (Offset position) {
                  ZeroPositions(position.dx, position.dy);
                  // print(position);
                  // for (var i = 1; i < positions.length; i++) {
                  //   // setpositions(position.dx, position.dy);
                  //   print("abc => " + positions[i].toString());
                  // }
                  // updatePositions(position.dx, position.dy);
                  // print(posx);
                  // print(posy);
                },
                onScaleUpdate: (double scale, double zoom) {
                  // print("$scale  $zoom");
                },
                child: Image.file(
                  photo,
                  fit: BoxFit.cover,
                )),
            // onVerticalDragStart: (details) {
            //   print("onVerticalDragStart");
            //   print(details.localPosition.dy);
            // },
            // onVerticalDragEnd: (details) {
            //   print("onVerticalDragEnd");
            //   print(details.primaryVelocity);
            // },
            // onVerticalDragUpdate: (details) {
            //   print("onVerticalDragUpdate");
            //   print(details.delta);
            //   print(details.localPosition.dy);
            // },
            // child: PhotoView(
            //   imageProvider: FileImage(photo, scale: 1.0),
            // ),
          ),
        ),
      ));
    }
    // else {
    //   addTapWidgets();
    // }

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
