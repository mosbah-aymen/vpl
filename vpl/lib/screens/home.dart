import 'package:flutter/material.dart';
import 'package:vpl/screens/videos.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
       shape: CircularNotchedRectangle(
       ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: Icon(Icons.video_collection_sharp,color: Colors.deepOrange,), iconSize: 36,onPressed: (){

            }),
            IconButton(icon: Icon(Icons.music_note_sharp,color: Colors.teal,),iconSize: 36, onPressed: (){

            }),
            IconButton(icon: Icon(Icons.insert_drive_file,color: Colors.indigoAccent,),iconSize: 36, onPressed: (){

            }),
            IconButton(icon: Icon(Icons.favorite_border,color: Colors.red,),iconSize: 36, onPressed: (){

            }),
          ],
        ),
      ),
    );
  }
}
