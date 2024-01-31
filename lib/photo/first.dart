import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_gallary/photo/second.dart';

void main()
{
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,home: one(),
    ));
}
class one extends StatefulWidget {
  const one({super.key});

  @override
  State<one> createState() => _oneState();
}

class _oneState extends State<one> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: SafeArea(child:
    Scaffold(
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          // color: Colors.pinkAccent,
          decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.fitHeight,image: AssetImage("images/game_background.jpg")),
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              return Container(
                height: 5,
                width: 5,
                decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/wood_block.jpg"))),
              );
            },
          ),
        ),
        Column(children: [
          Expanded(flex: 7,child: Container(
            height: double.infinity,
            width: double.infinity,
            // color: Colors.pinkAccent,
          )),
          Expanded(flex: 2,child: Container(
            height: double.infinity,
            width: double.infinity,
            // color: Colors.green,
            alignment: Alignment.center,
            child: Text("PHOTO",style: TextStyle(fontSize: 55,letterSpacing: 3,fontFamily: "three",color: Colors.white),),
          )),
          Expanded(flex: 1,child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.lime.shade900,
            // Color(0xFF827717),
            child: Center(child: Text("Play with photos",style: TextStyle(fontSize: 16,color: Colors.yellow,letterSpacing: 3.0),)),
          )),
          Expanded(flex: 2,child: Container(
            height: double.infinity,
            width: double.infinity,
            // color: Colors.brown,
            alignment: Alignment.center,
            child: Text("PUZZLES",style: TextStyle(fontSize: 55,letterSpacing: 4,fontFamily: "three",color: Colors.lightGreenAccent.shade400),),
          )),
          Expanded(flex: 6,child: Container(
            height: double.infinity,
            width: double.infinity,
            // color: Colors.pinkAccent,
          )),
          Expanded(flex: 2,child: Container(
            height: double.infinity,
            width: double.infinity,
            // color: Colors.lightGreen,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
              Expanded(flex: 1,child: Container(
                height: double.infinity,
                width: 70,
                margin: EdgeInsets.fromLTRB(50, 5, 10, 5),
                decoration: BoxDecoration(
                  // color: Colors.blue,
                    image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/wood_but.png"))
                ),
                child: Column(children: [
                  SizedBox(height: 10,),
                  Text("Open Photos",style: TextStyle(fontSize: 15,letterSpacing: 1,fontFamily: "three",color: Colors.white),),
                  SizedBox(height: 4,),
                  Container(
                    height: 25,width: 25,
                    decoration: BoxDecoration(
                      // color: Colors.yellow
                        image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/gallery_icon.png"))
                    ),
                  ),
                ]),
              )),
              Expanded(flex: 1,child: InkWell(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return two();
                },));
                setState(() { });
              },
                child: Container(
                  height: double.infinity,
                  width: 70,
                  margin: EdgeInsets.fromLTRB(10, 5, 50, 5),
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                      image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/wood_but.png"))
                  ),
                  child: Column(children: [
                    SizedBox(height: 10,),
                    Text("App Photos",style: TextStyle(fontSize: 15,letterSpacing: 1,fontFamily: "three",color: Colors.white),),
                    SizedBox(height: 4,),
                    Container(
                      height: 25,width: 25,
                      decoration: BoxDecoration(
                        // color: Colors.yellow
                          image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/app_images.png"))
                      ),
                    ),
                  ]),
                ),
              )),
            ],),
          )),
          Expanded(flex: 2,child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            // color: Colors.indigoAccent,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
              Expanded(flex: 1,child: Container(
                height: double.infinity,
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(10, 5, 80, 5),
                decoration: BoxDecoration(
                  // color: Colors.pink,
                    image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/wood_but.png"))
                ),
                child: Icon(Icons.volume_up_sharp,color: Colors.white,size: 30),
              )),
              Expanded(flex: 1,child: Container(
                height: double.infinity,
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(45, 5, 45, 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // color: Colors.pink,
                    image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/wood_but.png"))
                ),
                child: Container(
                  height: 10,width: 10,
                  decoration: BoxDecoration(
                    // color: Colors.green,
                      image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/cele_star_orange.png"))
                  ),
                ),
              )),
              Expanded(flex: 1,child: Container(
                height: double.infinity,
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(80, 5, 10, 5),
                decoration: BoxDecoration(
                  // color: Colors.pink,
                    image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/wood_but.png"))
                ),
                child: Icon(Icons.share,color: Colors.white,size: 30),
              )),
            ]),
          )),
        ]),
      ],),
    )
    ), onWillPop: () async{
        exit(0);
      return true;
    },);
  }
}
