import 'package:deepn/from.dart';
import 'package:deepn/savingData.dart';
import 'package:deepn/scheema/scheema.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()  async {
    WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();

 await mongodatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => SaveData()),
      ],
      child: MaterialApp(

        theme: ThemeData(
    
          primarySwatch: Colors.blue,
        ),
        home:  FromForSaveData(),
      ),
    );
  }
}

