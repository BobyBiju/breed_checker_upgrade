//@dart=2.9

import 'package:findmydog/breed_result.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'add_image.dart';

void main(){
  runApp(MaterialApp(

    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),

    routes: {
      AddImage.id: (context) =>AddImage(),
      BreedResult.id: (context)=>BreedResult(),

    },
    home: HomePage(),
  ),);
}

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: ListTile(title: Text('Screen I',style: TextStyle(color: Colors.black),),leading:Icon(FontAwesomeIcons.listUl,color: Colors.black,) ,),
      ),

      floatingActionButton: Center(
        child: FlatButton(

          child: Text("Add Image",
          style: TextStyle(
            color: Colors.white,
          ),),
          color: Colors.black,




          onPressed: (){
            Navigator.pushNamed(context, AddImage.id);
          },
        ),
      ),
    );
  }






  loadModel() async{
    await Tflite.loadModel(model: "assets/model_unquant.tflite",
    labels: "assets/labels.txt");

  }
}

