
import 'dart:io';

import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as imglib;
import 'package:path_provider/path_provider.dart';

void main()
{
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: first(),));
}
class first extends StatefulWidget {
  // first(String imag_name, bool t);

  // const first(XFile? image, {super.key});
  String? img_path;
  bool? t;
  first([this.img_path,this.t]);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {

  List<imglib.Image> myList = [];
  List list1 = [];
  List list2 = [];
  List temp = List.filled(9, true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.img_path);
    print(widget.t);
    getImageFileFromAssets("images/p_castle.jpg").then((value) {
      final image = imglib.decodeJpg(value.readAsBytesSync());
      // Uint8List testImg = imglib.encodeJpg(myList);
      myList = splitImage(image!, 3, 3);

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

  @override
  Widget build(BuildContext context) {

    double tot_width = MediaQuery.of(context).size.width;
    double con_wid = (tot_width-20)/3;
    print("total=${tot_width}");
    print("container width=${con_wid}");

    return Scaffold(
      body: GridView.builder(
        itemCount: myList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            mainAxisSpacing: 3,
            crossAxisSpacing: 3,
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
              child: Container(
                width: con_wid,
                height: con_wid,
                // color: Colors.green,
                alignment: Alignment.center,
                child: list2[index],
                // decoration: BoxDecoration(
                //     image: DecorationImage(image: list2[index],fit: BoxFit.fill)
                // ),
                // child: Text("${list[index]}", style: TextStyle(fontSize: 30,color: Colors.white)),
              ), feedback: Container(
              child: list2[index],
              // decoration: BoxDecoration(
              //     image: DecorationImage(image: list2[index],fit: BoxFit.fill)
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
                //c = a;
                //a = b;
                //b = c;
                var c = list2[data as int];
                list2[data as int] = list2[index];
                list2[index] = c;
                // if(listEquals(list1, list2))
                //   {
                //     print("you are win");
                //   }
                if(listEquals(list1, list2))
                {
                  print("you are win") ;
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text("WINNER"),
                      actions: [
                        ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("OK"))
                      ],
                    );
                  },);
                }
                setState(() { });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: con_wid,
                  height: con_wid,
                  child: list2[index],
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(image:list2[index],fit: BoxFit.fill)
                  // ),
                  // color: Colors.blue,
                  alignment: Alignment.center,
                  // child: Text("${list[index]}",style: TextStyle(fontSize: 30,color: Colors.white)),
                );
              },);
          },
      )
    );
  }
}

