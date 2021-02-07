import 'package:flutter/material.dart';
import 'package:vpl/screens/files.dart';
import 'package:vpl/screens/music.dart';
import 'package:vpl/screens/videos.dart';
const kMyColor=Colors.red;
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
            IconButton(icon: Icon(Icons.home,color:selected==0?kMyColor : Colors.grey,), iconSize: 36,onPressed: (){
              setState(() {
                selected=0;
                index.jumpToPage(0);
              });
            }),
            IconButton(icon: Icon(Icons.video_collection_sharp,color: selected==1? kMyColor: Colors.grey,), iconSize: 36,onPressed: (){
              setState(() {
                index.jumpToPage(1);
                selected=1;

              });
            }),
            IconButton(icon: Icon(Icons.music_note_sharp,color: selected==2? kMyColor: Colors.grey,),iconSize: 36, onPressed: (){
              setState(() {
                index.jumpToPage(2);
                selected=2;
              });
            }),
            IconButton(icon: Icon(Icons.insert_drive_file,color: selected==3? kMyColor: Colors.grey,),iconSize: 36, onPressed: (){
              setState(() {
                index.jumpToPage(3);
                selected=3;
              });
            }),
            IconButton(icon: Icon(Icons.favorite_border,color: selected==4? kMyColor: Colors.grey,),iconSize: 36, onPressed: (){
              setState(() {
                index.jumpToPage(4);
                selected=4;
              });
            }),
          ],
        ),
      ),
      body: PageView(
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
