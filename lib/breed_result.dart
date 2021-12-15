import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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




  bool _isLoading;
  XFile _image;
  List _output;

  String _confidence="";
  double _percentage;
  String _name="";
  String numbers="";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading=true;

    loadModel().then((value){
      setState(() {
        _isLoading=false;
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
      body: _isLoading?Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ):Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            (_image==null) ? Container():(Image.file(File(_image.path))),
            SizedBox(height: 16,),
            _output == null? Text(""):Text("Name:$_name \n Confidence:$_confidence",
              style: TextStyle(
                  color: Colors.black
              ),),
            LinearPercentIndicator(
              animation: true,
              animationDuration: 1000,
              lineHeight: 30.0,
              percent: _percentage,
              progressColor: Colors.deepPurple,
              backgroundColor: Colors.deepPurple.shade100,
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
      _isLoading=false;
      _image=image;
      _output=output ;
      String str =_output[0]["label"];
      _name=str.substring(2);
      _confidence=_output!=null?(_output[0]['confidence']*100.0).toString().substring(0,2)+"%":"";
      _percentage=_output!=null?(_output[0]['confidence']):"";
    });

  }

  chooseImage(ImageSource source) async{
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile image = await _picker.pickImage(source: source);
    if(image ==null) return null;
    setState(() {
      _isLoading=true;
      _image= image ;
    });
    runModelOnImage(image);
  }

  loadModel() async{
    await Tflite.loadModel(model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt");

  }

}



