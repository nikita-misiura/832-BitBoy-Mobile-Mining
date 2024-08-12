package io.bitboy.mobile.miner_launcher

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.bitboy.mobile.miner_launcher.services.stats.StatsService


/** MinerLauncherPlugin */
class MinerLauncherPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        startListening(
            flutterPluginBinding.applicationContext,
            flutterPluginBinding.binaryMessenger
        )
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "miner.permissions" -> {
                //launcherService.checkPermissions(result)
            }
            "miner.launch" -> {
                launchMiner()
            }

            "miner.shutdown" -> {
                //result.success(launcherService.shutdown())
            }
            "stats.launch" -> {

            }

            else -> result.notImplemented()
        }
    }

    fun launchMiner(){
        val statServiceIntent = Intent(context, StatsService::class.java)
        context.startForegroundService(statServiceIntent)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        stopListening()
    }

    override fun onDetachedFromActivity() {
        stopListeningToActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        startListeningToActivity(
            binding.activity,
            binding::addActivityResultListener,
            binding::addRequestPermissionsResultListener
        )
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    private fun startListening(applicationContext: Context, messenger: BinaryMessenger) {
        this.context = applicationContext
        channel = MethodChannel(messenger, "miner_launcher")
        channel.setMethodCallHandler(this)
        //launcherService.updateContext(applicationContext)
    }

    private fun stopListening() {
        channel.setMethodCallHandler(null)
        //launcherService.updateContext(null)
    }

    private fun startListeningToActivity(
        activity: Activity,
        addActivityResultListener: ((PluginRegistry.ActivityResultListener) -> Unit),
        addRequestPermissionResultListener: ((PluginRegistry.RequestPermissionsResultListener) -> Unit)
    ) {
        /*launcherService.attachActivity(activity, PermissionHandler(
          activity.applicationContext,
          addActivityResultListener,
          addRequestPermissionResultListener))*/

    }

    private fun stopListeningToActivity() {
        //launcherService.detachActivity()
    }
}
