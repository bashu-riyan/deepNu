import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  String typeOfPicture;

  TakePictureScreen({required this.typeOfPicture});
  // final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController? _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // _controller = CameraController(cameras[0], ResolutionPreset.max);
    // _controller!.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // });
    // // To display the current output from the Camera,
    // // create a CameraController.
    // _controller = CameraController(
    //   // Get a specific camera from the list of available cameras.
    //   cameras.first,
    //   // Define the resolution to use.
    //   ResolutionPreset.medium,
    // );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller!.initialize();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _controller!.dispose();
    } else if (state == AppLifecycleState.resumed) {}
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: SafeArea(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return Container(
                  color: Color.fromARGB(0, 0, 0, 0),
                  // height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                              color: Colors.transparent,
                              height: MediaQuery.of(context).size.height * 0.88,
                              child: CameraPreview(_controller!)),
                          Positioned(
                            left: MediaQuery.of(context).size.width * 0.43,
                            bottom: MediaQuery.of(context).size.height * 0.04,
                            child: Row(
                              children: [
                                FloatingActionButton(
                                  // Provide an onPressed callback.
                                  onPressed: () async {
                                    // Take the Picture in a try / catch block. If anything goes wrong,
                                    // catch the error.
                                    try {
                                      // Ensure that the camera is initialized.
                                      await _initializeControllerFuture;

                                      // Attempt to take a picture and get the file `image`
                                      // where it was saved.
                                      final image =
                                          await _controller!.takePicture();

                                      // If the picture was taken, display it on a new screen.
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DisplayPictureScreen(
                                            typeOfPicture: widget.typeOfPicture,
                                            // Pass the automatically generated path to
                                            // the DisplayPictureScreen widget.
                                            imagePath: image.path,
                                          ),
                                        ),
                                      );
                                    } catch (e) {
                                      // If an error occurs, log the error to the console.
                                      print(e);
                                    }
                                  },
                                  child: const Icon(Icons.camera_alt),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ));
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      // floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked ,
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  String typeOfPicture;

  DisplayPictureScreen(
      {Key? key, required this.imagePath, required this.typeOfPicture})
      : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  final RoundedLoadingButtonController _btnControllerForDone =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: SafeArea(
            child: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Hero(
                    tag: "upload",
                    child: PhotoView(
                      imageProvider: FileImage(
                        File(widget.imagePath),
                      ),
                    ))),
            Positioned(
                right: 15,
                bottom: 15,
                child: Container(
                  child: Row(
                    children: [
                      RoundedLoadingButton(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.3,
                          color: Color.fromARGB(255, 0, 0, 0),
                          child: Text('Done',
                              style: TextStyle(color: Colors.white)),
                          controller: _btnControllerForDone,
                          onPressed: () {
                            UploadImage();
                          })
                    ],
                  ),
                )),
            Positioned(
                left: 15,
                bottom: 15,
                child: Container(
                  child: Row(
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        minWidth: MediaQuery.of(context).size.width * 0.3,
                        height: 50,
                        color: Color.fromARGB(255, 0, 0, 0),
                        child: Text('cancel',
                            style: TextStyle(color: Colors.white)),
                        // controller: _btnControllerForDone,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ))
          ],
        )),
      ),
    );
  }

  Future UploadImage() async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(
          '/pet/${widget.typeOfPicture}/dp/${123}');

      UploadTask uploadTask = ref.putFile(File(widget.imagePath));
      uploadTask.then((val) async {
        var url = await ref.getDownloadURL();
        print("profile dp upload done");

        FirebaseFirestore.instance
            .collection("users")
            .doc("123")
            .set({
                                                        "${widget.typeOfPicture}":
                                                            url,
                                                      },SetOptions(merge: true)).then((value) {
          print('profile update done');
          _btnControllerForDone.success();
        Navigator.pop(context);
        Navigator.pop(context);
        });
      });
    } catch (e) {
      _btnControllerForDone.error();
    }
  }
}

// class ExpandedDrag extends StatefulWidget {
  
//   @override
//   State<ExpandedDrag> createState() => _ExpandedDragState();
// }

// class _ExpandedDragState extends State<ExpandedDrag> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
    
//   }
//   // final Article article;
//   @override
//   Widget build(BuildContext context) {

//   final firstCamera = cameras!.first;

//  return  Scaffold(
//                 body: SnappingSheet(

//                       snappingPositions: [
//             SnappingPosition.factor(
//                 positionFactor: 0.0,
//                 snappingCurve: Curves.fastOutSlowIn,
//                 // snappingDuration: Duration(seconds: 1),
//                 grabbingContentOffset: GrabbingContentOffset.top,
//             ),
//             SnappingPosition.pixels(
//                 positionPixels: 400,
//                 snappingCurve: Curves.fastOutSlowIn,
//                 // snappingDuration: Duration(milliseconds: 1750),
//             ),
//             SnappingPosition.factor(
//                 positionFactor: 1.0,
//                 snappingCurve: Curves.fastOutSlowIn,
//                 // snappingDuration: Duration(seconds: 1),
//                 grabbingContentOffset: GrabbingContentOffset.bottom,
//             ),
//         ],
//                     // TODO: Add your content that is placed
//                     // behind the sheet. (Can be left empty)
//                     child: TakePictureScreen(camera: firstCamera,), 
//                     grabbingHeight: 75,
//                     // TODO: Add your grabbing widget here,
//                     grabbing: Container(
//                       decoration: BoxDecoration( 
//                                               color: Colors.white,
//                         borderRadius: BorderRadius.only(topLeft: Radius.circular(20) ,topRight:  Radius.circular(20))
//                       ),

//                       height: 10,
//                       child: Icon(Icons.arrow_upward)),
//                     sheetBelow: SnappingSheetContent(
//                         draggable: true,
//                         // TODO: Add your sheet content here
//                         child:  GridGallery(),
//                     ),
//                 ),
//             );   
   
//     // return ExpandablePanel(
      
//     //   controller: _expandableController,
//     //   theme: ExpandableThemeData(
//     //     iconColor: Colors.white,
//     //     iconPadding: EdgeInsets.symmetric( vertical: 5,  horizontal: MediaQuery.of(context).size.width*0.45),
        
//     //     tapBodyToCollapse: true,
        
//     //   ),
//     //   header:Container(color: Colors.transparent,),
//     //   collapsed: Container(
//     //     color: Color.fromARGB(0, 218, 218, 218),
//     //     width : 400,
//     //     height: 100,
//     //     child: ListGallery(),
//     //   ) ,
//     //   expanded: Container(
//     //     height: MediaQuery.of(context).size.height*0.80,
//     //         width: MediaQuery.of(context).size.width,
//     //     child: GridGallery()) ,
    
//     // );

//   }
// }



















// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

