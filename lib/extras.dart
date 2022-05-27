import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_view/Constants/colors.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;
// class ImageUploadingScreen extends StatefulWidget {
//   const ImageUploadingScreen({Key? key}) : super(key: key);

//   @override
//   State<ImageUploadingScreen> createState() => _ImageUploadingScreenState();
// }

// class _ImageUploadingScreenState extends State<ImageUploadingScreen> {
//   File? pickedImage;
//   List galleryItems = [
//     {"image": "assets/images/CNIC_dummy.png", "id": 0},
//     {"image": "assets/images/kitchen.png", "id": 1},
//     {"image": "assets/images/kitchenAndroid.png", "id": 2},
//   ];
//   PhotoViewController controller = PhotoViewController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Uploading an Image"),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 50,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Stack(children: [
//                 Container(
//                     // padding: EdgeInsets.all(10),
//                     height: 15.h,
//                     width: 15.h,
//                     // width: 10.w,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         color: whiteColor.withOpacity(0.7),
//                         boxShadow: [
//                           BoxShadow(
//                               offset: Offset(1.0, 1.0),
//                               color: greyColor.withOpacity(0.5),
//                               blurRadius: 5.0,
//                               spreadRadius: 5.0)
//                         ]),
//                     child: ClipOval(
//                         child: pickedImage != null
//                             ? Image.file(
//                                 pickedImage!,
//                                 height: 15.h,
//                                 width: 15.h,
//                                 fit: BoxFit.cover,
//                               )
//                             : Icon(
//                                 Icons.person,
//                                 size: 28.w,
//                                 color: greyColor,
//                               ))),
//                 Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: InkWell(
//                       onTap: () {
//                         imageDialog();
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                             color: whiteColor,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                   offset: Offset(1.0, 1.0),
//                                   color: greyColor.withOpacity(0.5),
//                                   blurRadius: 5.0,
//                                   spreadRadius: 5.0)
//                             ]),
//                         child: Icon(
//                           Icons.camera_alt,
//                           size: 3.5.h,
//                           color: greyColor,
//                         ),
//                       ),
//                     ))
//               ]),
//             ],
//           ),
//           pickedImage != null
//               ? Container(
//                   height: 200,
//                   child: PhotoViewGallery.builder(
//                     itemCount: galleryItems.length,
//                     builder: (context, index) {
//                       return PhotoViewGalleryPageOptions(
//                         imageProvider: FileImage(pickedImage!),
//                         heroAttributes: PhotoViewHeroAttributes(
//                             tag: galleryItems[index]["id"]),
//                         // Contained = the smallest possible size to fit one dimension of the screen
//                         minScale: PhotoViewComputedScale.contained * 0.8,
//                         // Covered = the smallest possible size to fit the whole screen
//                         maxScale: PhotoViewComputedScale.covered * 2,
//                       );
//                     },
//                     scrollPhysics: BouncingScrollPhysics(),
//                     // Set the background color to the "classic white"
//                     backgroundDecoration: BoxDecoration(
//                       color: Theme.of(context).canvasColor,
//                     ),
//                     loadingBuilder: (context, event) => Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//                 )
//               : Container()
//         ],
//       ),
//     );
//   }

//   void imageDialog() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
//             child: Container(
//               width: double.infinity,
//               // height: 400,
//               child: AlertDialog(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(15.0))),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             margin: EdgeInsets.only(bottom: 22),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Pick Image From",
//                                   style: TextStyle(
//                                       fontFamily: "Metropolis-Bold",
//                                       color: primaryFontColor,
//                                       fontSize: 16.sp),
//                                 ),
//                               ],
//                             )),
//                         SizedBox(
//                           height: 2.h,
//                         ),
//                         MaterialButton(
//                           elevation: 5,
//                           padding: EdgeInsets.symmetric(
//                               vertical:
//                                   MediaQuery.of(context).size.height * 0.025),
//                           shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(4.w))),
//                           minWidth: MediaQuery.of(context).size.width,
//                           color: secondaryColor,
//                           child: Text(
//                             "Camera",
//                             style: TextStyle(
//                                 color: whiteColor,
//                                 fontSize: 12.5.sp,
//                                 fontFamily: "metropolis-semibold"),
//                           ),
//                           onPressed: () {
//                             pickImage(ImageSource.camera);
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         SizedBox(
//                           height: 2.h,
//                         ),
//                         MaterialButton(
//                           elevation: 5,
//                           padding: EdgeInsets.symmetric(
//                               vertical:
//                                   MediaQuery.of(context).size.height * 0.025),
//                           shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(4.w))),
//                           minWidth: MediaQuery.of(context).size.width,
//                           color: secondaryColor,
//                           child: Text(
//                             "Gallery",
//                             style: TextStyle(
//                                 color: whiteColor,
//                                 fontSize: 12.5.sp,
//                                 fontFamily: "metropolis-semibold"),
//                           ),
//                           onPressed: () {
//                             pickImage(ImageSource.gallery);
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         SizedBox(
//                           height: 1.h,
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   pickImage(ImageSource imageType) async {
//     try {
//       final photo =
//           await ImagePicker().pickImage(source: imageType, imageQuality: 20);
//       if (photo == null) return;
//       final tempImage = File(photo.path);
//       setState(() {
//         pickedImage = tempImage;

//         // } else if (index == 1) {
//         //   pickedImage2 = tempImage;
//         // } else if (index == 2) {
//         //   pickedImage3 = tempImage;
//         // } else if (index == 3) {
//         //   pickedImage4 = tempImage;
//         // } else if (index == 4) {
//         //   pickedImage5 = tempImage;
//         // }
//       });
//     } catch (error) {
//       debugPrint(error.toString());
//     }
//   }
// }

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
                // [
                //   Material(
                //     color: Colors.transparent,
                //     child: GestureDetector(
                //       onTapDown: (details) {
                //         stackWidgets.add(Positioned(
                //             left: posx,
                //             top: posy,
                //             child: Container(
                //               height: 10,
                //               width: 10,
                //               decoration: BoxDecoration(
                //                   shape: BoxShape.circle, color: Colors.white),
                //             )));
                //         //local position
                //         print(details.localPosition.dx);
                //         //global position
                //         print(details.localPosition.dy);
                //         setState(() {
                //           posx = details.localPosition.dx;
                //           posy = details.localPosition.dy;
                //         });

                //         print(stackWidgets.length);
                //       },
                //       onTap: widget.onTap,
                //       child: Image.file(
                //         widget.photo,
                //         fit: BoxFit.fill,
                //       ),
                //     ),
                //   ),

                // widgets[0],
                // widgets[1],
                // widgets[2],
                // widgets[3],
                // Positioned(
                //     left: posx,
                //     top: posy,
                //     child: Container(
                //       height: 10,
                //       width: 10,
                //       decoration: BoxDecoration(
                //           shape: BoxShape.circle, color: Colors.white),
                //     ))
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
