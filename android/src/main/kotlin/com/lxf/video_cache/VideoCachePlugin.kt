package com.lxf.video_cache

import LXFVideoCacheHostApi
import com.danikula.videocache.HttpProxyCacheServer

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** VideoCachePlugin */
class VideoCachePlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var videoCacheHostApiImplementation: LXFVideoCacheHostApiImplementation

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        videoCacheHostApiImplementation = LXFVideoCacheHostApiImplementation(flutterPluginBinding)

        LXFVideoCacheHostApi.setUp(
                flutterPluginBinding.binaryMessenger,
                videoCacheHostApiImplementation,
        )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        videoCacheHostApiImplementation.shutdown()
    }

    override fun onMethodCall(call: MethodCall, result: Result) {}
}

class LXFVideoCacheHostApiImplementation(
        private val flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
) : LXFVideoCacheHostApi {
    private val cacheServer by lazy { HttpProxyCacheServer.Builder(flutterPluginBinding.applicationContext).build() }

    override fun convertToCacheProxyUrl(url: String): String {
        return cacheServer.getProxyUrl(url)
    }

    fun shutdown() {
        cacheServer.shutdown()
    }
}


