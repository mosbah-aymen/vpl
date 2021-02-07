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
        await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      File file = File(result.files.first.path);
      files.add(file.path);
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
  }

  @override
  Widget build(BuildContext context) {
    getPaths();
    if (files.length>0 && played){
      audioPlayer.play(files[selected]);
    }
    savePaths();
    return Stack(
      children: [
        Scaffold(
       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[300],
          child: Icon(Icons.music_note_sharp),
          onPressed: () {
            getAudio();
            savePaths();
            setState(() {

            });
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: files.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () async {
                          print(files[i]);
                          await audioPlayer.play(files[i]);
                      },
                      child: SongField(
                        str: files[i],
                        playingThis: selected==i,
                      ),
                    );
                  }),
            ),
            Container(
              height: 70,
              width: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(

                color: Colors.red[900],
                borderRadius: BorderRadius.all( Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.skip_previous,
                      ),
                      onPressed: () {
                       setState(() {
                         if(selected==0){
                           selected=files.length-1;
                         }
                         else{
                           selected--;
                         }
                       });
                      }),
                  IconButton(
                      icon: Icon(
                        !played?  Icons.play_circle_fill:Icons.pause_circle_filled,
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
                      icon: Icon(
                        Icons.skip_next,
                      ),
                      onPressed: () {
                        setState(() {
                          if (selected<files.length-1){selected++;}
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
  Function function;
  SongField({this.str, this.function,this.playingThis});
  @override
  Widget build(BuildContext context) {
    String nameSong = str;
    nameSong=nameSong.substring(46);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Card(
        color: playingThis? Colors.red[900]:null,
        child: ListTile(
          //leading: Image.asset(),
          onTap: () {},
          subtitle: Text(''),
          title: Text(nameSong),
        ),
      ),
      
    );
  }
}
