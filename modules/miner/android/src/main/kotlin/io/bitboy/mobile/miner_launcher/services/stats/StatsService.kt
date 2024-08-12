package io.bitboy.mobile.miner_launcher.services.stats

import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.IBinder
import io.bitboy.mobile.miner_launcher.AppComponent
import io.bitboy.mobile.miner_launcher.AppModule
import io.bitboy.mobile.miner_launcher.DaggerAppComponent
import io.bitboy.mobile.miner_launcher.services.stats.domain.repositories.Repository
import javax.inject.Inject


class StatsService : Service() {
    @Inject
    lateinit var repository: Repository



    private lateinit var appComponent: AppComponent

    override fun onCreate() {
        super.onCreate()

        appComponent = DaggerAppComponent.factory().create(AppModule(this))
        appComponent.inject(this)

        val filter = IntentFilter()
        filter.addAction("io.bitboy.stats_sender");
        this.registerReceiver(StatsBroadcastReceiver(), filter,2)// RECEIVER_EXPORTED  = 2
    }

    override fun onBind(p0: Intent?): IBinder? {
        return null
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        onTaskRemoved(intent)
        return START_STICKY
    }

    override fun onDestroy() {
        val statServiceIntent = Intent(this, StatsService::class.java)
        this.startForegroundService(statServiceIntent)
        super.onDestroy()
    }
}