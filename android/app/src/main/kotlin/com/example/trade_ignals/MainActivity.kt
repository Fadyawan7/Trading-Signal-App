package com.example.trade_ignals

import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "trading_signal_app/device_info"
        ).setMethodCallHandler { call, result ->
            if (call.method != "getDeviceInfo") {
                result.notImplemented()
                return@setMethodCallHandler
            }

            val deviceName = listOfNotNull(
                Build.MANUFACTURER?.takeIf { it.isNotBlank() },
                Build.MODEL?.takeIf { it.isNotBlank() }
            ).joinToString(" ").ifBlank { "Android Device" }

            val androidId = Settings.Secure.getString(
                contentResolver,
                Settings.Secure.ANDROID_ID
            )

            val deviceId = listOf(
                Build.FINGERPRINT,
                androidId,
                Build.ID,
                Build.HARDWARE,
                Build.PRODUCT
            ).firstOrNull { !it.isNullOrBlank() } ?: "android-device"

            result.success(
                mapOf(
                    "device_name" to deviceName,
                    "device_type" to "android",
                    "device_id" to deviceId
                )
            )
        }
    }
}
