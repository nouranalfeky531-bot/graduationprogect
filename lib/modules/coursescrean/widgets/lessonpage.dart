import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LessonPage extends StatefulWidget {
  final String title;
  final String type; // "video" أو "pdf"
  final String url;  // URL كامل

  const LessonPage({
    required this.title,
    required this.type,
    required this.url,
  });

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  VideoPlayerController? videoController;

  @override
  void initState() {
    super.initState();

    if (widget.type == "video") {
      videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url))
        ..initialize().then((_) {
          setState(() {});
          videoController!.play();
          videoController!.setLooping(true);
        });
    }
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: buildContent(),
    );
  }

  Widget buildContent() {
    if (widget.type == "video") {
      if (videoController == null || !videoController!.value.isInitialized) {
        return const Center(child: CircularProgressIndicator());
      }
      return Center(
        child: AspectRatio(
          aspectRatio: videoController!.value.aspectRatio,
          child: VideoPlayer(videoController!),
        ),
      );
    }
    // else if (widget.type == "pdf") {
    //   return SPPdfViewer.network(widget.url);
    // }

    return const Center(child: Text("No Content"));
  }
}