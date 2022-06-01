import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_view/sharedProvider.dart';
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
  @override
  @override
  void initState() {
    var auth;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<SharedImageProvider>(context, listen: false)
          .addwidgets(widget.width, widget.photo, widget.onTap);
      print(Provider.of<SharedImageProvider>(context, listen: false)
          .widgetList
          .length);
    });
    print(Provider.of<SharedImageProvider>(context, listen: false).widgetList);
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
    super.initState();
  }

  Widget build(BuildContext context) {
    return Consumer<SharedImageProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          title: Text("Image Preview"),
        ),
        body: Container(
          width: 100.w,
          height: 600,
          child: Stack(
              children: List.generate(provider.widgetList.length, (index) {
            return provider.widgetList[index];
          })),
        ),
      ),
    );
  }
}
