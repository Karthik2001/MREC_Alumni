
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:todo/Operations/ToDoTask.dart';

import 'ToDoTask.dart';
import 'package:path_provider/path_provider.dart';
class ReadAndWriteFile{
  File jsonFile;
  Directory dir;
  String fileName = "ToDoList.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;
  var ToDoList=[];


  void createFile(ToDoTask T, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    Map<String, dynamic> Content={json.encode(T.minutes):jsonEncode(T.toJson())};
    file.writeAsStringSync(json.encode(Content));
  }

  Future<void> writeToFile(ToDoTask T) async {
    List<dynamic> L;
    await getExternalStorageDirectory().then((Directory directory) {
      dir = directory;
      print(dir);
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)  fileContent = json.decode(jsonFile.readAsStringSync());
    });
    print("Writing to file!");

    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      print(jsonFileContent);


      Map<String, dynamic> Content={json.encode(T.minutes):jsonEncode(T.toJson())};
      jsonFileContent.addAll(Content);


      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist!");

      print(dir);
      createFile(T, dir, fileName);

    }
    fileContent = json.decode(jsonFile.readAsStringSync());
    print(fileContent);



  }
  Future<void> clearFile() async {
    List<dynamic> L;
    await getExternalStorageDirectory().then((Directory directory) {
      dir = directory;
      print(dir);
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)  fileContent = json.decode(jsonFile.readAsStringSync());
    });
    print("Writing to file!");

    if (fileExists) {
      Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.clear();
    }



  }

  Future<void> deleteItem(BuildContext context,String time,String title) async {
    List<dynamic> L;
    await getExternalStorageDirectory().then((Directory directory) {
      dir = directory;
      print(dir);
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)  fileContent = json.decode(jsonFile.readAsStringSync());
    });
    print("Writing to file!");

    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());

        jsonFileContent.removeWhere((key, value) => time ==jsonDecode(value)['time'].toString() && title ==jsonDecode(value)['title'].toString());
        print(jsonFileContent);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
     // Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);


    } else {
      print("File does not exist!");

      print(dir);

    }




  }



}