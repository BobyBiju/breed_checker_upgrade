import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'add_image.dart';

class ImageModel {

  bool isLoading;
  XFile imagee;
  List outputt;

  chooseImage() async{
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    if(image ==null) return null;
    // setState(() {
      isLoading=true;
      imagee= image ;
    // });
    // runModelOnImage(image);
  }

  runModelOnImage(XFile image) async{
    var output= await Tflite.runModelOnImage(path: image.path,
        numResults: 2,
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.5);
    // @override
    // setState(() {
      isLoading=false;
      imagee=image;
      outputt=output ;
    // });

  }




  loadModel() async{
    await Tflite.loadModel(model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt");

  }

}