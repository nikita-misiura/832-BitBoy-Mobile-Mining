package io.bitboy.mobile.miner_launcher.services.stats.data.data_source

import io.bitboy.mobile.miner_launcher.services.stats.data.repositories.RepositoryImpl
import io.bitboy.mobile.miner_launcher.services.stats.domain.repositories.Repository
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object RetrofitService {
    /// TODO change to base URL
    private const val BASE_URL = "baseUrl"

    val api: ApiService by lazy {
        Retrofit.Builder()
            .baseUrl(BASE_URL)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ApiService::class.java)
    }
}