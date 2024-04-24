import Flutter
import UIKit
import KTVHTTPCache

public class VideoCachePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    // 注册实现
    LXFVideoCacheHostApiSetup.setUp(
      binaryMessenger: registrar.messenger(), 
      api: LXFVideoCacheHostApiImplementation()
    )
  }
}

class LXFVideoCacheHostApiImplementation: LXFVideoCacheHostApi {
  /// 是否可以代理
  private var canProxy: Bool?
  
  func convertToCacheProxyUrl(url: String) throws -> String {
    // 还未试过开启代理服务
    if (self.canProxy == nil) {
      self.canProxy = ((try? KTVHTTPCache.proxyStart()) != nil)
    }
    // 无法代理
    if !self.canProxy! { return url }
    // 无法转 URL 对象
    guard let urlObj = URL(string: url) else { return url }
    
    guard let proxyUrlObj = KTVHTTPCache.proxyURL(withOriginalURL: urlObj) else {
      // 代理失败
      return url
    }
    // 代理成功
    return proxyUrlObj.absoluteString
  }
}
