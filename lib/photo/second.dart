import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:photo_gallary/photo/config.dart';
import 'package:photo_gallary/photo/first.dart';
import 'package:photo_gallary/photo/third.dart';

void main()
{
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,home: two(),
    ));
}
class two extends StatefulWidget {
  const two({super.key});

  @override
  State<two> createState() => _twoState();
}

class _twoState extends State<two> {
  List <bool> temp=List.filled(data.name.length, false);
  double h = 200;
  double w = 200;
  bool t = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: SafeArea(child:
    Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        // color: Colors.pink.shade100,
        color: Colors.pink.shade50,
        padding: EdgeInsets.all(25),
        child: GridView.builder(
          itemCount: data.name.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTapUp: (details)
              {
                print("hello");
                temp[index]=false;
                setState(() { });
              },
              onTapCancel: ()
              {
                print("hi..");
                temp[index]=false;
                setState(() { });
              },
              onTapDown: (details)
              {
                print("how are you");
                temp[index]=true;
                setState(() { });
              },
              child: InkWell(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return three(data.pic, index);
                },));
              },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  child: Container(
                    height: (temp[index]==true)?80:double.infinity,
                    width: (temp[index]==true)?80:double.infinity,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      // Color(0xFFFFCDD2),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.pinkAccent.shade100),
                    ),
                    child: Column(children: [
                      Text("${data.name[index]}",style: TextStyle(fontSize: 15,fontFamily: "three",color: Colors.purpleAccent.shade400),),
                      SizedBox(height: 12,),
                      Container(
                        height: 55,width: 70,
                        decoration: BoxDecoration(
                          // color: Colors.pinkAccent,
                            image: DecorationImage(fit: BoxFit.fill,image: AssetImage("images/${data.pic[index]}"))
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    )
    ), onWillPop: () async{
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return one();
      },));
      return true;
    },);
  }
}
