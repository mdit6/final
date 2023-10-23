import 'dart:html';

import 'package:flutter/material.dart';
import 'package:final_/them/them.dart';
import 'package:final_/other/shel.dart';
// import 'package:flutter/services.dart';

class note extends StatefulWidget {
  const note({ Key? key }) : super(key: key);
  @override
  _noteState createState() => _noteState();
}
class _noteState extends State<note> {
  @override
  int inEdit=0;
  String editNoteTitle = "";
  String editNoteNote = "";
  TextEditingController titleEdit = TextEditingController();
  TextEditingController noteEdit = TextEditingController();
  TextEditingController title1 = TextEditingController(text: "");
  TextEditingController note1 = TextEditingController(text: "");

  Widget build(BuildContext context) {
   return Padding(
      padding: EdgeInsets.all(0),
      child: ScaffoldMessenger(
        key: scaffoldKey,
        child: Scaffold(

        appBar: AppBar(
        backgroundColor: father_color,
        title: Center(
          child: Text("الملاحظات"),
          ),
        actions: [
          IconButton(
           icon:const Icon(Icons.add),
           tooltip: 'انشاء ملاحظة',
            onPressed: (){
              //showMessageDown('انشاء ملاحظة');
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context)=> _screnAdd()));
              }
          ),
          ],
      ),
      body: dolist(),
      ),
      ),
      );
  }


Widget _screnAdd(){
  return Scaffold(
    appBar: AppBar(
    title: Text("انشاء ملاحظة"),
    ),
    body: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
          autofocus: true,
          controller: title1,
          textDirection: TextDirection.rtl,
          decoration:InputDecoration(
            label: Text('الموضوع'),
          ),
        )),
        
        SizedBox(height:20),

        Padding(padding: EdgeInsets.all(8),
        child: TextField(
          autofocus: true,
          controller: note1,
          textDirection: TextDirection.rtl,
          decoration:InputDecoration(
            label: Text('الملاحظة'),
          ),
        )),

        IconButton(
        icon:const Icon(Icons.save),
        tooltip: 'حفظ',
        color: father_color,
        onPressed: (){
          if(ch(title1.text,note1.text)==false){
            showMessageDown("لا يمكن ان تكون الحقول فارغة.");
            Navigator.of(context).pop();
          }else{
            if(addNewNote(title1.text,note1.text)==true){
            setState(() {
              dolist();
            });
            Navigator.of(context).pop();
          }
          }
        }
      ),

      ],
    ),
  );
}

Widget _screenEdit(){
  return Scaffold(
    appBar: AppBar(
      title: Text("تعديل الملاحظة"),
    ),
    body: SafeArea(
      child: Column(
        children: [
          SizedBox(height:20),
          TextField(
            controller: titleEdit,
            textDirection: TextDirection.rtl,
            autofocus: true,
            decoration:InputDecoration(
            label: Text('العنوان'),
          ),
          ),
          TextField(
            controller: noteEdit,
            textDirection: TextDirection.rtl,
            autofocus: true,
            decoration:InputDecoration(
            label: Text('الملاحظة'),
          ),
          ),
          SizedBox(height: 20,),
          IconButton(
            onPressed:()=>{
             EditNote(titleEdit.text,noteEdit.text),
            },icon: Icon(Icons.home),
            ),
        ],

      ),
    ),
  );
}

Future<void> _alert(int ii) async{
  switch (await showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        // title: Text(''),
        content: Text("هل تريد حذف الملاحظة"),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context,"حذف");
            },
            child: Text("حذف"),
            ),
          TextButton(
            onPressed: (){
              Navigator.pop(context,'الغاء');
            },
            child:const Text('الغاء'),
            ),
        ],
      );
    }
    )){
      case 'حذف':
    deleteNote(ii);
      // ...
      break;
      case 'الغاء':
      // ...
      break;
    }
}
Widget dolist(){
  return ListView.builder(
    itemCount: kk.length,

    itemBuilder:(BuildContext context,int index){
      return toitem(kk[index]["title"].toString(),kk[index]["note"].toString(),index);
    },
  );
}
Widget toitem(String txt,String txt2,int ii){
  return Container(
    padding: EdgeInsets.all(4),
    color: sub_color,
    


    child: ListTile(
    title: Text(txt),
    subtitle: Text(txt2),
    leading:const Icon(Icons.note),
    onTap: ()=>{
      _alert(ii)
    },
    onLongPress: ()=>{
       Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context)=>_screenEdit())),
      cEditNote(ii),
    },
  ),
  );
}
void deleteNote(index){
  kk.removeAt(index);
  setState(() {
    dolist();
    showMessageDown("تم الحذف بنجاح");
  });
}

void cEditNote(index){
  setState(() {
    titleEdit.text=kk[index]["title"];
    noteEdit.text=kk[index]["note"];
    inEdit=index;

  });
}
void EditNote(txt11,txt12){
  if(ch(txt11,txt12)==false){
    Navigator.of(context).pop();
    showMessageDown('لا يمكن ترك الحقول فارغة.');
  }else{
  setState(() {
    editNoteTitle=titleEdit.text;
    editNoteNote=noteEdit.text;
    kk[inEdit]["title"]=editNoteTitle;
    kk[inEdit]["note"]=editNoteNote;
    Navigator.of(context).pop();
    dolist();
    showMessageDown('تم التعديل بنجاح');
  });
  }
}
}
