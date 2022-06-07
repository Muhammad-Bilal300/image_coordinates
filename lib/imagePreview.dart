import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_view/sharedProvider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ImagePreview extends StatefulWidget {
  final File photo;
  final VoidCallback onTap;
  final double width;

  const ImagePreview(
      {Key? key, required this.photo, required this.onTap, required this.width})
      : super(key: key);

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  List<dynamic> widgets = [];
  double _x = 0;
  double _y = 0;
  ImagePreview? imagePreview;

  @override
  @override
  void initState() {
    // print("width");
    // print(WidgetsBinding.instance?.window.physicalSize.width);
    // print("height");
    // print(WidgetsBinding.instance?.window.physicalSize.height);
    var auth;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<SharedImageProvider>(context, listen: false).clearWidgets();
      // print("Stack Widgets:");
      // print(Provider.of<SharedImageProvider>(context, listen: false)
      //     .stackWidgets);
      // print("positions:");
      // print(Provider.of<SharedImageProvider>(context, listen: false).positions);
      Provider.of<SharedImageProvider>(context, listen: false)
          .addwidgets(widget.width, widget.photo, widget.onTap);
      // print(Provider.of<SharedImageProvider>(context, listen: false)
      //     .widgetList
      //     .length);
      // print("Positions");
      // print(Provider.of<SharedImageProvider>(context, listen: false)
      //     .positions
      //     .length);
      // print(Provider.of<SharedImageProvider>(context, listen: false).positions);
      for (var i = 0;
          i <
              Provider.of<SharedImageProvider>(context, listen: false)
                  .positions
                  .length;
          i++) {
        var p = Positioned(
            left: Provider.of<SharedImageProvider>(context, listen: false)
                .positions[i]["posx"],
            top: Provider.of<SharedImageProvider>(context, listen: false)
                .positions[i]["posy"],
            child: Draggable(
              childWhenDragging: Container(),
              feedback: Container(
                height: 15,
                width: 15,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              ),
              onDragEnd: (dragDetails) {
                // posx = dragDetails.offset.dx;
                // // if applicable, don't forget offsets like app/status bar
                // posx = dragDetails.offset.dy;
              },
              child: Container(
                height: 15,
                width: 15,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              ),
            ));
        Provider.of<SharedImageProvider>(context, listen: false)
            .stackWidgets
            .add(p);
      }
      // print("Stack Widgets:");
      // print(Provider.of<SharedImageProvider>(context, listen: false)
      //     .stackWidgets);
    });
    // print(Provider.of<SharedImageProvider>(context, listen: false).widgetList);

    // setState(() {
    //   widgets =
    //       Provider.of<SharedImageProvider>(context, listen: false).widgetList;
    // });
    // print("Widgets: " );
    // print(widgets);
    // stackWidgets.add(
    //   Material(
    //     color: Colors.transparent,
    //     child: Container(
    //       height: 500,
    //       width: widget.width,
    //       child: GestureDetector(
    //         onTapDown: (details) {
    //           print(details.localPosition.dx);
    //           //global position
    //           print(details.localPosition.dy);
    //           setState(() {
    //             posx = details.localPosition.dx;
    //             posy = details.localPosition.dy;
    //           });
    //           print(stackWidgets.length);
    //           setState(() {
    //             stackWidgets.add(Positioned(
    //                 left: posx,
    //                 top: posy,
    //                 child: Container(
    //                   height: 10,
    //                   width: 10,
    //                   decoration: BoxDecoration(
    //                       shape: BoxShape.circle, color: Colors.white),
    //                 )));
    //           });
    //           //local position
    //         },
    //         onTap: widget.onTap,
    //         child: Image.file(
    //           widget.photo,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    // TODO: implement initState
  }

  void name(args) {}
  Function()? callback;

  Widget build(BuildContext context) {
    return Consumer<SharedImageProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          title: Text("Image Preview"),
        ),
        body: GestureDetector(
          onTap: () {},
          child: Container(
            width: 100.w,
            height: 670,
            child: Column(
              children: [
                Container(
                  height: 400,
                  child: Stack(
                      children:
                          List.generate(provider.widgetList.length, (index) {
                    provider.setCallback((index, x, y) {
                      // print("callback called");
                      // print("index: ${index}");
                      // if (this.mounted) {
                      //   provider.removeElement(1);
                      // }

                      // if (provider.positions.length > 0) {
                      //   provider.updatePositions(index, x, y);
                      //   setState(() {
                      //     // provider.positions[0]["posx"] = 123;
                      //   });
                      // }

                      print("------");
                      print(index);

                      // provider.removeElement(index);
                      // provider.addTapWidgets(x, y);

                      // var length = provider.positions.length;
                      // for (int i = 0; i < length; i++) {
                      //   print("deleting... ${i}");
                      //   provider.removeElement(i-1);
                      // }
                      // for (int i = 0; i < length; i++) {
                      //   print("adding... ${i}");
                      //   provider.addTapWidgets(x, y);
                      // }
                      print("------");
                    });
                    return provider.widgetList[index];
                  })),
                ),
                SizedBox(
                  height: 4.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Scale",
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          "${provider.imgScale}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Zoom",
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          "${provider.imgZoom}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
