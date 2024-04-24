import 'package:pigeon/pigeon.dart';

// https://github.com/flutter/packages/blob/main/packages/pigeon/example/README.md
@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/plugin/pigeon.g.dart',
  kotlinOut:
      'android/src/main/kotlin/com/lxf/video_cache/VideoCacheGeneratedApis.g.kt',
  kotlinOptions: KotlinOptions(
    // https://github.com/fluttercommunity/wakelock_plus/issues/18
    errorClassName: "LXFVideoCacheFlutterError",
  ),
  swiftOut: 'ios/Classes/LXFVideoCacheGeneratedApis.g.swift',
))
@HostApi()
abstract class LXFVideoCacheHostApi {
  /// 转换为缓存代理URL
  String convertToCacheProxyUrl(String url);
}
