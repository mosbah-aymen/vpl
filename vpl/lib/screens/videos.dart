
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class VideoPlayer extends StatefulWidget {
  static final id ='video';
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  List<String> files=[];
  void getVideo() async {
    FilePickerResult result =
    await FilePicker.platform.pickFiles(type: FileType.video);

    if (result != null) {
      File file = File(result.files.first.path);
      files.add(file.path);
    }
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: files.length,
        itemBuilder: (context,i){
          return Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(color: Colors.grey,child: Text(files[i]) ,),
          ));
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2

        ),

      )
    );
  }
}
