package io.alexmelnyk.prevent_screenshots

import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    companion object {
        const val METHOD_CHANNEL_NAME = "io.alexmelnyk.utils"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            METHOD_CHANNEL_NAME
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "preventScreenCapture" -> {
                    call.argument<Boolean>("enable")?.let {
                        if (it) {
                            window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        } else {
                            window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        }

                        result.success(null)
                    } ?: run {
                        result.error("-14", "Missing parameters", "Missing parameter 'enable'")
                    }
                }
            }
        }
    }
}
