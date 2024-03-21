package com.example.fyp

import android.content.ContentResolver
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.view.View
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.view.ViewCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result


class MainActivity : FlutterActivity() {
    private val channelName = "gesturely"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)

        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "showToast" -> {
                    val message = call.argument<String>("message")
                    showToast(message)
                }
                "scrollScreen" -> {
                    val message=call.argument<Int>("offset")
                    val success=scrollScreen(message?:10)
                    result.success(success)
                }
                "increaseBrightness" -> {
                    checkSystemWritePermission()
                    val brightnessLevel = call.argument<Int>("level")
                    val success =increaseBrightness(brightnessLevel?:50)
                    showToast("incresed by ${brightnessLevel}")
                    result.success(null)
                }
                "decreaseBrightness" -> {
                    val brightnessLevel = call.argument<Int>("level")
                    decreaseBrightness(brightnessLevel ?: 50) // Default level is 50 if not provided
                    result.success(null)
                }
                "openWhatsAppAndSendMessage" -> {
                    val phoneNumber = call.argument<String>("phNo")
                    val message = call.argument<String>("msg")

                    if (phoneNumber != null && message != null) {
                        openWhatsAppAndSendMessage(phoneNumber, message, result)
                    } else {
                        result.error("INVALID_ARGUMENTS", "Phone number or message is null", null)
                    }
                }
            }
        }
    }

    private fun showToast(message: String?) {
        Toast.makeText(this@MainActivity, message , Toast.LENGTH_LONG).show()
    }

    private fun scrollScreen(offset: Int): Boolean {
        val rootView = window.decorView.findViewById<View>(android.R.id.content)
        return try {
            rootView?.let {
                ViewCompat.postOnAnimationDelayed(it, { it.scrollBy(0, offset) }, 200)
                true
            } ?: false
        } catch (e: Exception) {
            e.printStackTrace()
            false
        }
    }
    private fun increaseBrightness(level: Int) {
        try {
            val currentBrightness = Settings.System.getInt(this.context.contentResolver, Settings.System.SCREEN_BRIGHTNESS)
            val newBrightness = currentBrightness + (level*10)
            Settings.System.putInt(this.context.contentResolver, Settings.System.SCREEN_BRIGHTNESS, newBrightness)
        } catch (e: Exception) {
            e.printStackTrace() // Add appropriate error handling
        }
    }

    private fun decreaseBrightness(level: Int) {
        try {
            val currentBrightness = Settings.System.getInt(this.context.contentResolver, Settings.System.SCREEN_BRIGHTNESS)
            val newBrightness = currentBrightness - (level*10)
            Settings.System.putInt(this.context.contentResolver, Settings.System.SCREEN_BRIGHTNESS, newBrightness)
        } catch (e: Exception) {
            e.printStackTrace() // Add appropriate error handling
        }
    }


    private fun checkSystemWritePermission(): Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            if (Settings.System.canWrite(context)) return true else openAndroidPermissionsMenu()
        }
        return false
    }

    private fun openAndroidPermissionsMenu() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            val intent = Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS)
            intent.data = Uri.parse("package:" + context.packageName)
            context.startActivity(intent)
        }
    }

    fun openWhatsAppAndSendMessage(
        phoneNumber: String,
        message: String,
        result: Result
    ) {
        val whatsappPackage = "com.whatsapp"

        // Check if WhatsApp is installed on the device
        if (isAppInstalled(whatsappPackage)) {
            // Create a URI with the phone number
            val uri = Uri.parse("https://wa.me/$phoneNumber/?text=${Uri.encode(message)}")

            // Create an intent to open WhatsApp with the URI
            val intent = Intent(Intent.ACTION_VIEW, uri)
            intent.`package` = whatsappPackage

            // Start the activity
            context.startActivity(intent)
            result.success(true) // Indicate success
        } else {
            result.success(false) // Indicate failure (WhatsApp not installed)
        }
    }

    fun isAppInstalled(packageName: String): Boolean {
        val packageManager = context.packageManager
        return try {
            packageManager?.getPackageInfo(packageName, PackageManager.GET_ACTIVITIES)
            true // App is installed
        } catch (e: PackageManager.NameNotFoundException) {
            false // App is not installed
        }
    }
}
open class FlutterActivity {

}
