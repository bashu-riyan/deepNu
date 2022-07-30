import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deepn/photo%20update/cameraforuploading.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:photo_manager/photo_manager.dart';


import 'package:photo_view/photo_view.dart';

class CameraPage extends StatefulWidget {
  String typeOfPicture;

  CameraPage({required this.typeOfPicture});
  // final ValueChanged<String> onSelected;
  // CameraPage(this.onSelected);
  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  File? file;
  List<AssetEntity> assets = [];

  _fetchAssets() async {
    final albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
        filterOption: FilterOptionGroup(imageOption: FilterOption()));
    print(albums);
    final recentAlbum = albums.first;
    // List<AssetEntity> recentAssets = [];
    // await albums.forEach((element) async{recentAssets.addAll(await element.getAssetListRange(start: 0, end: 10000));});
    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 500,
    );

    setState(() {
      assets = recentAssets;
      // image = assets[0].file;
    });
  }


  @override
  void initState() {
    super.initState();

    _fetchAssets();
  }

  double opacity = 0.0;
  bool expanded = false;
  @override
  void dispose() {
    super.dispose();
  }

  // final firstCamera = cameras.first;

  double gallheight = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool frontcam;
    bool noGallery = true;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0000000),
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            child: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: size.height * 0.016),
                      Expanded(
                        child: Stack(
                          children: [
                            // !expanded
                            //     ? TakePictureScreen(
                            //         typeOfPicture: widget.typeOfPicture,
                            //       )
                            //     : Container(),
                            Positioned(
                              bottom: size.height * 0.18,
                              child: GestureDetector(
                                onVerticalDragUpdate: (details) {
                                  if (!expanded) if (details.delta.dy < 0) {
                                    setState(() {
                                      expanded = true;
                                      opacity = 1.0;
                                      gallheight = size.height * 0.96;
                                    });
                                  }
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      CupertinoIcons.chevron_up,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    Container(
                                      color: Colors.transparent,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (_, i) {
                                          return FutureBuilder<Uint8List?>(
                                            future: assets[i].thumbnailData,
                                            builder: (_, snapshot) {
                                              final bytes = snapshot.data;
                                              if (bytes == null)
                                                return Container(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              return InkWell(
                                                onLongPress: () async {
                                                  File? file =
                                                      await assets[i].file;
                                                  assets[i].file.then((value) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Dialog(
                                                            child: PhotoView(
                                                              imageProvider:
                                                                  FileImage(
                                                                      value!),
                                                            ),
                                                          );
                                                        });
                                                    print(value!.path);
                                                  });
                                                },
                                                onTap: () async {
                                                  File? file =
                                                      await assets[i].file;
                                                  if (assets[i].type ==
                                                      AssetType.video) {
                                                  } else {
                                                    assets[i]
                                                        .file
                                                        .then((value) {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return DisplayPictureScreen(
                                                          typeOfPicture: widget
                                                              .typeOfPicture,
                                                          imagePath:
                                                              value!.path,
                                                        );
                                                      }));
                                                      print(value!.path);
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.1,
                                                  padding: EdgeInsets.all(4),
                                                  child: Image.memory(bytes,
                                                      fit: BoxFit.cover),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        itemCount: assets.length,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 600),
                                  width: size.width,
                                  height: gallheight,
                                  curve: Curves.slowMiddle,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Color.fromRGBO(0, 23, 36, opacity)
                                        : Colors.white.withOpacity(opacity),
                                  ),
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                expanded = false;
                                                opacity = 0;
                                                gallheight = 0;
                                              });
                                            },
                                            child: Icon(
                                              Icons.arrow_back,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Text(
                                            'RECENTS',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.016),
                                        Expanded(
                                          child: GridView.builder(
                                            // controller:sc,
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              crossAxisSpacing: 4,
                                              mainAxisSpacing: 4,
                                            ),
                                            itemBuilder: (context, i) {
                                              return FutureBuilder<Uint8List?>(
                                                future: assets[i].thumbnailData,
                                                builder: (context, snapshot) {
                                                  final bytes = snapshot.data;
                                                  if (bytes == null)
                                                    return Container();
                                                  return GestureDetector(
                                                    onLongPress: () async {
                                                      File? file =
                                                          await assets[i].file;
                                                      assets[i]
                                                          .file
                                                          .then((value) {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return Dialog(
                                                                child:
                                                                    PhotoView(
                                                                  imageProvider:
                                                                      FileImage(
                                                                          value!),
                                                                ),
                                                              );
                                                            });
                                                        print(value!.path);
                                                      });
                                                    },
                                                    onTap: () async {
                                                      File? file =
                                                          await assets[i].file;
                                                      if (assets[i].type ==
                                                          AssetType.video) {
                                                      } else {
                                                        assets[i]
                                                            .file
                                                            .then((value) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return DisplayPictureScreen(
                                                              typeOfPicture: widget
                                                                  .typeOfPicture,
                                                              imagePath:
                                                                  value!.path,
                                                            );
                                                          }));
                                                          print(value!.path);
                                                        });
                                                      }
                                                    },
                                                    child: Image.memory(bytes,
                                                        fit: BoxFit.cover),
                                                  );
                                                },
                                              );
                                            },
                                            itemCount: assets.length,
                                          ),
                                        ),
        //                                 Align(
        //                                     alignment: Alignment.bottomCenter,
        //                                     child: InkWell(
        //                                         onTap: () async {
        //                                           try {
        //                                             final pickedFile =
        //                                                 await ImagePicker()
        //                                                     .getImage(
        //                                                         source:
        //                                                             ImageSource
        //                                                                 .gallery);
        //                                             PickedFile? file =
        //                                                 await pickedFile;
        //                                             Navigator.pop(context);
        //                                             Reference ref = FirebaseStorage
        //                                                 .instance
        //                                                 .ref()
        //                                                 .child(
        //                                                     '/serviceProviders/dp/${widget.typeOfPicture}/${FirebaseAuth.instance.currentUser!.uid}');

        //                                             UploadTask uploadTask =
        //                                                 ref.putFile(
        //                                                     File(file!.path));
        //                                             uploadTask
        //                                                 .whenComplete(() async {
        //                                               var url = await ref
        //                                                   .getDownloadURL();
        //                                               print(
        //                                                   "profile dp upload done");

        //                                               FirebaseFirestore.instance
        //                                                   .collection(
        //                                                       "serviceProvidersPictures")
        //                                                   .doc(FirebaseAuth
        //                                                       .instance
        //                                                       .currentUser!
        //                                                       .uid)
        //                                                   .set({
        //                                                 "${widget.typeOfPicture}":
        //                                                     url,
        //                                               },SetOptions(merge: true)).then((value) {
        //                                                 print(
        //                                                     'profile update done');
        //                                                       Navigator.pop(context);
        // // Navigator.pop(context);
        //                                               });
        //                                             });
        //                                           } catch (e) {
        //                                             print(e);
        //                                           }
        //                                         },
        //                                         child: Container(
        //                                             height: 50,
        //                                             child: Center(
        //                                               child: Text(
        //                                                 'Show all photos...',
        //                                                 style: TextStyle(
        //                                                     color: Colors.blue),
        //                                               ),
        //                                             ))))
                                      
                                      
                                      ],
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
