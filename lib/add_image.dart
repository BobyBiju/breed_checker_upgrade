import 'dart:io';
import 'package:findmydog/breed_result.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class AddImage extends StatefulWidget {

  static String id = 'add_image';

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {

  // bool isLoading;
  // XFile imagee;
  // List outputt;
  bool pick;


  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   isLoading=true;
  //
  //   loadModel().then((value){
  //     setState(() {
  //       isLoading=false;
  //     });
  //   });
  //
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar:  AppBar(
        backgroundColor: Colors.white,
        title: ListTile(leading:Icon(FontAwesomeIcons.listUl,color: Colors.black,),title: Text('Screen 2',style: TextStyle(color: Colors.black),),),
      ),
      // body: isLoading?Container(
      //   alignment: Alignment.center,
      //   child: CircularProgressIndicator(),
      // ):Container(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //
      //       imagee==null?Container():Image.file(File(imagee.path)),
      //       SizedBox(height: 16,),
      //       outputt == null? Text(""):Text("${outputt[0]["label"]}",
      //         style: TextStyle(
      //             color: Colors.black
      //         ),)
      //     ],
      //   ),
      // ),
      body: Container(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
              child: FlatButton(

                child: Icon(Icons.camera,color: Colors.white,),
                color: Colors.black,




                onPressed: (){
                  pick = true;
                  // chooseImage();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BreedResult(pic: pick,),));
                },
              ),
            ),

            FlatButton(

              child: Text("Gallery",
                style: TextStyle(
                  color: Colors.white,
                ),),
              color: Colors.black,




              onPressed: (){
                pick = false;
                // chooseImage();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BreedResult(pic: pick,),));
              },
            ),

          ],
        ),
      ),
      // floatingActionButton: Center(
      //   child: FlatButton(
      //
      //     child: Text("Gallery",
      //       style: TextStyle(
      //         color: Colors.white,
      //       ),),
      //     color: Colors.black,
      //
      //
      //
      //
      //     onPressed: (){
      //       pick = false;
      //       // chooseImage();
      //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BreedResult(pic: pick,),));
      //     },
      //   ),
      // ),
    );
  }

  // chooseImage() async{
  //   final ImagePicker _picker = ImagePicker();
  //   // Pick an image
  //   final XFile image = await _picker.pickImage(source: ImageSource.gallery);
  //   if(image ==null) return null;
  //   setState(() {
  //     isLoading=true;
  //     imagee= image ;
  //   });
  //   runModelOnImage(image);
  // }

  // runModelOnImage(XFile image) async{
  //   var output= await Tflite.runModelOnImage(path: image.path,
  //       numResults: 2,
  //       imageMean: 127.5,
  //       imageStd: 127.5,
  //       threshold: 0.5);
  //
  //   setState(() {
  //     isLoading=false;
  //     imagee=image;
  //     outputt=output ;
  //   });
  //
  // }



  //
  // loadModel() async{
  //   await Tflite.loadModel(model: "assets/model_unquant.tflite",
  //       labels: "assets/labels.txt");
  //
  // }
}
