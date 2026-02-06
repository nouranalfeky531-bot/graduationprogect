import 'package:flutter/material.dart';
import 'package:graduation_progect/core/theme/app_colors.dart';
import 'package:graduation_progect/modules/video/models/Data.dart';
import 'package:graduation_progect/modules/video/videoprovider.dart';
import 'package:graduation_progect/modules/video/videoviewmodel.dart';
import 'package:graduation_progect/modules/video/widgets/dailog.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'widgets/dropdown.dart';
import 'models/AvailableLanguages.dart';
import 'models/Videoresponse.dart';
import 'models/VttList.dart';

class Videoveiw extends StatefulWidget {
  const Videoveiw();

  @override
  State<Videoveiw> createState() => _VideoveiwState();
}

class _VideoveiwState extends State<Videoveiw> {
  late VideoPlayerController _controller;
  VideoProvider videoProvider = VideoProvider();
  bool isMuted = false;
  late String selected = "summary25";
  late String? selectedlanguage = "ar";
  // late Data? selecteddata =videoProvider.availableLanguages![0].data;
  //  late String? selectedvalue=selecteddata!.transcript;
  // videoProvider.availableLanguages![0].data!.transcript!.toString();

  void toggleMute() {
    setState(() {
      isMuted = !isMuted;
      _controller.setVolume(isMuted ? 0.0 : 1.0);
    });
  }

  void seekBackward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - Duration(seconds: 10);
    _controller
        .seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
  }

  void seekForward() {
    final currentPosition = _controller.value.position;
    final duration = _controller.value.duration;
    final newPosition = currentPosition + Duration(seconds: 10);
    _controller.seekTo(newPosition < duration ? newPosition : duration);
  }

  void init() {
    print("hona al enet");
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(videoProvider.url));
    _controller.initialize().then(
        //استخدمت then عشان انا مش محتاجه اوقف اللي بعده لحد ما ايخلص انما await بستخدمها لما اكون عايزه اوقف الل بعد كده
        (Value) {
      _controller.setLooping(true);
      _controller.addListener(() {
        setState(() {});
      });

      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    init();

    print(" ana d5alt el enaite");
  }

  void fetchData() async {
    await videoProvider.fetchvideodata();
    Videoresponse video = await videoviewModel.loadvediodetails();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "===============================88888888888888888888888888888888888888888888");
    print(videoProvider.selecteddata);
    print(videoProvider.languageCodes);
    print(videoProvider.selectedvalue);

    return ChangeNotifierProvider.value(
      value: videoProvider,
      child: Consumer<VideoProvider>(builder: (context, videoProvider, child) {
        if (videoProvider.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    VideoPlayer(_controller),
                    Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              icon: Icon(_controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow),
                              onPressed: () {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                                setState(() {});
                              }),
                          IconButton(
                            icon: Icon(
                              isMuted ? Icons.volume_off : Icons.volume_up,
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: toggleMute,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.replay_10,
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: seekBackward,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.forward_10,
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: seekForward,
                          ),
                          Expanded(child: SizedBox()),
                          IconButton(
                            icon: Icon(
                              Icons.headphones,
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'عنوان',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(videoProvider.availableLanguages
                                          .toString()),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.subtitles,
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      width: 200, // عرض صغير
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('عنوان',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 10),
                                          Text(videoProvider.url),
                                          SizedBox(height: 15),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text('إغلاق'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.keyboard_alt_rounded,
                                color: Colors.black,
                                size: 25,
                              ),
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Expanded(
                                      child: Dialog(
                                        backgroundColor: AppColors.primaryColor,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: videoProvider.keywords!
                                                .map(
                                                  (e) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          e ?? '',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .darkColor,
                                                              fontSize: 20),
                                                        ),
                                                        Divider(
                                                          height: 3,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                        ]),
                  ]),
                ),
                Slider(
                    value: _controller.value.position.inSeconds.toDouble(),
                    min: 0,
                    max: _controller.value.duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      _controller.seekTo(Duration(seconds: value.toInt()));
                      setState(() {});
                    }),
                Row(
                  children: [
                    Text(videoProvider.selectedvalue),
                    CustomDropdown(
                      hint: 'language',
                      value: selectedlanguage,
                      items: videoProvider.languageCodes,
                      onChanged: (value) {
                        int length = videoProvider.availableLanguages!.length;
                        for (int i = 0; i < length; i++) {
                          if (value ==
                              videoProvider
                                  .availableLanguages![i].languageCode) {
                            videoProvider.selecctdata(i);
                            // videoProvider.availableLanguages![i].data!;
                          }
                        }
                        setState(() {
                          selectedlanguage = value!;
                        });
                      },
                    ),
                    CustomDropdown(
                      hint: 'transcript',
                      value: selected,
                      items: ["summary25", "summary50", "transcript"],
                      onChanged: (value) {
                        videoProvider.selected(value!);
                        setState(() {
                          selected = value!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
// floatingActionButton: Padding(
//   padding: const EdgeInsets.all(20.0),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//    children:[
//      IconButton( icon:
//          Icon(
//             _controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
//         onPressed: () {
//           _controller.value.isPlaying
//               ? _controller.pause()
//               : _controller.play();
//           setState(() {});
//         }),
//
//      IconButton( icon:
//
//        Icon(
//       isMuted ? Icons.volume_off : Icons.volume_up,
//   color: Colors.black,
//   size: 30,
//       ),
//       onPressed:toggleMute,
//
//       ),
//      IconButton(
//        icon: Icon(
//          Icons.replay_10,
//          color: Colors.black,
//          size: 40,
//        ),
//        onPressed: seekBackward,
//      ),
//      IconButton(
//        icon: Icon(
//          Icons.forward_10,
//          color: Colors.black,
//          size: 40,
//        ),
//        onPressed: seekForward,
//      ),
//
//    ]
//   ),
// ),
