package com.crew72.jet_set_go

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import com.google.android.gms.common.GoogleApiAvailability

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.app/play_services" // MUST MATCH DART CHANNEL NAME

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "isPlayServicesAvailable") {
                val isAvailable = isGooglePlayServicesAvailable() // Your implementation
                result.success(isAvailable)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun isGooglePlayServicesAvailable(): Boolean {
        // Implement your logic here to check for Play Services.
        val googleApiAvailability = GoogleApiAvailability.getInstance()
        val resultCode = googleApiAvailability.isGooglePlayServicesAvailable(this)
        return resultCode == com.google.android.gms.common.ConnectionResult.SUCCESS
    }
}
