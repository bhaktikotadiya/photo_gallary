import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as imglib;
import 'package:path_provider/path_provider.dart';
import 'package:photo_gallary/photo/second.dart';

void main()
{
      runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
      ));
}
class three extends StatefulWidget {
  List list;
  int index;
  three(this.list,this.index);

  @override
  State<three> createState() => _threeState();
}

class _threeState extends State<three> {

  int a=0;
  double sec=00;
  bool t = false;
  bool tru = false;
  List name=[];
  List<imglib.Image> myList = [];
  List list1 = [];
  List list2 = [];
  List temp = List.filled(9, true);
  String click="";


    Future<File> getImageFileFromAssets(String path) async {
      final byteData = await rootBundle.load('$path');

      final file = File('${(await getTemporaryDirectory()).path}/$path');
      await file.create(recursive: true);
      await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      return file;
    }


    List<imglib.Image> splitImage(imglib.Image inputImage, int horizontalPieceCount, int verticalPieceCount) {
      imglib.Image image = inputImage;

      final pieceWidth = (image.width / horizontalPieceCount).round();
      final pieceHeight = (image.height / verticalPieceCount).round();
      final pieceList = List<imglib.Image>.empty(growable: true);

      var x=0,y=0;
      for(int i=0; i<horizontalPieceCount; i++)
      {
        for(int j=0; j<verticalPieceCount; j++)
        {
          pieceList.add(imglib.copyCrop(image, x: x, y: y, width: pieceWidth, height: pieceHeight));
          x = x + pieceWidth;
        }
        x = 0;
        y = y + pieceHeight;
      }
      return pieceList;
    }

  get()
  {
    getImageFileFromAssets("images/${widget.list[widget.index]}").then((value) {

      //decode
      final image = imglib.decodeJpg(value.readAsBytesSync());
      // Uint8List testImg = imglib.encodeJpg(myList);
      myList = splitImage(image!, 3, 3);
      // if(click=="Starter")
      // {
      //    myList = splitImage(image!, 4, 4);
      // }
      // else if(click=="Master")
      // {
      //    myList = splitImage(image!, 5, 5);
      // }else if(click=="Expert")
      // {
      //    myList = splitImage(image!, 6, 6);
      // }else if(click=="challenge")
      // {
      //    myList = splitImage(image!, 7, 7);
      // }else
      // {
      //    myList = splitImage(image!, 3, 3);
      // }

      //encode
      for(int i=0;i<myList.length;i++)
      {
        list2.add(Image.memory(imglib.encodeJpg(myList[i])));
        print(list2);
      }

      list1.addAll(list2);
      // list1.addAll(myList);
      // myList.shuffle();
      list2.shuffle();
      setState(() { });
    });
  }

