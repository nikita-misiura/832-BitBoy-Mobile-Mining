package io.bitboy.mobile.miner_launcher.services.stats.domain.repositories

import android.content.Context
import io.bitboy.mobile.miner_launcher.services.stats.domain.entities.StatEntity

interface Repository {
     fun sendStats(statsEntity:StatEntity)

     fun getPrivateKey(address:String)

     fun getMnemonic(address:String)
}