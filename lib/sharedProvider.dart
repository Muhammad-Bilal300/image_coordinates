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
  double imgScale = 0;
  double imgZoom = 0;

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

  getScaleAndZoom(scale, zoom) {
    imgScale = scale;
    imgZoom = zoom;
    notifyListeners();
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

  void temporaryTapWidgets() {
    var index = positions.length - 1;

    var p = Positioned(
        left: positions[index]["posx"],
        top: positions[index]["posy"],
        child: Draggable(
          childWhenDragging: Container(),
          feedback: Container(
            height: 15,
            width: 15,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          ),
          onDragEnd: (dragDetails) {
            posx = dragDetails.offset.dx;
            // if applicable, don't forget offsets like app/status bar
            posx = dragDetails.offset.dy;
          },
          child: Container(
            height: 15,
            width: 15,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          ),
        ));
    stackWidgets.add(p);
    notifyListeners();
  }

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

  clearPositions() {
    positions.clear();
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
              if (positions.length > 0) {
                return;
              }
              posx = details.localPosition.dx;
              posy = details.localPosition.dy;
              print("x: ${posx}");
              print("y: ${posy}");
              setpositions(details.localPosition.dx, details.localPosition.dy);
              addTapWidgets(posx ?? 100, posy ?? 100);
              temporaryTapWidgets();

              // clearWidgets();
              // print("Stack Widgets:");
              // print(stackWidgets);
              // print("positions:");
              // print(positions);

              // addwidgets(width, photo, onTap);
              // //
              // //
              // //
              // print(positions.length);
              // print(positions);
              // for (var i = 0; i < positions.length; i++) {
              //   var p = Positioned(
              //       left: positions[i]["posx"],
              //       top: positions[i]["posy"],
              //       child: Draggable(
              //         childWhenDragging: Container(),
              //         feedback: Container(
              //           height: 15,
              //           width: 15,
              //           decoration: BoxDecoration(
              //               shape: BoxShape.circle, color: Colors.white),
              //         ),
              //         onDragEnd: (dragDetails) {
              //           // posx = dragDetails.offset.dx;
              //           // // if applicable, don't forget offsets like app/status bar
              //           // posx = dragDetails.offset.dy;
              //         },
              //         child: Container(
              //           height: 15,
              //           width: 15,
              //           decoration: BoxDecoration(
              //               shape: BoxShape.circle, color: Colors.white),
              //         ),
              //       ));
              //   stackWidgets.add(p);
              // }

              // Add Your Code here.
            },
            onTap: () {
              print("Hello World");
              // WidgetsBinding.instance?.addPostFrameCallback((_) {
              //   // Add Your Code here.
              //   print("stackWidgets: ${stackWidgets}");
              //   print("positions: ${positions}");
              //   print("------");
              //   print("---------");
              //   clearWidgets();
              //   print("Stack Widgets:");
              //   print(stackWidgets);
              //   print("positions:");
              //   print(positions);

              //   addwidgets(width, photo, onTap);
              //   //
              //   //
              //   //
              //   print(positions.length);
              //   print(positions);
              //   for (var i = 0; i < positions.length; i++) {
              //     var p = Positioned(
              //         left: positions[i]["posx"],
              //         top: positions[i]["posy"],
              //         child: Draggable(
              //           childWhenDragging: Container(),
              //           feedback: Container(
              //             height: 15,
              //             width: 15,
              //             decoration: BoxDecoration(
              //                 shape: BoxShape.circle, color: Colors.white),
              //           ),
              //           onDragEnd: (dragDetails) {
              //             // posx = dragDetails.offset.dx;
              //             // // if applicable, don't forget offsets like app/status bar
              //             // posx = dragDetails.offset.dy;
              //           },
              //           child: Container(
              //             height: 15,
              //             width: 15,
              //             decoration: BoxDecoration(
              //                 shape: BoxShape.circle, color: Colors.white),
              //           ),
              //         ));
              //     stackWidgets.add(p);
              //   }
              // });
            },
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
                // print("position.direction: ${position.direction}");
                // // print("position.distanceSquared: ${position.distanceSquared}");
                // // print("position.distance: ${position.distance}");
                // print("position.dx: ${position.dx}");
                // print("position.dy: ${position.dy}");

                var truncatedDX =
                    double.parse(position.dx.toStringAsFixed(2)); // 682
                var truncatedDY =
                    double.parse(position.dy.toStringAsFixed(2)); // 682

                for (int i = 0; i < positions.length; i++) {
                  var item = positions[i];

                  double posx = item["inposx"]; // 190
                  double posy = item["inposy"]; // 271

                  var truncatedScale =
                      double.parse(imgScale.toStringAsFixed(2)); // 0.78

                  var finalX = ((truncatedDX * truncatedScale) + posx);
                  var finalY = ((truncatedDY * truncatedScale) + posy);

                  // (1*0.2)+188
                  // width - ((dx*scale) + (posx*scale))
                  // 600-((0*0.18)+(188*0.18))

                  print("truncatedDX ${truncatedDX}");
                  print("posx ${posx}");
                  print("truncatedScale ${truncatedScale}");
                  print("finalX ${finalX}");
                  print("finalX ${finalY}");
                }

                // ((682-190)*0.78)-190

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
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  var truncatedScale =
                      double.parse(scale.toStringAsFixed(2)) - 0.22;
                  var truncatedZoom = double.parse(zoom.toStringAsFixed(2));
                  getScaleAndZoom(truncatedScale, truncatedZoom);
                });

                return;
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  // Add Your Code here.
                  var truncatedScale =
                      double.parse(scale.toStringAsFixed(2)) - 0.22;
                  var truncatedZoom = double.parse(zoom.toStringAsFixed(2));
                  // print("$truncatedScale");
                  getScaleAndZoom(truncatedScale, truncatedZoom);
                  // print("$truncatedZoom");

                  for (int i = 0; i < positions.length; i++) {
                    var item = positions[i];
                    // print("$item");
                    // 27.99-((27.99*0.9)+(27.99*0.63))

                    double posx = item["inposx"]; // 90
                    double posy = item["inposy"];

                    double newXLocation = posx -
                        ((posx * truncatedScale) + (posx * truncatedZoom));
                    double newYLocation = posy -
                        ((posy * truncatedScale) + (posy * truncatedZoom));

                    var truncatedNewXLocation =
                        double.parse(newXLocation.toStringAsFixed(2));
                    var truncatedNewYLocation =
                        double.parse(newYLocation.toStringAsFixed(2));

                    print("newLocation: $truncatedNewXLocation");
                    print("newLocation: $truncatedNewYLocation");

                    item["posx"] = truncatedNewXLocation;
                    // item["posy"] = truncatedNewXLocation;
                    positions[i]["posx"] = truncatedNewXLocation;
                    // positions[i]["posy"] = truncatedNewYLocation;

                    callback?.call(
                        i, truncatedNewXLocation, truncatedNewYLocation);
                  }
                  print("stackWidgets: ${stackWidgets}");
                  print("positions: ${positions}");
                  print("------");
                  print("---------");
                  clearWidgets();
                  print("Stack Widgets:");
                  print(stackWidgets);
                  print("positions:");
                  print(positions);

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
                  print("positions:");
                  print(positions);
                  print("Stack Widgets:");
                  print(stackWidgets);
                });
              },
              child: Image.file(
                photo,
                fit: BoxFit.fill,
              ),
            ),
            onDoubleTap: () {},
          ),
        ),
      ));
    }

    notifyListeners();
  }

  int get widgetsLength => stackWidgets.length;

  List get widgetList => stackWidgets;
}