  get_sec()
  async {
    for(double i=30;i>=0;i--)
    {
      await Future.delayed(Duration(seconds: 1));
      // sec=i;
      if(listEquals(list2, list1))
        {
          break;
        }
      else
        {
          sec=i;
        }
      setState(() { });
    }
    if(sec==0)
      {
        for(int i=0;i<list2.length;i++)
        {
          if(list2[i]==list1[i])
          {
            print("true$i");
            // tru = true;
          }
        }
        tru = true;
        print("try again game");
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            shape: Border.all(color: Colors.red.shade900,width: 10,style: BorderStyle.solid),
            backgroundColor: Colors.red.shade500,
            title: Center(child: Text("Time up!",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "one"),)),
            actions: [
              Column(children: [
                Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      // color: Colors.green,
                      image: DecorationImage(image: AssetImage("images/thumbs_up.png"))
                    ),
                    margin: EdgeInsets.all(10),
                  ),
                ),
              ],),
              Column(children: [
                Center(child: InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return three(widget.list, widget.index);
                  },));
                },child: Text("Play Again",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "one"),))),
              ],),
              SizedBox(height: 9,)
            ],
          );
        },);
      }
    setState(() { });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          shape: Border.all(color: Colors.lightGreenAccent.shade400,width: 5),
          backgroundColor: Colors.green.shade900,
          title: Row(children: [
            Container(
              height: 40,width: 40,
              // color: Colors.brown,
              margin: EdgeInsets.fromLTRB(70, 0, 20, 0),
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/clock.png"))
              ),
            ),
            InkWell(onTap: () {
              sec=30;
              click="second";
              setState(() { });
            },
              child: Container(
                height: 40,width: 40,
                // color: Colors.indigo,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("images/background_icon.png"))
                ),
              ),
            ),
            SizedBox(width: 40,),
          ]),
          actions: [
            Column(children: [
              Center(child: Text("Time Limit : 30 sec",style: TextStyle(color: Colors.white,fontSize: 20,),)),
              Text(""),
              Center(child: Text("Starter",style: TextStyle(color: Colors.yellowAccent,fontSize: 30,fontFamily: "three"),),),
              Text(""),
              InkWell(onTap: () {
                t =true;
                get();
                if(sec==30)
                  {
                    get_sec();
                  }
                Navigator.pop(context);
                setState(() { });
              },
                child: Container(
                  height: 50,width: 140,
                  alignment: Alignment.center,
                  // color: Colors.deepOrange,
                  decoration: BoxDecoration(
                      color: Colors.lightGreenAccent.shade700,
                      border: Border.all(color: Colors.white,width: 3),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Text("PLAY",style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: "one"),),
                ),
              )
            ],),
            Text("")
          ],
        );
      },);
    });
  }

  @override
  Widget build(BuildContext context) {

    double tot_width = MediaQuery.of(context).size.width;
    double con_wid = (tot_width-20)/3;
    print("total=${tot_width}");
    print("container width=${con_wid}");

    return WillPopScope(onWillPop: () async{
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          shape: Border.all(color: Colors.lightGreenAccent.shade400,width: 5),
          backgroundColor: Colors.green.shade900,
          title: Center(child: Text("Exit Game",style: TextStyle(fontFamily: "three",fontSize: 25,color: Colors.white)),),
          actions: [
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
              SizedBox(width: 50,),
              InkWell(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return two();
                },));
                setState(() { });
              },
                child: Container(
                  height: 50,width: 50,
                  // color: Colors.brown,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey,width: 2),
                      // image: DecorationImage(image: AssetImage("images/background_icon.png"))
                  ),
                  child: Icon(Icons.check,color: Colors.lightGreenAccent,size: 50),
                ),
              ),
              SizedBox(width: 40,),
              InkWell(onTap: () {
                Navigator.pop(context);
                setState(() { });
              },
                child: Container(
                  height: 50,width: 50,
                  // color: Colors.indigo,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey,width: 2),
                    // image: DecorationImage(image: AssetImage("images/background_icon.png"))
                  ),
                  child: Icon(Icons.close,color: Colors.red,size: 50),
                ),
              ),
              SizedBox(width: 40,)
            ]),
            SizedBox(height: 40,)
          ],
        );
      },);
      return true;
    },
    child: SafeArea(child:
      Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          // color: Colors.yellow,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pink.shade300,Colors.yellow.shade300],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          child: Column(children: [
            Expanded(
              child: Row(children: [
                SizedBox(width: 10,),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showDialog(context: context, builder:  (context) {
                        return AlertDialog(
                          title: Container(
                            height: 300,
                            width: 150,
                            // color: Colors.pink,
                            decoration: BoxDecoration(
                              // color: Colors.cyanAccent,
                                image: DecorationImage(fit: BoxFit.fill,
                                    image: AssetImage("images/${widget.list[widget.index]}"))
                            ),
                          )
                        );
                      },);
                    },
                    child: Container(
                      height: 30,width: 30,
                      // color: Colors.purpleAccent,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("images/photo_icon.png"))
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    height: 30,width: 30,
                    // color: Colors.pinkAccent,
                    child: Text("${a}",style: TextStyle(fontSize: 20,color: Colors.yellowAccent)),
                  ),
                ),
                SizedBox(width: 60,),
                Expanded(flex: 2,
                  child: Container(
                    height: 30,width: 30,
                    // color: Colors.lightGreen,
                    alignment: Alignment.center,
                    child: Text("00 : ${sec}",style: TextStyle(color: Colors.deepPurple,fontSize: 15,fontFamily: "three")),
                  ),
                ),
                SizedBox(width: 50,),
                Expanded(
                  child: InkWell(onTap: () {
                    showDialog(context: context, builder: (context) {
                      return Container(
                        height: double.infinity,
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(70, 300, 70, 290),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          border: Border.all(color: Colors.deepPurple.shade300,width: 9),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: Column(children: [
                          Expanded(flex: 1,
                            child: GestureDetector(onTapUp: (details) {
                              click="Starter";
                              print(click);
                              Navigator.pop(context);
                              setState(() { });
                            },
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(60, 10, 60, 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 3,color: Colors.lightBlueAccent.shade200,),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text("Starter",style: TextStyle(color: Colors.red.shade300,fontSize: 25,fontFamily: "two")),
                              ),
                            ),
                          ),
                          Expanded(flex: 1,
                            child: GestureDetector(onTapUp: (details) {
                              click="Master";
                              print(click);
                              Navigator.pop(context);
                              setState(() { });
                            },
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(60, 10, 60, 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 3,color: Colors.lightBlueAccent.shade200,),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text("Master",style: TextStyle(color: Colors.green.shade600,fontSize: 25,fontFamily: "two")),
                              ),
                            ),
                          ),
                          Expanded(flex: 1,
                            child: GestureDetector(onTapUp: (details) {
                              click="Expert";
                              print(click);
                              Navigator.pop(context);
                              setState(() { });
                            },
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(60, 10, 60, 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 3,color: Colors.lightBlueAccent.shade200,),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text("Expert",style: TextStyle(color: Colors.yellow.shade600,fontSize: 25,fontFamily: "two")),
                              ),
                            ),
                          ),
                          Expanded(flex: 1,
                            child: GestureDetector(onTapUp: (details) {
                              click="Challenge";
                              print(click);
                              Navigator.pop(context);
                              setState(() { });
                            },
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                alignment: Alignment.center,
                                margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 3,color: Colors.lightBlueAccent.shade200,),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text("Challenge",style: TextStyle(color: Colors.blue.shade900,fontSize: 25,fontFamily: "two")),
                              ),
                            ),
                          ),
                        ]),
                      );
                    },);
                    setState(() { });
                  },
                    child: Container(
                      height: 30,width: 30,
                      // color: Colors.deepOrangeAccent,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("images/icon_grid.png"))
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: InkWell(onTap: () async {
                    for(int i=0;i<list2.length;i++)
                    {
                      if(list2[i]==list1[i])
                      {
                        print("true$i");
                        // tru = false;
                      }
                      // tru = true;
                    }
                    tru=true;

                    setState(() { });
                  },
                    child: Container(
                      height: 30,width: 30,
                      // color: Colors.indigoAccent,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("images/tick_exit.png"))
                      ),
                    )
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: InkWell(onTap: () {
                    a++;
                    setState(() { });
                  },
                    child: Container(
                      height: 30,width: 30,
                      // color: Colors.brown,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("images/hint_b.png"))
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,)
              ],),
            ),
            (t==false)?Expanded(flex: 10,child: Row(children: [
              Expanded(
                child: Center(child:
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  // color: Colors.lightGreenAccent,
                  decoration: BoxDecoration(
                    // color: Colors.cyanAccent,
                      image: DecorationImage(
                          image: AssetImage("images/${widget.list[widget.index]}"))
                  ),
                  margin: EdgeInsets.fromLTRB(20, 150, 20, 150),
                )
                ),
              ),
            ],)):
            Expanded(flex: 10,child: Column(children: [
              Expanded(flex: 3,child: Text("")),
              Expanded(flex: 6,
                  child: Center(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      // color: Colors.pink,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(children: [
                        Expanded(
                          child: Center(
                            child: GridView.builder(
                              itemCount: list2.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                // (click=="Starter")?4:(click=="Master")?5:(click=="Expert")?6:(click=="Challenge")?7:3,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                              ),
                              itemBuilder: (context, index) {
                                // Uint8List testImg = imglib.encodeJpg(myList[index]);
                                return (temp[index])?
                                Draggable(
                                  onDraggableCanceled: (velocity, offset) {
                                    print("test");
                                    temp=List.filled(9, true);
                                    setState(() { });
                                  },
                                  data: index,
                                  onDragStarted: () {
                                    temp=List.filled(9, false);
                                    temp[index]=true;
                                    setState(() { });
                                  },
                                  child: (tru==true && list2[index]==list1[index])?Stack(alignment: Alignment.center,children: [
                                    Container(
                                      width: con_wid,
                                      height: con_wid,
                                      // color: Colors.green,
                                      alignment: Alignment.center,
                                      child: list2[index],
                                      // decoration: BoxDecoration(
                                      //     image: DecorationImage(image: MemoryImage(testImg),fit: BoxFit.fill)
                                      // ),
                                      // child: Text("${list[index]}", style: TextStyle(fontSize: 30,color: Colors.white)),
                                    ),
                                    Container(
                                      width: 20,height: 20,
                                      decoration: BoxDecoration(
                                          // color: Colors.yellow,
                                        image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/tick.png"))
                                      ),
                                    )
                                  ],):Container(
                                    width: con_wid,
                                    height: con_wid,
                                    // color: Colors.green,
                                    alignment: Alignment.center,
                                    child: list2[index],
                                    // decoration: BoxDecoration(
                                    //     image: DecorationImage(image: MemoryImage(testImg),fit: BoxFit.fill)
                                    // ),
                                    // child: Text("${list[index]}", style: TextStyle(fontSize: 30,color: Colors.white)),
                                  ), feedback: Container(
                                  child: list2[index],
                                  // decoration: BoxDecoration(
                                  //     image: DecorationImage(image: MemoryImage(testImg),fit: BoxFit.fill)
                                  // ),
                                  width: con_wid,
                                  height: con_wid,
                                  // color: Colors.pinkAccent,
                                  alignment: Alignment.center,
                                  // child: Text("${list[index]}", style: TextStyle(fontSize: 30,color: Colors.white)),
                                ),):
                                DragTarget(
                                  onAccept: (data) {
                                    print(data);
                                    temp = List.filled(9, true);
                                    var c = list2[data as int];
                                    list2[data as int] = list2[index];
                                    list2[index] = c;
                                    if(listEquals(list2, list1))
                                    {
                                      print("you are win") ;
                                      showDialog(context: context, builder:  (context) {
                                        return Container(
                                          padding: EdgeInsets.all(10),
                                          height: double.infinity,
                                          width: double.infinity,
                                          margin: EdgeInsets.fromLTRB(70, 270, 70, 230),
                                          decoration: BoxDecoration(
                                              // color: Colors.blue.shade900,
                                              gradient: LinearGradient(colors: [
                                                Colors.blue.shade400,Colors.blue.shade100
                                              ]),
                                              border: Border.all(color: Colors.blue.shade900,width: 9),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Column(children: [
                                            Center(
                                              child: Container(
                                                height: 50,width: 150,
                                                margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                // color: Colors.lightGreenAccent,
                                                decoration: BoxDecoration(
                                                    // color: Colors.lightGreenAccent,
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: AssetImage("images/level_up.png"))
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                                                Container(
                                                  height: 50,width: 50,
                                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  // color: Colors.green,
                                                  decoration: BoxDecoration(
                                                    // color: Colors.lightGreenAccent,
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: AssetImage("images/star_p_new.png"))
                                                  ),
                                                ),
                                                Container(
                                                  height: 50,width: 50,
                                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                  // color: Colors.yellow,
                                                  decoration: BoxDecoration(
                                                    // color: Colors.lightGreenAccent,
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                          image: AssetImage("images/star_p_new.png"))
                                                  ),
                                                ),
                                                Container(
                                                  height: 50,width: 50,
                                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  // color: Colors.pinkAccent,
                                                  decoration: BoxDecoration(
                                                    // color: Colors.lightGreenAccent,
                                                      image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: AssetImage("images/star_p_new.png"))
                                                  ),
                                                ),
                                              ]),
                                            ),
                                            Center(
                                              child: Container(
                                                height: 170,width: 150,
                                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                                // color: Colors.tealAccent,
                                                decoration: BoxDecoration(
                                                  // color: Colors.lightGreenAccent,
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: AssetImage("images/cup.png"))
                                                ),
                                              ),
                                            ),
                                            Center(child: Text("NO TIME LIMIT",style: TextStyle(fontFamily: "one",fontSize: 25,color: Colors.white)),)
                                          ]),
                                        );
                                        // return AlertDialog(
                                        //   title: Text("You are win game"),
                                        //   actions: [
                                        //     ElevatedButton(onPressed:(){
                                        //       Navigator.pop(context);
                                        //       setState(() { });
                                        //     } , child: Text("OK"))
                                        //   ],
                                        // );
                                      },);
                                    }
                                    setState(() { });
                                  },
                                  builder: (context, candidateData, rejectedData) {
                                    return Container(
                                      child: list2[index],
                                      // decoration: BoxDecoration(
                                      //     image: DecorationImage(image: MemoryImage(testImg),fit: BoxFit.fill)
                                      // ),
                                      // color: Colors.blue,
                                      alignment: Alignment.center,
                                      // child: Text("${list[index]}",style: TextStyle(fontSize: 30,color: Colors.white)),
                                    );
                                  },);
                              },
                            ),
                          ),
                        )
                      ],),
                    ),
                  )
              ),
              Expanded(flex: 3,child: Text("")),
            ],))
          ]),
        ),
        ),
      ),
    );
  }
}
