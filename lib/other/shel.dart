import 'dart:ui';

import 'package:final_/them/them.dart';
import 'package:flutter/material.dart';
import 'dart:math';
final GlobalKey<ScaffoldMessengerState>scaffoldKey=GlobalKey<ScaffoldMessengerState>();
void showMessageDown(varres){
    SnackBar messageDoun = SnackBar(content: Text(varres));
    scaffoldKey.currentState!.showSnackBar(messageDoun);
}


// ---------------tools----------------------
Text textStyle(ug){
  return Text(ug,style:TextStyle(
    color:Colors.white,
    fontWeight: FontWeight.bold,
    ));
}

// variables
final List<Map> kk = <Map>[
  {"id":"1","title":"نقرة مطولة للتعديل","note":""},
  {"id":"2","title":"نقرة واحدة للحذف","note":""},
];




// functions
bool addNewNote(title,note){
  String id ="";
  for(int i=0;i<8;i++){
    final random = Random();
    final chars = String.fromCharCode(random.nextInt(26)+65);
    id+=chars;
  }
  int lenList = kk.length;
  Map<String,dynamic> addNewNote={
  "id":id,
  "title":title,
  "note":note,
};
kk.add(addNewNote);
if(kk.length==lenList){
  return false;
}else{
  return true;
}
}
bool ch(tx1,tx2){
  if(tx1=="" || tx2==""){
    return false;
  }else{
    return true;
  }
}

