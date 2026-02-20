import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoPlayerProvider extends ChangeNotifier {

  late Player player;
  late VideoController controller;

  Duration position = Duration.zero;
  bool isMuted = false;

  void initialize(String url) {
    player = Player();
    controller = VideoController(player);

    player.open(Media(url));

    player.stream.position.listen((pos) {
      position = pos;
      notifyListeners();
    });
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