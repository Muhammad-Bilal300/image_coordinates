import 'dart:ui';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MapObject {
//   final Widget child;

//   ///relative offset from the center of the map for this map object. From -1 to 1 in each dimension.
//   final Offset offset;

//   ///size of this object for the zoomLevel == 1
//   final Size size;

//   MapObject({
//     required this.child,
//     required this.offset,
//     required this.size,
//   });
// }

// class _ImageViewportState extends State<ImageViewport> {
//   double _zoomLevel = 1;
//   ImageProvider? _imageProvider;
//   ui.Image? _image;
//   bool _resolved = false;
//   late Offset _centerOffset;
//   double _maxHorizontalDelta = 0;
//   double _maxVerticalDelta = 0;
//   Offset? _normalized;
//   bool _denormalize = false;
//   Size _actualImageSize = Size(10, 10);
//   Size _viewportSize = Size(7, 7);

//   late List<MapObject> _objects;

//   double abs(double value) {
//     return value < 0 ? value * (-1) : value;
//   }

//   void _updateActualImageDimensions() {
//     _actualImageSize = Size(
//         (_image!.width / window.devicePixelRatio) * _zoomLevel,
//         (_image!.height / ui.window.devicePixelRatio) * _zoomLevel);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _zoomLevel = widget.zoomLevel;
//     _imageProvider = widget.imageProvider;
//     _resolved = false;
//     _centerOffset = Offset(0, 0);
//     _objects = widget.objects;
//   }

//   void _resolveImageProvider() {
//     // ImageStream stream =
//     //     _imageProvider.resolve(createLocalImageConfiguration(context));
//     // stream.addListener((info, _) {
//     //   _image = info.image;
//     //   _resolved = true;
//     //   _updateActualImageDimensions();
//     //   setState(() {});
//     // });
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _resolveImageProvider();
//   }

//   @override
//   void didUpdateWidget(ImageViewport oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.imageProvider != _imageProvider) {
//       _imageProvider = widget.imageProvider;
//       _resolveImageProvider();
//     }
//     double normalizedDx =
//         _maxHorizontalDelta == 0 ? 0 : _centerOffset.dx / _maxHorizontalDelta;
//     double normalizedDy =
//         _maxVerticalDelta == 0 ? 0 : _centerOffset.dy / _maxVerticalDelta;
//     _normalized = Offset(normalizedDx, normalizedDy);
//     _denormalize = true;
//     _zoomLevel = widget.zoomLevel;
//     _updateActualImageDimensions();
//   }

//   ///This is used to convert map objects relative global offsets from the map center
//   ///to the local viewport offset from the top left viewport corner.
//   Offset _globaltoLocalOffset(Offset value) {
//     double hDelta = (_actualImageSize.width / 2) * value.dx;
//     double vDelta = (_actualImageSize.height / 2) * value.dy;
//     double dx = (hDelta - _centerOffset.dx) + (_viewportSize.width / 2);
//     double dy = (vDelta - _centerOffset.dy) + (_viewportSize.height / 2);
//     return Offset(dx, dy);
//   }

//   ///This is used to convert global coordinates of long press event on the map to relative global offsets from the map center
//   Offset _localToGlobalOffset(Offset value) {
//     double dx = value.dx - _viewportSize.width / 2;
//     double dy = value.dy - _viewportSize.height / 2;
//     double dh = dx + _centerOffset.dx;
//     double dv = dy + _centerOffset.dy;
//     return Offset(
//       dh / (_actualImageSize.width / 2),
//       dv / (_actualImageSize.height / 2),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     void handleDrag(DragUpdateDetails updateDetails) {
//       Offset newOffset = _centerOffset.translate(
//           -updateDetails.delta.dx, -updateDetails.delta.dy);
//       if (abs(newOffset.dx) <= _maxHorizontalDelta &&
//           abs(newOffset.dy) <= _maxVerticalDelta)
//         setState(() {
//           _centerOffset = newOffset;
//         });
//     }

//     void addMapObject(MapObject object) => setState(() {
//           _objects.add(object);
//         });

//     void removeMapObject(MapObject object) => setState(() {
//           _objects.remove(object);
//         });
//     MapObject info;
//     List<Widget> buildObjects() {
//       return _objects
//           .map(
//             (MapObject object) => Positioned(
//               left: _globaltoLocalOffset(object.offset).dx -
//                   (object.size == null
//                       ? 0
//                       : (object.size.width * _zoomLevel) / 2),
//               top: _globaltoLocalOffset(object.offset).dy -
//                   (object.size == null
//                       ? 0
//                       : (object.size.height * _zoomLevel) / 2),
//               child: GestureDetector(
//                 onTapUp: (TapUpDetails details) {
//                   info = MapObject(
//                     child: DecoratedBox(
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                         width: 1,
//                       )),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Text("Close me"),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.close),
//                             onPressed: () => removeMapObject(object),
//                           ),
//                         ],
//                       ),
//                     ),
//                     offset: object.offset,
//                     size: Size(0, 0),
//                   );
//                   addMapObject(info);
//                 },
//                 child: Container(
//                   width: object.size == null
//                       ? null
//                       : object.size.width * _zoomLevel,
//                   height: object.size == null
//                       ? null
//                       : object.size.height * _zoomLevel,
//                   child: object.child,
//                 ),
//               ),
//             ),
//           )
//           .toList();
//     }

//     return _resolved
//         ? LayoutBuilder(
//             builder: (BuildContext context, BoxConstraints constraints) {
//               _viewportSize = Size(
//                   min(constraints.maxWidth, _actualImageSize.width),
//                   min(constraints.maxHeight, _actualImageSize.height));
//               _maxHorizontalDelta =
//                   (_actualImageSize.width - _viewportSize.width) / 2;
//               _maxVerticalDelta =
//                   (_actualImageSize.height - _viewportSize.height) / 2;
//               bool reactOnHorizontalDrag =
//                   _maxHorizontalDelta > _maxVerticalDelta;
//               bool reactOnPan =
//                   (_maxHorizontalDelta > 0 && _maxVerticalDelta > 0);
//               if (_denormalize) {
//                 _centerOffset = Offset(_maxHorizontalDelta * _normalized!.dx,
//                     _maxVerticalDelta * _normalized!.dy);
//                 _denormalize = false;
//               }

//               return GestureDetector(
//                 onPanUpdate: reactOnPan ? handleDrag : null,
//                 onHorizontalDragUpdate:
//                     reactOnHorizontalDrag && !reactOnPan ? handleDrag : null,
//                 onVerticalDragUpdate:
//                     !reactOnHorizontalDrag && !reactOnPan ? handleDrag : null,
//                 onLongPressEnd: (LongPressEndDetails details) {
//                   RenderBox box = context.findRenderObject() as RenderBox;
//                   Offset localPosition =
//                       box.globalToLocal(details.globalPosition);
//                   Offset newObjectOffset = _localToGlobalOffset(localPosition);
//                   MapObject newObject = MapObject(
//                     child: Container(
//                       color: Colors.blue,
//                     ),
//                     offset: newObjectOffset,
//                     size: Size(10, 10),
//                   );
//                   addMapObject(newObject);
//                 },
//                 child: Stack(
//                   children: <Widget>[
//                         CustomPaint(
//                           size: _viewportSize,
//                           painter:
//                               MapPainter(_image!, _zoomLevel, _centerOffset),
//                         ),
//                       ] +
//                       buildObjects(),
//                 ),
//               );
//             },
//           )
//         : SizedBox();
//   }
// }

// class ImageViewport extends StatefulWidget {
//   final double zoomLevel;
//   final ImageProvider imageProvider;
//   final List<MapObject> objects;

//   ImageViewport({
//     required this.zoomLevel,
//     required this.imageProvider,
//     required this.objects,
//   });

//   @override
//   State<StatefulWidget> createState() => _ImageViewportState();
// }

// class MapPainter extends CustomPainter {
//   final ui.Image image;
//   final double zoomLevel;
//   final Offset centerOffset;

//   MapPainter(this.image, this.zoomLevel, this.centerOffset);

//   @override
//   void paint(Canvas canvas, Size size) {
//     double pixelRatio = window.devicePixelRatio;
//     Size sizeInDevicePixels =
//         Size(size.width * pixelRatio, size.height * pixelRatio);
//     Paint paint = Paint();
//     paint.style = PaintingStyle.fill;
//     Offset centerOffsetInDevicePixels =
//         centerOffset.scale(pixelRatio / zoomLevel, pixelRatio / zoomLevel);
//     Offset centerInDevicePixels = Offset(image.width / 2, image.height / 2)
//         .translate(
//             centerOffsetInDevicePixels.dx, centerOffsetInDevicePixels.dy);
//     Offset topLeft = centerInDevicePixels.translate(
//         -sizeInDevicePixels.width / (2 * zoomLevel),
//         -sizeInDevicePixels.height / (2 * zoomLevel));
//     Offset rightBottom = centerInDevicePixels.translate(
//         sizeInDevicePixels.width / (2 * zoomLevel),
//         sizeInDevicePixels.height / (2 * zoomLevel));
//     canvas.drawImageRect(
//       image,
//       Rect.fromPoints(topLeft, rightBottom),
//       Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

// class ZoomContainerState extends State<ZoomContainer> {
//   double? _zoomLevel;
//   ImageProvider? _imageProvider;
//   List<MapObject>? _objects;

//   @override
//   void initState() {
//     super.initState();
//     _zoomLevel = widget.zoomLevel;
//     _imageProvider = widget.imageProvider;
//     _objects = widget.objects;
//   }

//   @override
//   void didUpdateWidget(ZoomContainer oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.imageProvider != _imageProvider)
//       _imageProvider = widget.imageProvider;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         ImageViewport(
//           zoomLevel: _zoomLevel!,
//           imageProvider: _imageProvider!,
//           objects: _objects!,
//         ),
//         Row(
//           children: <Widget>[
//             IconButton(
//               color: Colors.red,
//               icon: Icon(Icons.zoom_in),
//               onPressed: () {
//                 setState(() {
//                   _zoomLevel = _zoomLevel! * 2;
//                 });
//               },
//             ),
//             SizedBox(
//               width: 5,
//             ),
//             IconButton(
//               color: Colors.red,
//               icon: Icon(Icons.zoom_out),
//               onPressed: () {
//                 setState(() {
//                   _zoomLevel = _zoomLevel! / 2;
//                 });
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class ZoomContainer extends StatefulWidget {
//   final double zoomLevel;
//   final ImageProvider imageProvider;
//   final List<MapObject> objects;

//   ZoomContainer({
//     this.zoomLevel = 1,
//     required this.imageProvider,
//     this.objects = const [],
//   });

//   @override
//   State<StatefulWidget> createState() => ZoomContainerState();
// }

// class MyHomePage extends StatelessWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Move the map"),
//       ),
//       body: Center(
//         child: ZoomContainer(
//           zoomLevel: 4,
//           imageProvider: Image.asset("assets/map.png").image,
//           objects: [
//             MapObject(
//               child: Container(
//                 color: Colors.red,
//               ),
//               offset: Offset(0, 0),
//               size: Size(10, 10),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PicturePanZoomComponent extends StatefulWidget {
//   const PicturePanZoomComponent({Key? key}) : super(key: key);

//   @override
//   _PicturePanZoomComponentState createState() =>
//       _PicturePanZoomComponentState();
// }

// class _PicturePanZoomComponentState extends State<PicturePanZoomComponent> {
//   double top = 0;
//   double left = 0;
//   double ratio = 1;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Container(
//           width: constraints.maxWidth,
//           height: constraints.maxHeight,
//           child: GestureDetector(
//             onPanUpdate: _handlePanUpdate,
//             child: Stack(
//               children: <Widget>[
//                 Positioned(
//                   top: top,
//                   left: left,
//                   width: 660 * ratio,
//                   child: Image.network(
//                     "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Culinary_fruits_front_view.jpg/1200px-Culinary_fruits_front_view.jpg",
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned(
//                   left: 0,
//                   top: 0,
//                   child: Row(
//                     children: <Widget>[
//                       IconButton(
//                         icon: Icon(Icons.add),
//                         onPressed: _handleZoomIn,
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.remove),
//                         onPressed: _handleZoomOut,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _handlePanUpdate(DragUpdateDetails details) {
//     setState(() {
//       top = top + details.delta.dy;
//       left = left + details.delta.dx;
//     });
//   }

//   void _handleZoomIn() {
//     setState(() {
//       ratio *= 1.5;
//     });
//   }

//   void _handleZoomOut() {
//     setState(() {
//       ratio /= 1.5;
//     });
//   }
// }

// void main() => runApp(MyApp());

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Simpler approach"),
//       ),
//       body: Center(
//         child: PicturePanZoomComponent(),
//       ),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:image_view/image_upload_screen.dart';
import 'package:image_view/sharedProvider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => SharedImageProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HeroAnimation());
    });
  }
}






















