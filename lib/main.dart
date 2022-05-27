

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
