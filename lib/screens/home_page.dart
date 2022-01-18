import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child:const Icon(Icons.download_rounded,size: 30,),
              onPressed: (){

                 if (imageFile==null) {
                   Flushbar(
                    backgroundColor: Colors.red,
                    flushbarPosition: FlushbarPosition.TOP,
                      message:
                          'There isnot a image',
                          messageColor: Colors.white,
                      duration:const Duration(seconds: 3),
                    ).show(context);
                 } else {
                  GallerySaver.saveImage(imageFile!.path).then((value) async{
                  
                    imageFile=null;
                  setState(() {
                    
                  });
                  await Flushbar(
                    backgroundColor: Colors.black,
                    flushbarPosition: FlushbarPosition.TOP,
                      message:
                          'Image is saved to gallery',
                          messageColor: Colors.white,
                      duration:const Duration(seconds: 3),
                    ).show(context);
                
                }
                );
                 }

                
              },
            backgroundColor: Colors.black,),
           const SizedBox(height: 10,),
           const Text("Save",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),)
          ],
        ),
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: imageFile !=null? Container(
            width: 300,
            height: 300,
            child: Image.file(
                imageFile!,
                fit: BoxFit.cover,
              ),
            ): Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            child: InkWell(
              onTap: ()async{
               await _getFromCamera();
               setState(() {
                 
               });
              },
              child:const Icon(Icons.camera_alt,color: Colors.white,size: 70,)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.black,
            ),
          ),
        ),

      ),
    );
  }

  _getFromCamera() async {
    var pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
    );

    if (pickedFile != null) {
         imageFile = File(pickedFile.path);
         
    }
}
}