
import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

class mongodatabase {
 
static connect() async { 
  
  var db = await Db.create("mongodb+srv://basheeer:basheer@cluster1.zjmmh.mongodb.net/test?retryWrites=true&w=majority");
  await db.open();
  inspect(db);
 var collection  = db.collection("123");
}


static Future save(Map<String ,dynamic> data) async { 
  
  var db = await Db.create("mongodb+srv://basheeer:basheer@cluster1.zjmmh.mongodb.net/test?retryWrites=true&w=majority");
  await db.open();
  inspect(db);
 var collection  = db.collection("123");
 await collection.insert(data).then((value) { 
   print("saved");
 });
}
}