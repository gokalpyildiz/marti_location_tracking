package com.gokalpyildiz.marti_location_tracking

import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.IBinder
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat

class LocationService : Service() {
    override fun onBind(p0: Intent?): IBinder? {
        TODO("Not yet implemented")
    }

    companion object {
        const val ACTION_START = "ACTION_START"
        const val ACTION_STOP = "ACTION_STOP"
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        return super.onStartCommand(intent, flags, startId)
        when (intent?.action) {
            ACTION_START -> start()
            ACTION_STOP -> stop()
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun start() {
        val notification = createServiceNotification(
            "Konum Dinleniyor"
        )

        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) {
            startForeground(1, notification)
        } else {
            startForeground(1, notification, ServiceInfo.FOREGROUND_SERVICE_TYPE_LOCATION);
        }

    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun createServiceNotification(message: String): Notification {
        val builder: NotificationCompat.Builder

        val notificationManager =
            this.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        val intent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_IMMUTABLE)

        val channelId: String = "channelId"
        val channelName: String = "channelName"
        val channelPriority = NotificationManager.IMPORTANCE_HIGH

        var channel = notificationManager.getNotificationChannel(channelId)

        if (channel == null) {
            channel = NotificationChannel(channelId, channelName, channelPriority)
            notificationManager.createNotificationChannel(channel)
        }

        builder = NotificationCompat.Builder(this, channelId).setContentTitle(message)
            .setContentText(message).setAutoCancel(false).setContentIntent(pendingIntent)

        notificationManager.notify(1, builder.build())
        return builder.build()
    }

    private fun stop() {
        stopForeground(true)
        stopSelf()
    }

}