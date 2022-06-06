import 'dart:io';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sizer/sizer.dart';

class SharedImageProvider2 extends ChangeNotifier {
  List<dynamic> stackWidgets = [];
  double? posx;
  double? posy;
  List<dynamic> positions = [];

  Function(int, double, double)? callback;

  void setpositions(double x, double y) {
    posx = x;
    posy = y;
    notifyListeners();
    // positions.add({
    //   "posx": posx,
    //   "posy": posy,
    // });
  }

  void removeElement(i) {
    // widgetList.removeRange(i, widgetList.length);
    print(widgetList.length);
    widgetList.removeAt(1);
    positions.removeAt(i);
    notifyListeners();
  }

  void setCallback(Function(int, double, double)? callback) {
    this.callback = callback;
  }

  removeLast() {
    if (stackWidgets.length > 1) {
      stackWidgets.removeLast();
    }
    notifyListeners();
  }

  // void addTapWidgets(x,y) {
  //   stackWidgets.add(Positioned(
  //       left: posx,
  //       top: posy,
  //       child: Container(
  //         height: 10,
  //         width: 10,
  //         decoration:
  //             BoxDecoration(shape: BoxShape.circle, color: Colors.white),
  //       )));
  //   notifyListeners();
  // }
  void addTapWidgets(double x, double y) {
    var position = {"posx": x, "posy": y, "inposx": x, "inposy": y};

    positions.add(position);

    var index = positions.length - 1;

    // var p = Positioned(
    //     left: positions[index]["posx"],
    //     top: positions[index]["posy"],
    //     child: Draggable(
    //       childWhenDragging: Container(),
    //       feedback: Container(
    //         height: 15,
    //         width: 15,
    //         decoration:
    //             BoxDecoration(shape: BoxShape.circle, color: Colors.white),
    //       ),
    //       onDragEnd: (dragDetails) {
    //         posx = dragDetails.offset.dx;
    //         // if applicable, don't forget offsets like app/status bar
    //         posx = dragDetails.offset.dy;
    //       },
    //       child: Container(
    //         height: 15,
    //         width: 15,
    //         decoration:
    //             BoxDecoration(shape: BoxShape.circle, color: Colors.white),
    //       ),
    //     ));
    // stackWidgets.add(p);
    notifyListeners();
  }

  clearWidgets() {
    stackWidgets.clear();
    notifyListeners();
  }

