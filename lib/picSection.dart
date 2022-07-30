
import 'package:deepn/photo%20update/photo_updater.dart';
import 'package:flutter/material.dart';

class PicSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children : [
        Container(
  margin: EdgeInsets.only(left: 60),
          decoration: BoxDecoration( 
            borderRadius: BorderRadius.circular(100),
            boxShadow: [ 
              BoxShadow(color: Colors.black12,
              blurRadius: 12,
              spreadRadius: 5
              )
            ]
          ),
          child: ClipRRect( 
            borderRadius: BorderRadius.circular(100),
            child: InkWell( 
              onTap: (){ 
                   showModalBottomSheet(
                     
                  isScrollControlled: true,
                     context: context, builder: (context){ 
                        return CameraPage(typeOfPicture: "Picture",);
                      });
              },
              child: Image.asset("assets/unsplash_RBerxXPnZPE.png")),
          ),
        ) ,
        TextButton(
          
          onPressed: (){ 

        }, child: Text("Save" ,style: TextStyle(color: Colors.black),))
      ]
    );
  }
}