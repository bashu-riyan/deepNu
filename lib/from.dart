import 'package:deepn/acountSetting.dart';
import 'package:deepn/photo%20update/photo_updater.dart';
import 'package:deepn/picSection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FromForSaveData extends StatelessWidget {
  const FromForSaveData({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                backgroundColor: Color(0xff1F2A4A),
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width, 
            height: MediaQuery.of(context).size.height,
            child: Stack( 
              children: [
              Container(
                  width: MediaQuery.of(context).size.width, 
              
            color: Color(0xff1F2A4A),
            child: Padding(
              padding:  EdgeInsets.symmetric( horizontal: 12.0 ,vertical: 23),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){ 
                   
                    },
                    child: SvgPicture.asset("assets/Vector (12).svg")),
                  SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                  Text("Account Settings" ,style: TextStyle(fontWeight: FontWeight.w700 , fontSize: 20 ,color: Color(0xffFFFFFF)),)
                ],
              ),
            ),
              )
              
              ,Positioned( 
                top: 73,
                child: Container( 
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20) , topRight: Radius.circular(20) )
                  ),
                  height: MediaQuery.of(context).size.height, 
                  width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  Container(
                            margin: EdgeInsets.all(22),
                    child: PicSection(),
                  ) ,
                       Container(
                            margin: EdgeInsets.all(22),
                    child: AccountSettings(),
                  ) ,
                  SizedBox(height: MediaQuery.of(context).size.height*0.3,)
                ],
              ),
                ),
              )
              ],
            )
          ),
        ),
      ),
    );
  }
}


