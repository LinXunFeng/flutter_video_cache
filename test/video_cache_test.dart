// import 'package:flutter_test/flutter_test.dart';
// import 'package:video_cache/video_cache.dart';
// import 'package:video_cache/video_cache_platform_interface.dart';
// import 'package:video_cache/video_cache_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockVideoCachePlatform
//     with MockPlatformInterfaceMixin
//     implements VideoCachePlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final VideoCachePlatform initialPlatform = VideoCachePlatform.instance;

//   test('$MethodChannelVideoCache is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelVideoCache>());
//   });

//   test('getPlatformVersion', () async {
//     VideoCache videoCachePlugin = VideoCache();
//     MockVideoCachePlatform fakePlatform = MockVideoCachePlatform();
//     VideoCachePlatform.instance = fakePlatform;

//     expect(await videoCachePlugin.getPlatformVersion(), '42');
//   });
// }
