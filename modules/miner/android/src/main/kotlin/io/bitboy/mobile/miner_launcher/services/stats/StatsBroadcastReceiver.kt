package io.bitboy.mobile.miner_launcher.services.stats

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.core.content.edit
import com.google.gson.Gson
import io.bitboy.mobile.miner_launcher.services.stats.domain.repositories.Repository
import io.bitboy.mobile.miner_launcher.services.stats.data.data_source.RetrofitService
import io.bitboy.mobile.miner_launcher.services.stats.domain.entities.StatEntity
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import javax.inject.Inject

class StatsBroadcastReceiver : BroadcastReceiver() {

    @Inject
    lateinit var repository: Repository
    override fun onReceive(context: Context?, intent: Intent?) {
        try {
            Log.d("StatsBroadcastReceiver", "Broadcast received")

            //TODO delete later
            logCountForTest(context)

            if (intent?.getAction().equals("io.bitboy.stats_sender")) {
                intent?.extras?.let {
                    //val statJson = it.getParcelable<StatEntity>("statEntity")
                    val statJson = it.getString("statEntity")
                    Log.d("StatsBroadcastReceiver", "Received data: $statJson")
                }
            }
        } catch (e: Exception) {
            Log.d("StatsBroadcastReceiver", "error")

        }

    }

    //TODO delete later
    private fun logCountForTest(context: Context?) {
        val sharedPref = context?.getSharedPreferences(
            "StatsBroadcastReceiver", Context.MODE_PRIVATE
        )
        val count = sharedPref?.getInt("count", 0) ?: 0
        sharedPref?.edit {
            putInt("count", count + 1)
        }
        Log.d("StatsBroadcastReceiver", "count: ${count + 1}")


    }

    private fun sendStat(statEntity: StatEntity) {
        CoroutineScope(Dispatchers.IO).launch {
            CoroutineScope(Dispatchers.IO).launch {
                try {
                    repository.sendStats(statEntity)
                } catch (e: Exception) {
                    println("MyBroadcastReceiver \n Error sending request \n $e")
                }
            }
        }
    }

}