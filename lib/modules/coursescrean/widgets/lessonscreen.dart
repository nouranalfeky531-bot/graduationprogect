import 'package:flutter/material.dart';
import 'package:graduation_progect/modules/coursescrean/widgets/progress.dart';
import 'package:video_player/video_player.dart';

import 'chapter2.dart';
import 'coursepage.dart';
import 'lesson.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;

  const LessonScreen({ required this.lesson});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.lesson.vedioUrl!)
      ..initialize().then((_) {
        setState(() {});
        //widget.lesson.vedioUrl
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.lesson.title),
      ),
      body: Column(
        children: [
          if (_controller.value.isInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          else
            const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Text(
              _controller.value.isPlaying ? "Pause" : "Play",
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await ProgressService.markCompleted(widget.lesson.id);
              Navigator.pop(context, true);
            },


            child: const Text("Mark as Completed"),
          ),
          SizedBox(height: 50,),
          ElevatedButton(onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Chapter2()));
          }, child: Text("Pdf", style: TextStyle(color: Colors.amber),)),

          SizedBox(height: 50,),
          ElevatedButton(onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CoursePage()));
          },
              child: Text(
                "Pdf Using url", style: TextStyle(color: Colors.amber),)),
        ],

      ),
    );
  }
}

  // class VideoScreen extends StatefulWidget {
  // @override
  // _VideoScreenState createState() => _VideoScreenState();
  // }
  //
  // class _VideoScreenState extends State<VideoScreen> {
  // late VideoPlayerController _videoController;
  //
  // @override
  // void initState() {
  // super.initState();
  //
  // // رابط الفيديو
  // _videoController = VideoPlayerController.network(
  // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  // )
  // ..initialize().then((_) {
  // setState(() {});
  // _videoController.play(); // تشغيل الفيديو مباشرة
  // _videoController.setLooping(true); // لتكرار الفيديو لو حبيت
  // });
  // }
  //
  // @override
  // void dispose() {
  // _videoController.dispose();
  // super.dispose();
  // }
  //
  // @override
  // // Widget build(BuildContext context) {
  // // return Scaffold(
  // // appBar: AppBar(title: Text("Video with Subtitles")),
  // body: Center(
  // child: _videoController.value.isInitialized
  // ? SubtitleWrapper(
  // videoPlayerController: _videoController,
  // subtitleController: SubtitleController(
  // subtitleUrl:
  // 'https://example.com/subtitle_en.vtt', // رابط الترجمة
  // showSubtitles: true,
  // ),
  // videoChild: AspectRatio(
  // aspectRatio: _videoController.value.aspectRatio,
  // child: VideoPlayer(_videoController),
  // ),
  // )
  //     : CircularProgressIndicator(),
  // ),
  // );
  // }
  // }