import 'dart:io';
import 'dart:math';

import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallary/first_page.dart';
import 'package:photo_gallary/first_page11.dart';

void main()
{
  runApp(MaterialApp(
    home: second(),
  ));
}
class second extends StatefulWidget {
  const second({super.key});
  static Directory? dir;

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {

  final ImagePicker picker = ImagePicker();
  XFile? image;
  bool t= false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get()
  async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
      Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
          Permission.storage,
      ].request();
      print(statuses[Permission.location]);

      }


      var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/photo";
      print(path);

        second.dir=Directory(path);
        if(! await second.dir!.exists())
        {
        second.dir!.create();
        }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(onTap: () async {
          image = await picker.pickImage(source: ImageSource.gallery);
          print(image);
          // Image.file(File(image!.path));

          int random=Random().nextInt(100);
          String imag_name="${random}.png";
          File f = File("${second.dir!.path}/${imag_name}");
          await f.writeAsBytes(await image!.readAsBytes());
          String img_path=f.path;
          print(img_path);
          t=true;


          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return view_img(img_path,t);
          // },));

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return first(img_path,t);
          },));

          setState(() { });
        },
          child: Container(
            height: 50,
            width: 100,
            alignment: Alignment.center,
            color: Colors.pinkAccent,
            child: Text("OPEN PHOTO"),
          ),
        ),
      ),
    );
  }
}
