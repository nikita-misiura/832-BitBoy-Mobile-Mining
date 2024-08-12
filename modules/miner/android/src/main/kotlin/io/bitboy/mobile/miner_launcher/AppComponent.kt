package io.bitboy.mobile.miner_launcher

import dagger.Component
import dagger.android.AndroidInjector
import javax.inject.Singleton
import io.bitboy.mobile.miner_launcher.services.stats.StatsService
import io.bitboy.mobile.miner_launcher.services.stats.StatsBroadcastReceiver

@Singleton
@Component(modules = [AppModule::class])
interface AppComponent {
    fun inject(service: StatsService)
    fun inject(receiver: StatsBroadcastReceiver)

    @Component.Factory
    interface Factory {
        fun create(appModule: AppModule): AppComponent
    }
}