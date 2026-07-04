import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:path_provider/path_provider.dart';

class VideoPlayerProvider extends ChangeNotifier {

  late Player player;
 VideoController? controller;

  Duration position = Duration.zero;
  bool isMuted = false;

  // void initialize(String url) {
  //   player = Player();
  //   controller = VideoController(player);
  //
  //   player.open(Media(url));
  //
  //   player.stream.position.listen((pos) {
  //     position = pos;
  //     notifyListeners();
  //   });
  // }
  Future<void> initialize(String videoUrl) async {
    player = Player();
    controller = VideoController(player);

    player.stream.playing.listen((event) {
      print("Is playing: $event");
    });

    final dir = await getApplicationDocumentsDirectory();
    final videoPath = "${dir.path}/${videoUrl.hashCode}.mp4";
    final videoFile = File(videoPath);

    try {
      if (await videoFile.exists()) {
        print("Playing cached video");
        await Future.delayed(const Duration(milliseconds: 1000));
        await player.open(Media(videoFile.path));
        notifyListeners();
        return;
      }
      final start = DateTime.now();
      await player.open(Media(videoUrl));
      print("Open time: ${DateTime.now().difference(start).inSeconds} sec");

      notifyListeners(); // ← وهنا كمان

      Fluttertoast.showToast(
        msg: "Loading video...",
        toastLength: Toast.LENGTH_SHORT,
      );

      Dio()
          .download(
        videoUrl,
        videoPath,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            print("Download ${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      )
          .then((_) {
        print("Video cached successfully");
      })
          .catchError((e) async {
        print("Cache error: $e");
        if (await videoFile.exists()) {
          await videoFile.delete();
        }
      });

    } catch (e) {
      print("Video Error: $e");
      Fluttertoast.showToast(
        msg: "Failed to load video",
        toastLength: Toast.LENGTH_SHORT,
      );
    }

//     if (await videoFile.exists() && await videoFile.length() > 0)  {
//       await player.open(Media(videoPath));
//       Fluttertoast.showToast(msg: "Playing offline video");
// notifyListeners();
//     } else {
//       // شغليه أونلاين فوراً
//       await player.open(Media(videoUrl));
//       Fluttertoast.showToast(msg: "Downloading video...");
//       notifyListeners();
//
//       try {
//         await Dio().download(
//           videoUrl,
//           videoPath,
//           onReceiveProgress: (received, total) {
//             if (total != -1) {
//               double progress = (received / total * 100);
//               Fluttertoast.showToast(
//                   msg: "Download: ${progress.toStringAsFixed(0)}%");
//             }
//           },
//         );
//         Fluttertoast.showToast(msg: "Video downloaded successfully");
//       } catch (e) {
//         Fluttertoast.showToast(msg: "Download failed: $e");
//       }
//     }

    // لو في صوت خارجي
    // if (audioUrl != null) {
    //   final audioPath = "${dir.path}/${audioUrl.hashCode}.mp3";
    //   final audioFile = File(audioPath);
    //
    //   if (!await audioFile.exists()) {
    //     try {
    //       await Dio().download(audioUrl, audioPath);
    //       Fluttertoast.showToast(msg: "Audio downloaded");
    //     } catch (e) {
    //       Fluttertoast.showToast(msg: "Audio download failed: $e");
    //   }
    //   }
    //
    //   // ربط الصوت بالفيديو
    //   await player.setAudioTrack(AudioTrack.uri(audioPath));
    // }

    // متابعة البوزيشن
    player.stream.position.listen((pos) {
      position = pos;
      notifyListeners();
    });

    notifyListeners();
  }

  void toggleMute() {
    isMuted = !isMuted;
    player.setVolume(isMuted ? 0 : 100);
    notifyListeners();
  }

  void seekForward() {
    player.seek(position + const Duration(seconds: 10));
  }

  void seekBackward() {
    player.seek(position - const Duration(seconds: 10));
  }

  Future<void> changeAudio(String url) async {
    await player.pause();
    await player.setAudioTrack(AudioTrack.uri(url));
    await player.seek(position);
    await player.play();
  }

  void changeSubtitle(String url) {
    player.setSubtitleTrack(SubtitleTrack.uri(url));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}