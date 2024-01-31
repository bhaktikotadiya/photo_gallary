import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main()
{
    runApp(MaterialApp(debugShowCheckedModeBanner: false,home: game(),));
}
class game extends StatefulWidget {
  const game({super.key});

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {

    List list = ["A","B","C","D","E","F","G","H","I"];
    List list1 = [];
    List temp = List.filled(9, true);

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list1.addAll(list);
    list.shuffle();
  }

  @override
  Widget build(BuildContext context) {
      
      double tot_width = MediaQuery.of(context).size.width;
      double con_wid = (tot_width-20)/3;
      print("total=${tot_width}");
      print("container width=${con_wid}");
      
    return Scaffold(
        appBar: AppBar(
            title: Text("DRAWABLE"),
            backgroundColor: Colors.brown.shade900,
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
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
                        color: Colors.green,
                        alignment: Alignment.center,
                        child: Text("${list[index]}", style: TextStyle(fontSize: 30,color: Colors.white)),
                    ), feedback: Container(
                        width: con_wid,
                        height: con_wid,
                        color: Colors.pinkAccent,
                        alignment: Alignment.center,
                        child: Text("${list[index]}", style: TextStyle(fontSize: 30,color: Colors.white)),
                    ),):
                DragTarget(
                    onAccept: (data) {
                      print(data);
                      temp = List.filled(9, true);
                      //c = a;
                      //a = b;
                      //b = c;
                      var c = list[data as int];
                          list[data as int] = list[index];
                          list[index] = c;
                              if(listEquals(list, list1))
                              {
                                      print("you are win") ;
                              }
                              setState(() { });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: Text("${list[index]}",style: TextStyle(fontSize: 30,color: Colors.white)),
                      );
                    },);
            },
        ),
    );
  }
}
