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
        borderOnForeground: false,
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
              backgroundColor: Colors.white,
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
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  // print("position.direction: ${position.direction}");

                  var truncatedDX =
                      double.parse(position.dx.toStringAsFixed(2));
                  var truncatedDY =
                      double.parse(position.dy.toStringAsFixed(2));

                  var truncatedScale =
                      double.parse(imgScale.toStringAsFixed(2));
                  var truncatedZoom = double.parse(imgZoom.toStringAsFixed(2));

                  var truncatedDirection =
                      double.parse(position.direction.toStringAsFixed(2));

                  print("===============");
                  print("truncatedScale: ${truncatedScale}");
                  print("truncatedZoom: ${truncatedZoom}");

                  for (int i = 0; i < positions.length; i++) {
                    var item = positions[i];

                    double posx = item["inposx"];
                    double posy = item["inposy"];

                    print("posx ${posx}");
                    print("posy ${posy}");

                    var Xa = (double.parse(
                        ((posx * truncatedScale) - truncatedZoom)
                            .toStringAsFixed(2)));
                    var Xb =
                        double.parse((posx - truncatedDX).toStringAsFixed(2));
                    var finalX = double.parse((Xa + Xb).toStringAsFixed(2));

                    print("Xa: ${Xa}");
                    print("Xb: ${Xb}");
                    print("finalX: ${finalX}");

                    var Ya = (double.parse(
                        ((posy * truncatedScale) - truncatedZoom)
                            .toStringAsFixed(2)));
                    var Yb =
                        double.parse((posy - truncatedDY).toStringAsFixed(2));
                    var finalY = double.parse((Ya + Yb).toStringAsFixed(2)) -
                        double.parse((truncatedZoom).toStringAsFixed(2));

                    print("Ya: ${Ya}");
                    print("Yb: ${Yb}");
                    print("finalY: ${finalY}");

                    // (truncatedZoom / 60) * (200 * 10);

                    var constantFactorX = (imgZoom / 17) *
                        (500 * 10); //(truncatedZoom * ((finalX).abs()) * 100);
                    // var constantFactorY =
                    //     (truncatedZoom * ((finalY).abs()) * 100);
                    var constantFactorY = (imgZoom / 20) * (800 * 10);

                    item["posx"] =
                        finalX + ((truncatedZoom > 0) ? constantFactorX : 0);
                    item["posy"] =
                        finalY + ((truncatedZoom > 0) ? constantFactorY : 0);

                    print("===============");

                    // 0.12 * 333 = 40
                    // x = 333

                    // y = 0.12 * 2780

                    // 0.12 * x = 40

                    // 0.17 * 353 = 60
                    // x = 353
                    // 0.17 * x = 60
                  }
                  clearWidgets();
                  addwidgets(width, photo, onTap);
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
                  // print("positions:");
                  // print(positions);
                  // print("Stack Widgets:");
                  // print(stackWidgets);
                });
                // ((682-190)*0.78)-190
              },
              onScaleUpdate: (double scale, double zoom) {
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  var truncatedScale =
                      double.parse(scale.toStringAsFixed(2)) - 0.22;
                  var truncatedZoom = double.parse(zoom.toStringAsFixed(2));
                  getScaleAndZoom(truncatedScale, zoom);
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
                width: 100.w,
                fit: BoxFit.cover,
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
