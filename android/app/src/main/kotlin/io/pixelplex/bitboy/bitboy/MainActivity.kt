package io.pixelplex.bitboy.bitboy

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity(){
    init {
        System.loadLibrary("TrustWalletCore")
    }
}
