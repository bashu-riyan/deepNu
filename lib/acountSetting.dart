import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deepn/savingData.dart';
import 'package:deepn/scheema/scheema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AccountSettings extends StatefulWidget {

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
TextEditingController nameController = TextEditingController();

TextEditingController emailController = TextEditingController();

TextEditingController phoneController = TextEditingController();

TextEditingController DobController = TextEditingController();

TextEditingController genderController = TextEditingController();

TextEditingController ownerController = TextEditingController();

TextEditingController cityController = TextEditingController();
TextEditingController aboutController = TextEditingController();
RoundedLoadingButtonController btnController  = RoundedLoadingButtonController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  aboutController.text = "I’m simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's and also standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic and also typesetting, remaining essentially unchanged can be.";
  }

  @override
  Widget build(BuildContext context) {
    
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Accounts Settings" ,style: TextStyle(color: Color(0xff000000) ,fontWeight: FontWeight.w700 ,fontSize: 20),) ,
          deepCustomField(controller: nameController,hintText:"Enter your name" , label:"Name",makeWidth: false,) ,
      Divider(), 
           
               Row(
                
                mainAxisSize: MainAxisSize.min,
                children: [
                  deepCustomField(controller: emailController,hintText:"Enter your email" , label:"Email",makeWidth: true,),
                  Column(
                    children: [
                      FlutterSwitch(
                        width: 50,
                        height: 30,
                        value: Provider.of<SaveData>(context ,listen: true).getEmailPrivate,
                        inactiveSwitchBorder: Border.all(
                          width: 2
                        ),
                        inactiveToggleBorder: Border.all(
                          color: Colors.black,
                          width: 2
                          
                        ),
                        inactiveColor: Colors.white,
                        activeColor: Colors.black,
                        onToggle: (v){
                           Provider.of<SaveData>(context ,listen: false).setEmailPrivate = v;
                        },
                      ),
                      Text( "${ Provider.of<SaveData>(context ,listen: true).getEmailPrivate?  "Public" : "Private"}")
                    ],
                  )
                  
                ],
              ),
             Divider(), 
              Row(
                children: [
                  deepCustomField(controller: phoneController,hintText:"Enter your phone" , label:"Phone",makeWidth: true),
                   Column(
                    children: [
                      FlutterSwitch(
                        width: 50,
                        height: 30,
                       value: Provider.of<SaveData>(context ,listen: true).getphonePrivate,
                        inactiveSwitchBorder: Border.all(
                          width: 2
                        ),
                        inactiveToggleBorder: Border.all(
                          color: Colors.black,
                          width: 2
                          
                        ),
                        inactiveColor: Colors.white,
                        activeColor: Colors.black,
                        onToggle: (v){
                          Provider.of<SaveData>(context ,listen: false).setphoneprivate = v;
                        },
                      ),
                      Text( Provider.of<SaveData>(context ,listen: false).getphonePrivate? "Public" : "Private")
                    ],
                  )
                  
                ],
              ) ,
                 Divider(), 
                deepCustomField(controller: DobController,hintText:"Select your Dob" , label:"DOB",makeWidth: false,),
                    Divider(), 
                  deepCustomField(controller: genderController,hintText:"Enter your Gender" , label:"Gender",makeWidth: false,),
                      Divider(), 
                    deepCustomField(controller: ownerController,hintText:"Enter your Status" , label:"Status",makeWidth:false ,),
                        Divider(), 
                      Row(
                     
                        children: [
                          deepCustomField(controller: cityController,hintText:"Enter your City" , label:"City",makeWidth: true, ),
                           Column(
                           
                    children: [
                      FlutterSwitch(
                        width: 50,
                        height: 30,
                       value: Provider.of<SaveData>(context ,listen: true).getCityPrivate,
                        inactiveSwitchBorder: Border.all(
                          width: 2
                        ),
                        inactiveToggleBorder: Border.all(
                          color: Colors.black,
                          width: 2
                          
                        ),
                        inactiveColor: Colors.white,
                        activeColor: Colors.black,
                        onToggle: (v){ 
                          Provider.of<SaveData>(context ,listen: false).setcityPrivate = v;
                        },
                      ),
                      Text( Provider.of<SaveData>(context ,listen: true).getCityPrivate? "Public" : "Private")
                    ],
                  )
                  
                        ],
                      ),
                      
                          Divider(), 
                        Row(
                             mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            deepAboutCustomField(controller: aboutController,hintText:"About" , label:"About", makeWidth: true, ),
                             Column(
                    children: [
                      FlutterSwitch(
                        width: 50,
                        height: 30,
                       value: Provider.of<SaveData>(context ,listen: true).getAboutPrivate,
                        inactiveSwitchBorder: Border.all(
                          width: 2
                        ),
                        inactiveToggleBorder: Border.all(
                          color: Colors.black,
                          width: 2
                          
                        ),
                        inactiveColor: Colors.white,
                        activeColor: Colors.black,
                        onToggle: (v){
                           Provider.of<SaveData>(context ,listen: false).setAboutPrivate =v;
                        },
                      ),
                      Text( Provider.of<SaveData>(context ,listen: true).getAboutPrivate? "Public" : "Private")
                    ],
                  )
                  
                          ],
                        )
          , Divider(), 

          RoundedLoadingButton( 
            height: 67,
            borderRadius: 7,
            color: Color(0xff1F2A4A),
            controller: btnController, onPressed: (){ 
            final pro =   Provider.of<SaveData>(context ,listen: false);


              // FirebaseFirestore.instance.collection("users").doc("123").set({ 
              //   "name": nameController.text,
              //   "email": emailController.text ,
              //   "phone": phoneController.text,
              //   "DOB": DobController.text,
              //   "gender": genderController.text,
              //   "status": ownerController.text,
              //   "city": cityController.text,
              //   "about": aboutController.text,
              //   "isEmailPrivate": pro.getEmailPrivate,
              //   "isPhonePrivate": pro.getphonePrivate,
              //   "cityPrivate": pro.getCityPrivate,
              //   "isAboutPrivate": pro.getAboutPrivate,
              // } ,SetOptions(merge: true)).then((value) { 
              //   btnController.reset();
              // });

Map<String ,dynamic> data ={ 
                "name": nameController.text,
                "email": emailController.text ,
                "phone": phoneController.text,
                "DOB": DobController.text,
                "gender": genderController.text,
                "status": ownerController.text,
                "city": cityController.text,
                "about": aboutController.text,
                "isEmailPrivate": pro.getEmailPrivate,
                "isPhonePrivate": pro.getphonePrivate,
                "cityPrivate": pro.getCityPrivate,
                "isAboutPrivate": pro.getAboutPrivate,
              } ;
              mongodatabase.save(data).then((value) { 
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved")));
                 nameController.text ='';
               emailController.text = "" ;
              phoneController.text = "";
               DobController.text ="";
                genderController.text = "";
         ownerController.text = "";
                 cityController.text = "";
                aboutController.text ="";
                setState(() {
                  
                });
              
              });
Timer(Duration(seconds:5 ,), (){ 
btnController.reset();
});

          }, child: Text("Save",style: TextStyle(fontSize: 17 ,fontWeight: FontWeight.w600),))
        ],
      ),
    );
  }
}

