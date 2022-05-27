import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_view/Constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

class PhotoHero extends StatefulWidget {
  PhotoHero({
    Key? key,
    required this.photo,
    required this.onTap,
    required this.width,
  }) : super(key: key);

  final File photo;
  final VoidCallback onTap;
  final double width;

  @override
  State<PhotoHero> createState() => _PhotoHeroState();
}

class _PhotoHeroState extends State<PhotoHero> {
  final GlobalKey _cardkey = GlobalKey();
  double posx = 100.0;
  double posy = 100.0;
  Size? cardSize;
  Offset? cardPosition;
  var height = AppBar().preferredSize.height;
  ui.Image? image;

  void onTapDown(BuildContext context, TapDownDetails details) {
    // print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
    });
    print(posx);
    print(posy);
  }

  List<int> exampleList = [1, 2, 3, 4];
  List<dynamic> stackWidgets = [];

  @override
  void initState() {
    stackWidgets.add(
      Material(
        color: Colors.transparent,
        child: Container(
          height: 500,
          width: widget.width,
          child: GestureDetector(
            onTapDown: (details) {
              print(details.localPosition.dx);
              //global position
              print(details.localPosition.dy);
              setState(() {
                posx = details.localPosition.dx;
                posy = details.localPosition.dy;
              });
              print(stackWidgets.length);
              setState(() {
                stackWidgets.add(Positioned(
                    left: posx,
                    top: posy,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    )));
              });
              //local position
            },
            onTap: widget.onTap,
            child: Image.file(
              widget.photo,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      // width: 100.w,
      child: widget.width == 100
          ? Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100),
                      // color: whiteColor.withOpacity(0.7),
                      boxShadow: [
                    BoxShadow(
                        offset: Offset(1.0, 1.0),
                        color: greyColor.withOpacity(0.5),
                        blurRadius: 5.0,
                        spreadRadius: 5.0)
                  ]),
              child: ClipOval(
                child: Hero(
                  tag: widget.photo,
                  child: Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                     
                      onTap: widget.onTap,
                      child: Image.file(
                        widget.photo,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Hero(
              tag: widget.photo,
              child: Stack(
                children: List.generate(stackWidgets.length, (index) {
                  return stackWidgets[index];
                }),
              ),
            ),
    );
  }
}

class HeroAnimation extends StatefulWidget {
  @override
  State<HeroAnimation> createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  // Coordinates

  File? pickedImage;

  Widget build(BuildContext context) {
    var timeDilation = 5.0; // 1.0 means normal animation speed.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Hero Animation'),
      ),
      body: Center(
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    imageDialog();
                  },
                  child: Text("Upload Image")),
              ElevatedButton(onPressed: () {}, child: Text("Preview Image"))
            ],
          ),
          pickedImage != null
              ? Container(
                  height: 15.h,
                  width: 15.h,
                  // width: 10.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: whiteColor.withOpacity(0.7),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(1.0, 1.0),
                            color: greyColor.withOpacity(0.5),
                            blurRadius: 5.0,
                            spreadRadius: 5.0)
                      ]),
                  child: PhotoHero(
                    photo: pickedImage!,
                    width: 100.0,
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(
                            title: const Text('Flippers Page'),
                          ),
                          body: Container(
                            width: 100.w,
                            // The blue background emphasizes that it's a new route.
                            color: Colors.lightBlueAccent,
                            // padding: const EdgeInsets.all(16.0),
                            // alignment: Alignment.topLeft,
                            child: Center(
                              child: PhotoHero(
                                photo: pickedImage!,
                                width: MediaQuery.of(context).size.width * 1.0,
                                onTap: () {
                                  // Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        );
                      }));
                    },
                  ),
                )
              : Container(),
        ]),
      ),
    );
  }

  void imageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
            child: Container(
              width: double.infinity,
              // height: 400,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Pick Image From",
                                  style: TextStyle(
                                      fontFamily: "Metropolis-Bold",
                                      color: primaryFontColor,
                                      fontSize: 16.sp),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 2.h,
                        ),
                        MaterialButton(
                          elevation: 5,
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.025),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                          minWidth: MediaQuery.of(context).size.width,
                          color: secondaryColor,
                          child: Text(
                            "Camera",
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 12.5.sp,
                                fontFamily: "metropolis-semibold"),
                          ),
                          onPressed: () {
                            pickImage(ImageSource.camera);
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MaterialButton(
                          elevation: 5,
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.025),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                          minWidth: MediaQuery.of(context).size.width,
                          color: secondaryColor,
                          child: Text(
                            "Gallery",
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 12.5.sp,
                                fontFamily: "metropolis-semibold"),
                          ),
                          onPressed: () {
                            pickImage(ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo =
          await ImagePicker().pickImage(source: imageType, imageQuality: 40);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
