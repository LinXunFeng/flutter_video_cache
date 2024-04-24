import 'package:flutter/material.dart';
import 'package:video_cache/video_cache.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _videoCachePlugin = VideoCache();

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  int currentPlayIndex = 0;

  List<String> srcList = [
    "http://aliuwmp3.changba.com/userdata/video/45F6BD5E445E4C029C33DC5901307461.mp4",
    "http://aliuwmp3.changba.com/userdata/video/3B1DDE764577E0529C33DC5901307461.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
  ];

  @override
  void initState() {
    super.initState();

    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    String url = srcList[currentPlayIndex];
    url = await _videoCachePlugin.convertToCacheProxyUrl(url);
    debugPrint('url -- $url');

    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
    await _videoPlayerController.initialize();
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: toggleVideo,
            iconData: Icons.live_tv_sharp,
            title: 'Toggle Video Src',
          ),
        ];
      },
    );
  }

  Future<void> toggleVideo() async {
    await _videoPlayerController.pause();
    currentPlayIndex += 1;
    if (currentPlayIndex >= srcList.length) {
      currentPlayIndex = 0;
    }
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Cache',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Video Cache Demo'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: _chewieController != null &&
                        _chewieController!
                            .videoPlayerController.value.isInitialized
                    ? Chewie(controller: _chewieController!)
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('Loading'),
                        ],
                      ),
              ),
            ),
            TextButton(
              onPressed: () {
                _chewieController?.enterFullScreen();
              },
              child: const Text('FullScreen'),
            ),
          ],
        ),
      ),
    );
  }
}
