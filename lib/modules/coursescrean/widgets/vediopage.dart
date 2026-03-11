import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPage extends StatefulWidget {

  final String url;
  final String title;

  const VideoPage({ required this.url, required this.title});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {

    super.initState();

    videoPlayerController = VideoPlayerController.network(widget.url);

    videoPlayerController.initialize().then((_) {

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
      );

      setState(() {});

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: Text(widget.title)),

      body: Center(

        child: chewieController == null
            ? const CircularProgressIndicator()
            : Chewie(controller: chewieController!),

      ),

    );

  }

}