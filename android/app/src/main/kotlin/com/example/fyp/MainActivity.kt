package com.example.fyp

import android.content.ContentResolver
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import android.Manifest
import android.content.res.Resources
import android.media.MediaPlayer
import android.net.Uri
import android.os.Build
import android.os.SystemClock
import android.provider.MediaStore
import android.provider.Settings
import android.view.MotionEvent
import android.view.View
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
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
                    val phoneNumber:String? = call.argument<String>("phNo")
                    val message:String? = call.argument<String>("msg")

                    if (phoneNumber != null && message != null) {
                        showToast("Whatapp")
                        openWhatsAppAndSendMessage(phoneNumber, message, result)
                    } else {
                        result.error("INVALID_ARGUMENTS", "Phone number or message is null", null)
                    }
                }
                "callOne" -> {
                    val phoneNumber:String? = call.argument<String>("phNo")
                    if(phoneNumber!= null && phoneNumber.length>10)
                    {
                        dialNumber(phoneNumber)
                        showToast("calling ${phoneNumber}")
                        result.success(null)
                    }
                    else{
                        showToast("Phone No. is Not Valid")
                    }

                }
                "swipeLTR"->{
                    swipeLeftToRight()
                    showToast("SwipeLTR")
                }
                "startDefaultMediaPlayer" -> {
                    startDefaultMediaPlayer()
                    result.success(null)
                }
            }
        }
    }

    private fun showToast(message: String?) {
        Toast.makeText(this@MainActivity, message , Toast.LENGTH_SHORT).show()
    }
    private fun startDefaultMediaPlayer() {
        val packageName = "com.miui.player"
        val intent = packageManager.getLaunchIntentForPackage(packageName)
        intent?.let {
            it.action = "android.intent.action.MAIN"
            it.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            startActivity(it)
        }
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

    private fun openWhatsAppAndSendMessage(
        phoneNumber: String,
        message: String,
        result: Result
    ) {


        showToast("Outside Whatsapp")
            showToast("Whatsapp is here")
            val uri = Uri.parse("https://wa.me/$phoneNumber/?text=${Uri.encode(message)}")
            val intent = Intent(Intent.ACTION_VIEW, uri)
            intent.`package` = "com.whatsapp"

            // Start the activity
            context.startActivity(intent)
            result.success(true) // Indicate success

    }

    fun isAppInstalled(packageName: String): Boolean {
        val packageManager = context.packageManager
        return try {
            packageManager?.getPackageInfo(packageName, PackageManager.GET_ACTIVITIES)
            showToast("Jabba")
            true // App is installed
        } catch (e: PackageManager.NameNotFoundException) {
            showToast("Not Jabba")
            false // App is not installed
        }
    }

   private fun dialNumber(phoneNumber: String) {
    val intent = Intent(Intent.ACTION_CALL, Uri.parse("tel:$phoneNumber"))
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    context.startActivity(intent)

    }
    fun swipeLeftToRight() {
        val screenWidth = Resources.getSystem().displayMetrics.widthPixels
        val screenHeight = Resources.getSystem().displayMetrics.heightPixels

        val startPointX = 100 // Starting point X coordinate (left side)
        val startPointY = screenHeight / 2 // Y coordinate (middle of the screen)
        val endPointX = screenWidth - 100 // Ending point X coordinate (right side)
        val endPointY = screenHeight / 2 // Y coordinate (middle of the screen)

        val downTime = SystemClock.uptimeMillis()
        val eventTime = SystemClock.uptimeMillis() + 100

        val downEvent = MotionEvent.obtain(downTime, eventTime, MotionEvent.ACTION_DOWN, startPointX.toFloat(), startPointY.toFloat(), 0)
        val moveEvent = MotionEvent.obtain(downTime, eventTime + 100, MotionEvent.ACTION_MOVE, endPointX.toFloat(), endPointY.toFloat(), 0)
        val upEvent = MotionEvent.obtain(downTime, eventTime + 200, MotionEvent.ACTION_UP, endPointX.toFloat(), endPointY.toFloat(), 0)

        val rootView = activity.window.decorView
        rootView.dispatchTouchEvent(downEvent)
        rootView.dispatchTouchEvent(moveEvent)
        rootView.dispatchTouchEvent(upEvent)

        downEvent.recycle()
        moveEvent.recycle()
        upEvent.recycle()
    }

}
open class FlutterActivity {

}
