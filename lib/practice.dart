import 'package:flutter/material.dart';
import 'package:image_view/Constants/colors.dart';

class OverlayWidget extends StatefulWidget {
  const OverlayWidget({Key? key}) : super(key: key);

  @override
  _OverlayWidgetState createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  final LayerLink _layerLink = LayerLink();

  CompositedTransformFollower? compositFollower;

  UpdateValue() {
    // int abc = 9;
    // double def = abc as double;
    // var updated = "";
    // var item = updated as CompositedTransformFollower;

    //   compositFollower?.offset =
  }

  @override
  Widget build(BuildContext context) {
    compositFollower = CompositedTransformFollower(
      link: _layerLink,
      showWhenUnlinked: true,
      offset: Offset(10.0, 20),
      child: Material(
          elevation: 5.0,
          child: Container(
            height: 50,
            width: 50,
            color: Colors.black,
          )),
    );
    return Scaffold(
      body: Container(child: compositFollower),
    );
  }
}
