import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}
class _MusicState extends State<Music> {
  List<String> files = [];
  bool played=false;
  String _key='music';
  int selected=0;
  AudioPlayer audioPlayer = AudioPlayer();

  void getAudio() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.audio,allowMultiple: true);
    if (result != null) {
     for(int i=0;i<result.files.length;i++){
      File file = File(result.files[i].path);
      if (!files.contains(file)){files.add(file.path);}
      }
      savePaths();
    }
    setState(() {});
  }
  void savePaths()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setStringList(_key,files);
  }
  void getPaths()async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    files = sharedPreferences.getStringList(_key) ?? [];
    setState(() {
    });
  }
  @override
  void initState() {
    super.initState();
    audioPlayer.dispose();
    audioPlayer=AudioPlayer();
    getPaths();
    files.sort();
  }

  @override
  Widget build(BuildContext context) {
    files.add('/storage/emulated/0/snaptube/download/SnapTube Audio/Thug Life Ringtone | Download Link.mp3');
    getPaths();
    if (files.length>0 && played){
      audioPlayer.play(files[selected]);
      }
    savePaths();
    return Stack(
      children: [
        Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: files.length,
                  itemBuilder: (context, i) {
                    return SongField(
                      longpress: (){
                        if(selected==files.length){
                          selected--;
                        }
                        files.removeAt(i);
                        setState(() {
                          savePaths();
                        });
                      },
                      str: files[i],
                      function: (){
                        audioPlayer.stop();
                        setState(() {
                          selected=i;
                        });
                      },
                      playingThis: selected==i,
                    );
                  }),
            ),
            Container(
              height: 60,
              //width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(

                color: Colors.red[900],
                borderRadius: BorderRadius.all( Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.skip_previous,color: Colors.tealAccent,
                        size: 35,
                      ),
                      onPressed: () {
                       setState(() {
                         if(selected==0){
                           selected=files.length;
                         }
                         else{
                           selected--;
                         }
                       });
                      }),
                  IconButton(
                      icon: Icon(
                        !played?  Icons.play_circle_fill:Icons.pause_circle_filled,
                          size: 35
                          ,color: Colors.tealAccent
                      ),
                      onPressed: () {
                        setState(() {
                          if(played){
                            audioPlayer.pause();
                          }
                          else{
                            audioPlayer.resume();
                          }
                          played= !played;
                        });
                      }),
                  IconButton(
                    icon: Icon(Icons.music_note_sharp,color: Colors.tealAccent,
                      size: 35,
                    ),
                    onPressed: () {
                      getAudio();
                      savePaths();
                      setState(() {

                      });
                    },
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.skip_next
                          ,color: Colors.tealAccent,
                        size: 35,

                      ),
                      onPressed: () {
                        setState(() {
                          if (selected<files.length){selected++;}
                          else{
                            selected=0;
                          }

                        });
                      }),

                ],
              ),
            ),
          ],
        ),
      ),
      ]

    );
  }
}

// ignore: must_be_immutable
class SongField extends StatelessWidget {
  String str;
  bool playingThis=false;
  Function function,longpress;
  SongField({this.str, this.function,this.playingThis,this.longpress});
  String getName(String s){
    String a='';
    for (int i=s.length-1;s[i]!='/';i--){
      a=s[i]+a;
    }
    return a;
  }
  @override
  Widget build(BuildContext context) {
    String nameSong = str;
    nameSong=getName(nameSong);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Card(
        color: playingThis? Colors.red[900]:null,
        child: ListTile(
          onTap: function,
          selected:playingThis ,
          onLongPress: longpress,
          title: Text(nameSong),
        ),
      ),

    );
  }
}
