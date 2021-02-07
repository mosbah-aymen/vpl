import 'package:flutter/material.dart';
import 'package:vpl/screens/files.dart';
import 'package:vpl/screens/music.dart';
import 'package:vpl/screens/videos.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
int selected=0;
  PageController index=PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading:  IconButton(icon: Icon(Icons.account_circle_rounded), onPressed: (){

        },
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [


              IconButton(icon: Icon(Icons.nightlight_round), onPressed: (){
                setState(() {

                });
              }),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
       shape: CircularNotchedRectangle(
       ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: Icon(Icons.home,color:selected==0? Colors.deepOrange: Colors.grey,), iconSize: 36,onPressed: (){
              setState(() {
                selected=0;
                index.jumpToPage(0);
              });
            }),
            IconButton(icon: Icon(Icons.video_collection_sharp,color: selected==1? Colors.deepOrange: Colors.grey,), iconSize: 36,onPressed: (){
              setState(() {
                selected=1;
                index.jumpToPage(1);
              });
            }),
            IconButton(icon: Icon(Icons.music_note_sharp,color: selected==2? Colors.deepOrange: Colors.grey,),iconSize: 36, onPressed: (){
              setState(() {
                selected=2;
                index.jumpToPage(2);
              });
            }),
            IconButton(icon: Icon(Icons.insert_drive_file,color: selected==3? Colors.deepOrange: Colors.grey,),iconSize: 36, onPressed: (){
              setState(() {
                selected=3;
                index.jumpToPage(3);
              });
            }),
            IconButton(icon: Icon(Icons.favorite_border,color: selected==4? Colors.deepOrange: Colors.grey,),iconSize: 36, onPressed: (){
              setState(() {
                selected=4;
                index.jumpToPage(4);
              });
            }),
          ],
        ),
      ),
      body: PageView(
        allowImplicitScrolling: false,
        controller: index,
        children: [
          HomePage(),
          VideoPlayer(),
          Music(),
          Files(),

        ],

      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

        ),
      ),
    );
  }
}
