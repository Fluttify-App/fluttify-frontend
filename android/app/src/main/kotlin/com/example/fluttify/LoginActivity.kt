package de.htwg.fluttify

import android.content.Context
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity


class LoginActivity : FlutterActivity() {
    protected override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState);
        val uri = intent.data;
        val token =  uri?.getQueryParameters("auth")?.first().toString();
        val sharedPreferences = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE);
        val editor = sharedPreferences.edit();
        editor.putString("flutter.token", token);
        editor.commit();
    }
}