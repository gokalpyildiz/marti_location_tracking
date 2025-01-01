package com.gokalpyildiz.marti_location_tracking

import android.Manifest
import android.annotation.SuppressLint
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.android.gms.location.*
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val LOCATION_CHANNEL = "com.gokalpyildiz.marti_location_tracking"
    private val LOCATION_EVENT_CHANNEL = "com.gokalpyildiz.marti_location_updates"
    private val PERMISSION_REQUEST_CODE = 101

    private var fusedLocationProviderClient: FusedLocationProviderClient? = null
    private var locationCallback: LocationCallback? = null
    private var eventSink: EventChannel.EventSink? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        fusedLocationProviderClient = LocationServices.getFusedLocationProviderClient(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, LOCATION_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startBackground" -> {
                    if (checkPermissions()) {
                        startLocationUpdates()
                        result.success("Konum takibi başlatıldı.")
                    } else {
                        requestPermissions()
                        result.error("PERMISSION_DENIED", "Konum izni verilmedi", null)
                    }
                }
                "stopBackground" -> {
                    stopLocationUpdates()
                    result.success("Konum takibi durduruldu.")
                }
                else -> result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, LOCATION_EVENT_CHANNEL).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
            }
        })
    }

    private fun checkPermissions(): Boolean {
        return ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED &&
               ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED
    }

    private fun requestPermissions() {
        ActivityCompat.requestPermissions(
            this,
            arrayOf(Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION),
            PERMISSION_REQUEST_CODE
        )
    }

    @SuppressLint("MissingPermission")
    private fun startLocationUpdates() {
        val locationRequest = LocationRequest.Builder(
            Priority.PRIORITY_HIGH_ACCURACY, 1000
        ).setMinUpdateDistanceMeters(10f).build()

        locationCallback = object : LocationCallback() {
            override fun onLocationResult(locationResult: LocationResult) {
                val location = locationResult.lastLocation
                if (location != null) {
                    val locationData = mapOf(
                        "latitude" to location.latitude,
                        "longitude" to location.longitude
                    )
                    eventSink?.success(locationData)
                }
            }
        }

        fusedLocationProviderClient?.requestLocationUpdates(locationRequest, locationCallback!!, mainLooper)
    }

    private fun stopLocationUpdates() {
        fusedLocationProviderClient?.removeLocationUpdates(locationCallback!!)
        eventSink = null
    }
}
