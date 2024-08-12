package io.bitboy.mobile.miner_launcher

import android.content.Context
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import dagger.Module
import dagger.Provides
import io.bitboy.mobile.miner_launcher.services.stats.data.data_source.ApiService
import io.bitboy.mobile.miner_launcher.services.stats.data.repositories.RepositoryImpl
import io.bitboy.mobile.miner_launcher.services.stats.domain.repositories.Repository
import io.bitboy.mobile.miner_launcher.services.stats.data.data_source.secure_storage.SecureStorage
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Singleton

@Module
class AppModule(private val context: Context) {

    @Provides
    @Singleton
    fun provideGson(): Gson = GsonBuilder().create()

    @Provides
    @Singleton
    fun provideRetrofit(gson: Gson): Retrofit = Retrofit.Builder()
        .baseUrl("https://api.example.com")
        .addConverterFactory(GsonConverterFactory.create(gson))
        .build()

    @Provides
    @Singleton
    fun provideApiService(retrofit: Retrofit): ApiService = retrofit.create(ApiService::class.java)

    @Provides
    @Singleton
    fun provideSecureStorage(): SecureStorage = SecureStorage(this.context, mapOf())

    @Provides
    @Singleton
    fun provideRepository(apiService: ApiService, secureStorage: SecureStorage): Repository =
        RepositoryImpl(apiService, secureStorage)
}