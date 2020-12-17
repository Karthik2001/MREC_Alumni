import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../SizeConfig/Size.dart';
import '../Widget/ToDoItem.dart';
import 'AddItem.dart';
import '../Operations/ReadAndWriteFile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTime ;
int leftoverPrecentage=0;
  File jsonFile;
  Directory dir;
  String fileName = "ToDoList.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  var ToDoList=[];
  List<dynamic> L;
  set(){
    setState(() {

     currentTime =(DateTime.now().hour*60)+ DateTime.now().minute;
      if(currentTime==1440)
      {
       ReadAndWriteFile().clearFile();
      }
      leftoverPrecentage = (((currentTime)/1440)*100).round();
    });
  }
  laa(){
    setState(() {
      readFile();

    });
  }

 readFile() async {
   await getExternalStorageDirectory().then((Directory directory) {
     dir = directory;

     jsonFile = new File(dir.path + "/" + fileName);
     fileExists = jsonFile.existsSync();
     if (fileExists)  fileContent = json.decode(jsonFile.readAsStringSync());

   });
setState(() {
  L= fileContent.values.toList();

  L.sort((a,b) => jsonDecode(b)['minutes'].compareTo(jsonDecode(a)['minutes']));

  L=L.reversed.toList();
});

 }

 @override
  void initState() {
   readFile();
    // TODO: implement initState
   currentTime =(DateTime.now().hour*60)+ DateTime.now().minute;
   leftoverPrecentage = (((currentTime)/1440)*100).round();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 100), (Timer t) => set());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          elevation: 0.1,
          title: Text("Let's Do",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontSize: 9.33*SizeConfig.blockSizeHorizontal,
                  color:  Colors.cyan[600],
              )
          ),

          actions: <Widget>[
            Center(
              child: Text(leftoverPrecentage.toString()+"% Day Complete   ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 5.33*SizeConfig.blockSizeHorizontal,
                    color:  Colors.cyan[600],
                  )
              ),
            ),
          ],
        ),

        body:fileExists&&L.length>0?ListView.builder(
          itemCount: L.length,
          itemBuilder: (context, index) {
            String name = jsonDecode(L[index])['title'].toString();

            String description = jsonDecode(L[index])['decription'].toString();
            String time = jsonDecode(L[index])['time'].toString();


            return ToDoItem(name,description,time,laa);
          },
        ):Center(
          child: Text("Hi ! Let's Plan the \n Day :)",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'NunitoSans',
                fontSize: 9.33*SizeConfig.blockSizeHorizontal,
                color:  Colors.cyan[600],
              )
          ),
        ),


        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>AddItem()));
          },
          child: Icon(Icons.add,color: Colors.black54,size: 5*SizeConfig.heightMultiplier,),
          backgroundColor: Colors.cyan[600],
        ),
      ),
    );
  }
}
