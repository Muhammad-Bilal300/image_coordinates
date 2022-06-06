import 'dart:ui';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:image_view/image_upload_screen.dart';
import 'package:image_view/practice.dart';
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
          // home: HeroAnimation()
          home: HeroAnimation());
    });
  }
}




// import 'package:flutter/material.dart';
// import "dart:math";

// import 'package:sizer/sizer.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: GestureDetector(
//             onTapDown: (details) {
//               CustomPaint(
//                 size: const Size(
//                   30,
//                   30,
//                 ),
//                 painter: MyPainter(
//                     3, details.localPosition.dx, details.localPosition.dy),
//               );
//             },
//             child: Container(
//               height: 450,
//               width: 500,
//               color: Colors.black,
//               // child: CustomPaint(
//               //   size: const Size(
//               //     30,
//               //     30,
//               //   ),
//               //   painter: MyPainter(
//               //     3,
//               //   ),
//               // ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MyPainter extends CustomPainter {
//   MyPainter(this.radius, this.posx, this.posy);

//   final double radius;
//   final double posx;
//   final double posy;

//   @override
//   void paint(Canvas canvas, Size size) {
//     // final double centerX = size.width / 2;
//     // final double centerY = size.height / 2;
//     final Paint paint = Paint()..color = Colors.white;
//     final double filledCircleRadius = 7;
//     final int numberOfDots = 10;
//     final double radiantStep = 2 * pi / numberOfDots;
//     for (int i = 0; i < numberOfDots; i++) {
//       // canvas.drawCircle(
//       //   Offset(centerX + sin(i * radiantStep) * radius,
//       //       centerY + cos(i * radiantStep) * radius),
//       //   filledCircleRadius,
//       //   paint,
//       // );

//       canvas.drawCircle(
//         Offset(posx, posy),
//         filledCircleRadius,
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }


// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.black54,
//         body: Center(
//           child: TappableStarButton(),
//         ),
//       ),
//     );
//   }
// }

// class TappableStarButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: GestureDetector(
//         child: CustomPaint(
//           size: Size(300, 300),
//           painter: RPSCustomPainter(),
//         ),
//         onTap: () {
//           print("This works");
//         },
//       ),
//     );
//   }
// }

// class RPSCustomPainter extends CustomPainter {
//   Path path_0 = Path();

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint_0 = new Paint()
//       ..color = Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 1;
//     paint_0.shader = ui.Gradient.linear(
//         Offset(10, 150),
//         Offset(290, 150),
//         [Color(0xffff1313), Color(0xffffbc00), Color(0xffffca00)],
//         [0.00, 0.69, 1.00]);

//     path_0.moveTo(150, 10);
//     path_0.lineTo(100, 100);
//     path_0.lineTo(10, 150);
//     path_0.lineTo(100, 200);
//     path_0.lineTo(150, 290);
//     path_0.lineTo(200, 200);
//     path_0.lineTo(290, 150);
//     path_0.lineTo(200, 100);
//     canvas.drawPath(path_0, paint_0);
//   }

//   @override
//   bool hitTest(Offset position) {
//     bool hit = path_0.contains(position);
//     return hit;
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
