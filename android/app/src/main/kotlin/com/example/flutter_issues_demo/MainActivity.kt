package com.example.flutter_issues_demo

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        // GeneratedPluginRegistrant.registerWith(flutterEngine);
        GeneratedPluginRegistrant.registerWith(ShimPluginRegistry(flutterEngine))
    }
}
