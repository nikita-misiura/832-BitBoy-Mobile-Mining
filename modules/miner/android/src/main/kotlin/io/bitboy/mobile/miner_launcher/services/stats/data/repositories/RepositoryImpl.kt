package io.bitboy.mobile.miner_launcher.services.stats.data.repositories

import io.bitboy.mobile.miner_launcher.services.stats.domain.entities.StatEntity
import io.bitboy.mobile.miner_launcher.services.stats.domain.repositories.Repository
import io.bitboy.mobile.miner_launcher.services.stats.data.data_source.secure_storage.SecureStorage
import io.bitboy.mobile.miner_launcher.services.stats.data.data_source.ApiService
import io.bitboy.mobile.miner_launcher.services.stats.data.entities.WalletConstants
import javax.inject.Inject


class RepositoryImpl  @Inject constructor(
    private val apiService: ApiService,
    private val secureStorage: SecureStorage
) : Repository {
    override fun sendStats(statsEntity: StatEntity) {
        println("send stat repository ${statsEntity}")
    }

    override fun getPrivateKey( address: String) {
        secureStorage.ensureOptions()

        val keyStorePrivateKey = getKeyStorePrivateKey(address)

        val keyWithPrefix = secureStorage.addPrefixToKey(keyStorePrivateKey)
        println("$keyWithPrefix")

        val privateKey: String? = secureStorage.read(keyWithPrefix)
    }

    override fun getMnemonic( address: String) {
        secureStorage.ensureOptions()

        val keyStoreMnemonic = getKeyStoreMnemonic(address)

        val keyWithPrefix = secureStorage.addPrefixToKey(keyStoreMnemonic)

        val mnemonic: String? = secureStorage.read(keyWithPrefix)
    }
    private fun getKeyStorePrivateKey(address: String): String {
        val prefix =  WalletConstants.privateKeyPrefix;

        return "${prefix}_$address"
    }

    private fun getKeyStoreMnemonic(address: String): String {
        val prefix =  WalletConstants.mnemonicKeyPrefix;

        return "${prefix}_$address"
    }
}