class deepCustomField extends StatelessWidget {
   deepCustomField(
  {required this.controller ,
  required this.hintText ,required this.label ,required this.makeWidth}
       );
TextEditingController controller;
String label ,hintText ;
bool makeWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: makeWidth ? MediaQuery.of(context).size.width*0.7 :MediaQuery.of(context).size.width  *0.8,
      padding: EdgeInsets.only(top: 15),
      child: Column( 
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label ,style: TextStyle(fontSize: 17 ,fontWeight: FontWeight.w600 , color: Color(0xff838383)),),
          TextFormField(
            controller: controller,
            decoration: InputDecoration( 
              hintText: hintText,
                 border: InputBorder.none,
              focusedBorder: InputBorder.none,
            hoverColor: Colors.black
            ),
          ) ,

        ],
      ),
    );
  }
}

class deepAboutCustomField extends StatelessWidget {
   deepAboutCustomField(
  {required this.controller ,
  required this.hintText ,required this.label ,required this.makeWidth}
       );
TextEditingController controller;
String label ,hintText ;
bool makeWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: makeWidth ? MediaQuery.of(context).size.width*0.7 :MediaQuery.of(context).size.width  *0.8,
      padding: EdgeInsets.only(top: 15),
      child: Column( 
   
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label ,style: TextStyle(fontSize: 17 ,fontWeight: FontWeight.w600 , color: Color(0xff838383)),),
          TextFormField(
            maxLines: 6,
            controller: controller,
            decoration: InputDecoration( 
              hintText: hintText,
                 border: InputBorder.none,
              focusedBorder: InputBorder.none,
            hoverColor: Colors.black
            ),
          ) ,

        ],
      ),
    );
  }
}