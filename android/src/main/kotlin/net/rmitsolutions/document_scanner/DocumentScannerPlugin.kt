package net.rmitsolutions.document_scanner

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Build
import com.scanlibrary.ScanActivity
import com.scanlibrary.ScanConstants
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import java.io.File

/** DocumentScannerPlugin */
class DocumentScannerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {
    private val scanRequestCode = 200
    private var activity: Activity? = null
    private lateinit var channel: MethodChannel
    private lateinit var result: Result

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "document_scanner")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        this.result = result
        if (call.method == "getScannedImage") {
            startScanner()
        } else {
            result.notImplemented()
        }
    }

    private fun startScanner() {
        val preference = ScanConstants.OPEN_CAMERA
        val intent = Intent(activity?.applicationContext, ScanActivity::class.java)
        intent.putExtra(ScanConstants.OPEN_INTENT_PREFERENCE, preference)
        activity?.startActivityForResult(intent, scanRequestCode)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null;
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == scanRequestCode && resultCode == Activity.RESULT_OK) {
            val uri: Uri? = if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.S_V2) {
                data!!.extras!!.getParcelable<Uri>(ScanConstants.SCANNED_RESULT)
            } else {
                data!!.extras!!.getParcelable(ScanConstants.SCANNED_RESULT, Uri::class.java)
            }

            if (uri == null) {
                result.error("", "No document scanned.", "")
                return true
            }

            File(uri.path!!).inputStream().use {
                val imageBytes = it.readBytes()
                result.success(imageBytes)
            }

            return true
        }
        return false
    }
}
