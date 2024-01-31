import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    home: view_img(),));
}
class view_img extends StatefulWidget {
  // const view_img(String img_path, {super.key});
  String? img_path;
  bool? t;
  view_img([this.img_path,this.t]);

  @override
  State<view_img> createState() => _view_imgState();
}

class _view_imgState extends State<view_img> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.img_path);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100,
        width: 100,
        color: Colors.black,
        child: (widget.t==true)?Image.file(fit: BoxFit.fill,File(widget.img_path!)):null,
      ),
    );
  }
}
