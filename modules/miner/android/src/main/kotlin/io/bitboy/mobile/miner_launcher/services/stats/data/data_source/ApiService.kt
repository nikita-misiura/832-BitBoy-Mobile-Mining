package io.bitboy.mobile.miner_launcher.services.stats.data.data_source

import io.bitboy.mobile.miner_launcher.services.stats.domain.entities.StatEntity
import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.POST

interface ApiService  {

    @POST("yourpath")
    fun sendJsonMessage(@Body message: StatEntity): Call<Void>
}