// import 'dart:ffi';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:ui' as ui;

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
  // final GlobalKey _cardkey = GlobalKey();
  // double posx = 100.0;
  // double posy = 100.0;
  // Size? cardSize;
  // Offset? cardPosition;
  // var height = AppBar().preferredSize.height;
  // ui.Image? image;

  // void onTapDown(BuildContext context, TapDownDetails details) {
  //   // print('${details.globalPosition}');
  //   final RenderBox box = context.findRenderObject() as RenderBox;
  //   final Offset localOffset = box.globalToLocal(details.globalPosition);
  //   setState(() {
  //     posx = localOffset.dx;
  //     posy = localOffset.dy;
  //   });
  //   print(posx);
  //   print(posy);
  // }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // WidgetsBinding.instance!.addPostFrameCallback((_) {getSizeAndPosition(); });
//     loadImage('assets/images/kitchen.png');
//   }

//   Future loadImage(String path) async {
//     final data = await rootBundle.load(path);
//     final bytes = data.buffer.asUint8List();
//     final image = await decodeImageFromList(bytes);
//     setState(() {
//       this.image = image;
//     });
//   }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         // appBar: AppBar(
//         //   title: Text("Canvas"),
//         // ),
//         body: Center(
//           child: Container(
//             decoration: BoxDecoration(
//                 border: Border.all(),
//                 shape: BoxShape.circle,
//                 color: Colors.green),
//             height: double.infinity,
//             width: double.infinity,
//             child: GestureDetector(
              // onTapDown: (details) {
              //   //local position
              //   print(details.localPosition.dx);
              //   //global position
              //   print(details.globalPosition.dy);
              //   setState(() {
              //     posx = details.localPosition.dx;
              //     posy = details.globalPosition.dy;
              //   });
              // },
