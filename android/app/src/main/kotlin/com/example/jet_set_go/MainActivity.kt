package com.example.jet_set_go

// MainActivity.kt (or MainActivity.java)
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel  // Import MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
}
class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.app/play_services" // MUST MATCH DART CHANNEL NAME

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "isPlayServicesAvailable") {
                val isAvailable = isGooglePlayServicesAvailable() // Your implementation
                result.success(isAvailable)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun isGooglePlayServicesAvailable(): Boolean {
        // Implement your logic here to check for Play Services.  For example:
        val googleApiAvailability = com.google.android.gms.common.GoogleApiAvailability.getInstance()
        val resultCode = googleApiAvailability.isGooglePlayServicesAvailable(this)
        return resultCode == com.google.android.gms.common.ConnectionResult.SUCCESS
    }
}