  updatePositions(index, x, y) {
    print("update called: ${x}, ${y} - index: ${index}");
    positions[index]["posx"] = x;
    positions[index]["posy"] = y;
    notifyListeners();
  }

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
              // updatePositions(
              //     details.localPosition.dx, details.localPosition.dy);
              addTapWidgets(posx ?? 100, posy ?? 100);
            },
            onTap: onTap,

            child: Zoom(
              width: 100.w,
              height: 100.h,
              maxZoomWidth: 1800,
              maxZoomHeight: 1800,
              // canvasColor: Colors.grey,
              // backgroundColor: Colors.orange,
              colorScrollBars: Colors.purple,
              opacityScrollBars: 0.4,
              scrollWeight: 0.0,
              centerOnScale: true,
              enableScroll: true,
              doubleTapZoom: true,
              zoomSensibility: 2,
              initZoom: 0.0,
              onTap: () {
                // print("Widget clicked");
              },
              onPositionUpdate: (Offset position) {
                // print(position.dx);
                // print(position.dy);
                // ZeroPositions(position.dx, position.dy);
                // for (var i = 0; i < positions.length; i++) {
                //   positions[i]["posx"] =
                //       positions[i]["posx"] + positions[i]["posx"];
                //   positions[i]["posy"] =
                //       positions[i]["posy"] + positions[i]["posy"];
                //   print("abc" + i.toString());
                // }
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
                WidgetsBinding.instance?.addPostFrameCallback((_){

  // Add Your Code here.

});
                var truncatedScale =
                    double.parse(scale.toStringAsFixed(2)) - 0.22;
                var truncatedZoom = double.parse(zoom.toStringAsFixed(2));
                // print("$truncatedScale");
                // print("$truncatedZoom");

                for (int i = 0; i < positions.length; i++) {
                  var item = positions[i];
                  // print("$item");
                  // 27.99-((27.99*0.9)+(27.99*0.63))

                  double posx = item["inposx"]; // 27.99
                  double posy = item["inposy"];

                  double newXLocation =
                      posx - ((posx * truncatedScale) + (posx * truncatedZoom));
                  double newYLocation =
                      posx - ((posy * truncatedScale) + (posy * truncatedZoom));

                  var truncatedNewXLocation =
                      double.parse(newXLocation.toStringAsFixed(2));
                  var truncatedNewYLocation =
                      double.parse(newYLocation.toStringAsFixed(2));

                  print("newLocation: $truncatedNewXLocation");
                  print("newLocation: $truncatedNewYLocation");

                  item["posx"] = truncatedNewXLocation;
                  positions[i]["posx"] = truncatedNewXLocation;
                  // positions[i]["posy"] = truncatedNewYLocation;

                  callback?.call(
                      i, truncatedNewXLocation, truncatedNewYLocation);
                }
                print("stackWidgets: ${stackWidgets}");
                print("positions: ${positions}");
                print("------");
                print("---------");
                // clearWidgets();
                print("Stack Widgets:");
                print(stackWidgets);
                print("positions:");
                print(positions);
                // if()
                addwidgets(width, photo, onTap);
                //
                //
                //
                print(positions.length);
                print(positions);
                for (var i = 0; i < positions.length; i++) {
                  var p = Positioned(
                      left: positions[i]["posx"],
                      top: positions[i]["posy"],
                      child: Draggable(
                        childWhenDragging: Container(),
                        feedback: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                        onDragEnd: (dragDetails) {
                          // posx = dragDetails.offset.dx;
                          // // if applicable, don't forget offsets like app/status bar
                          // posx = dragDetails.offset.dy;
                        },
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                      ));
                  stackWidgets.add(p);
                }
              },
              child: Image.file(
                photo,
                fit: BoxFit.fill,
              ),

              // child: InteractiveViewer(
              //   panEnabled: false, // Set it to false to prevent panning.
              //   boundaryMargin: EdgeInsets.all(80),
              //   minScale: 0.5,
              //   maxScale: 4,
              //   child: Image.file(
              //     photo,
              //     fit: BoxFit.fill,
              //   ),
              // ),
            ),

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
            onDoubleTap: () {},

            // onHorizontalDragUpdate: (details) {
            //   print("onHorizontalDragUpdate");
            //   print(details.localPosition.dx);
            //   print(stackWidgets.length);

            // if (stackWidgets.length > 0) {
            //   for (var item in stackWidgets) {
            //     try {
            //       var material = item as Material;
            //       if (material != null) {
            //         print("type cast: material");
            //         var container = material.child as Container;
            //         if (container != null) {
            //           print("type cast: container");
            //           var gestureDetector =
            //               container.child as GestureDetector;
            //           if (gestureDetector != null) {
            //             print("type cast: gestureDetector");
            //             var photoView = gestureDetector.child as PhotoView;
            //             if (photoView != null) {
            //               print("type cast: photoView");
            //               print("found photoView");
            //               int initialScale = photoView.initialScale;
            //               int maxScale = photoView.maxScale;
            //               print(initialScale);
            //               print(maxScale);
            //             }
            //           }
            //         }
            //       }
            //     } catch (error) {
            //       print(error);
            //     }

            //     // Positioned? positionedItem = item;
            //     // if (positionedItem != null) {
            //     //   print(positionedItem);
            //     //   print(
            //     //       "positionedItem.top: " + positionedItem.top.toString());
            //     //   print("positionedItem.left: " +
            //     //       positionedItem.left.toString());
            //     //   print("positionedItem.width: " +
            //     //       positionedItem.width.toString());
            //     //   print("positionedItem.height: " +
            //     //       positionedItem.height.toString());
            //     // } else {
            //     //   PhotoView? photoView = item;
            //     //   if (photoView != null) {
            //     //     print("photoView.customSize");
            //     //     print(photoView.customSize);
            //     //   }
            //     // }
            //   }
            // } else {
            //   print("stackWidgets is empty");
            // }
            // },

            // child: PhotoView(
            //   imageProvider: FileImage(photo),
            //   onScaleEnd: (context, details, value) {
            //     print(value.scale);
            //     print(value.position);
            //   },
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
