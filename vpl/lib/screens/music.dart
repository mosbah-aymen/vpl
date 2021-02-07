import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';

class Music extends StatefulWidget {
  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<Music> {
  List files = [];
  int selected=0;
  AudioPlayer audioPlayer = AudioPlayer();
  void getAudio() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      File file = File(result.files.first.path);
      files.add(file.path);
    }
    setState(() {});
  }
bool played=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.dispose();
    audioPlayer=AudioPlayer();

  }

  @override
  Widget build(BuildContext context) {
    if (files.length>0 && played){
      audioPlayer.play(files[selected]);
    }
    return Scaffold(
     floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.music_note_sharp),
        onPressed: () {
          getAudio();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 5,
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
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.vertical(top: Radius.circular(90)),
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
                        played?  Icons.play_circle_fill:Icons.pause_circle_filled,
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
          ),
        ],
      ),
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
    return Card(
      color: playingThis? Colors.indigoAccent:null,
      child: ListTile(
        //leading: Image.asset(),
        onTap: () {},
        subtitle: Text('P'),
        title: Text(nameSong),
      ),
      borderOnForeground: true,
    );
  }
}
