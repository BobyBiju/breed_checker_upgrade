import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'add_image.dart';

class BreedResult extends StatefulWidget {


  final bool pic;

  BreedResult({this.pic});


  static String id = 'breed_result';


  @override
  _BreedResultState createState() => _BreedResultState();
}

class _BreedResultState extends State<BreedResult> {




  bool isLoading;
  XFile imagee;
  List outputt;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading=true;

    loadModel().then((value){
      setState(() {
        isLoading=false;
      });
    });
    
    widget.pic?chooseImage(ImageSource.camera):chooseImage(ImageSource.gallery);

  }

  @override
  Widget build(BuildContext context) {

    // Future.delayed(Duration.zero,() {
    //   chooseImage();
    // });

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar:  AppBar(
        backgroundColor: Colors.white,
        title: ListTile(leading:Icon(FontAwesomeIcons.listUl,color: Colors.black,),title: Text('Screen 3',style: TextStyle(color: Colors.black),),),
      ),
      body: isLoading?Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ):Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            (imagee==null) ? Container():(Image.file(File(imagee.path))),
            SizedBox(height: 16,),
            outputt == null? Text(""):Text("${outputt[0]["label"]}",
              style: TextStyle(
                  color: Colors.black
              ),)
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
      //       chooseImage();
      //     },
      //   ),
      // ),
    );
  }

  runModelOnImage(XFile image) async{
    var output= await Tflite.runModelOnImage(path: image.path,
        numResults: 2,
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.5);

    setState(() {
      isLoading=false;
      imagee=image;
      outputt=output ;
    });

  }

  chooseImage(ImageSource source) async{
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile image = await _picker.pickImage(source: source);
    if(image ==null) return null;
    setState(() {
      isLoading=true;
      imagee= image ;
    });
    runModelOnImage(image);
  }

  loadModel() async{
    await Tflite.loadModel(model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt");

  }

}



