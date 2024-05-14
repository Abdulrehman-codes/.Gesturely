package com.example.fyp

import android.accessibilityservice.AccessibilityServiceInfo
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
import android.util.Log
import android.view.MotionEvent
import android.view.View
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.view.ViewCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

class MainActivity : FlutterActivity() {
    private val channelName = "gesturely"
    private var mediaPlayer: MediaPlayer? = null
    private var _audioFilePath: String? = null

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
                    val offset = call.argument<Int>("offset") ?: 100
                    val success = triggerScroll(offset)
                    result.success(success)
                }
                "increaseBrightness" -> {
                    checkSystemWritePermission()
                    val brightnessLevel = call.argument<Int>("level")
                    increaseBrightness(brightnessLevel ?: 50)
                    result.success(null)
                }
                "decreaseBrightness" -> {
                    val brightnessLevel = call.argument<Int>("level")
                    decreaseBrightness(brightnessLevel ?: 50)
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
                "callOne" -> {
                    val phoneNumber = call.argument<String>("phNo")
                    if (phoneNumber != null && phoneNumber.length > 10) {
                        dialNumber(phoneNumber)
                        showToast("calling $phoneNumber")
                        result.success(null)
                    } else {
                        showToast("Phone No. is Not Valid")
                    }
                }
                "swipeLTR" -> {
                    swipeLeftToRight()
                    showToast("SwipeLTR")
                }
                "startDefaultMediaPlayer" -> {
                    startDefaultMediaPlayer()
                    result.success(null)
                }
                "audioPlay" -> {
                    _audioFilePath = call.argument<String>("filePath")
                    _audioFilePath?.let {
                        Log.d("AudioPlay", "Playing audio file from path: $it")
                        audioPlay(it)
                        result.success(null)
                    } ?: result.error("FILE_PATH_ERROR", "Audio file path is null", null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun showToast(message: String?) {
        Toast.makeText(this@MainActivity, message, Toast.LENGTH_SHORT).show()
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

    private fun triggerScroll(offset: Int): Boolean {
        MyAccessibilityService.isFloatingButtonClicked = true
        Log.d("Scroll", "Scroll Triggered with offset: $offset")
        return true
    }

    private fun increaseBrightness(level: Int) {
        try {
            val currentBrightness = Settings.System.getInt(this.contentResolver, Settings.System.SCREEN_BRIGHTNESS)
            val newBrightness = currentBrightness + (level * 10)
            Settings.System.putInt(this.contentResolver, Settings.System.SCREEN_BRIGHTNESS, newBrightness)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun decreaseBrightness(level: Int) {
        try {
            val currentBrightness = Settings.System.getInt(this.contentResolver, Settings.System.SCREEN_BRIGHTNESS)
            val newBrightness = currentBrightness - (level * 10)
            Settings.System.putInt(this.contentResolver, Settings.System.SCREEN_BRIGHTNESS, newBrightness)
        } catch (e: Exception) {
            e.printStackTrace()
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

    private fun openWhatsAppAndSendMessage(phoneNumber: String, message: String, result: MethodChannel.Result) {
        val uri = Uri.parse("https://wa.me/$phoneNumber/?text=${Uri.encode(message)}")
        val intent = Intent(Intent.ACTION_VIEW, uri)
        intent.`package` = "com.whatsapp"

        try {
            context.startActivity(intent)
            result.success(true)
        } catch (e: Exception) {
            result.error("ERROR", "Failed to open WhatsApp", e.message)
        }
    }

    private fun dialNumber(phoneNumber: String) {
        val intent = Intent(Intent.ACTION_CALL, Uri.parse("tel:$phoneNumber"))
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.CALL_PHONE) != PackageManager.PERMISSION_GRANTED) {
            // Request the permission if not already granted
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.CALL_PHONE), 1)
            return
        }
        context.startActivity(intent)
    }

    private fun swipeLeftToRight() {
        val screenWidth = Resources.getSystem().displayMetrics.widthPixels
        val screenHeight = Resources.getSystem().displayMetrics.heightPixels

        val startPointX = 100
        val startPointY = screenHeight / 2
        val endPointX = screenWidth - 100
        val endPointY = screenHeight / 2

        val downTime = SystemClock.uptimeMillis()
        val eventTime = SystemClock.uptimeMillis() + 100

        val downEvent = MotionEvent.obtain(downTime, eventTime, MotionEvent.ACTION_DOWN, startPointX.toFloat(), startPointY.toFloat(), 0)
        val moveEvent = MotionEvent.obtain(downTime, eventTime + 100, MotionEvent.ACTION_MOVE, endPointX.toFloat(), endPointY.toFloat(), 0)
        val upEvent = MotionEvent.obtain(downTime, eventTime + 200, MotionEvent.ACTION_UP, endPointX.toFloat(), endPointY.toFloat(), 0)

        val rootView = window.decorView.findViewById<View>(android.R.id.content)
        rootView.dispatchTouchEvent(downEvent)
        rootView.dispatchTouchEvent(moveEvent)
        rootView.dispatchTouchEvent(upEvent)

        downEvent.recycle()
        moveEvent.recycle()
        upEvent.recycle()
    }

    private fun audioPlay(filePath: String) {
        mediaPlayer?.release() // Release any previous MediaPlayer instance
        mediaPlayer = MediaPlayer().apply {
            try {
                setDataSource(filePath)
                prepare()
                start()
                Log.d("AudioPlay", "Audio is playing from path: $filePath")
            } catch (e: Exception) {
                e.printStackTrace()
                showToast("Error playing audio file.")
                Log.e("AudioPlay", "Error playing audio file: ${e.message}")
            }
        }
    }
}
