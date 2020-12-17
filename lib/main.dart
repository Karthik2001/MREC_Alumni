import 'package:flutter/material.dart';
import 'SizeConfig/Size.dart';
import 'package:flutter/services.dart';
import 'Pages/Home.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  runApp(Myapp());
}
class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(
        builder: (context,constraints){

          return OrientationBuilder(
              builder: (context,orientation){
                SizeConfig().init(constraints, orientation);
                return  MaterialApp(
                    color: Colors.cyan[600],
                    title: 'ToDo App',
                    debugShowCheckedModeBanner: false,
                    home :  Home(),
                    routes:{
                      '/home':(context)=>Home(),


                    }
                );
              }
          );
        }
    );
  }
}
