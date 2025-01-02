package com.gokalpyildiz.marti_location_tracking

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi

class BootReceiver : BroadcastReceiver() {
    @RequiresApi(Build.VERSION_CODES.O)
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            Log.d("LocationSharing", "Boot completed, starting LocationService")
            val serviceIntent = Intent(context, LocationService::class.java)
            context.startForegroundService(serviceIntent)
        }
    }
}