//               key: _cardkey,
//               //   onTapDown: (TapDownDetails details){
//               //  onTapDown(context, details);
//               //  },
//               onTap: () {
//                 // onTapDown(context, details.);
//               },
//               onPanStart: (details) {
//                 Offset position = details.localPosition;
//                 setState(() {
//                   posx = position.dx;
//                   posy = position.dy;
//                 });
//                 print(posx);
//                 print(posy);
//               },
//               onPanUpdate: (DragUpdateDetails details) {
//                 Offset position = details.localPosition;
//                 setState(() {
//                   posx = position.dx;
//                   posy = position.dy;
//                 });
//               },
//               child: FittedBox(
//                 child: SizedBox(
//                   width: image?.width.toDouble(),
//                   height: image?.height.toDouble(),
//                   child: CustomPaint(
//                     // key: _cardkey,
//                     painter: ImagePainter(posx, posy, image),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ImagePainter extends CustomPainter {
//   double? posX;
//   double? posY;
//   ui.Image? images;

//   ImagePainter(double posx, double posy, this.images) {
//     posX = posx;
//     posY = posy;
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final CenterX = size.width / 2;
//     final CenterY = size.height / 2;

//     final paintCircle = Paint()
//       ..strokeWidth = 5
//       ..color = Colors.green
//       ..style = PaintingStyle.stroke;
//     // canvas.translate(size.width/2, -size.height/2);
//     // canvas.scale(1,-1);

//     final paintImage = Paint()
//       ..strokeWidth = 5
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke;
//     // canvas.translate(size.width/2, -size.height/2);
//     // canvas.scale(1,-1);

//     final paintLine = Paint()
//       ..strokeWidth = 5
//       ..color = Colors.black
//       ..style = PaintingStyle.stroke;

//     canvas.drawCircle(center, size.width / 2, paintCircle);
//     var circleCenter = Offset(size.width / 2, size.height / 2);
//     var radius = size.width / 8;
//     canvas.drawImage(images!, Offset(0, 0), paintImage);
//     var line = canvas.drawLine(center, Offset(posX!, posY!), paintLine);
//     //  print("$line");
//   }

//   @override
//   bool shouldRepaint(CustomPainter olddelegate) => true;
// }
