package io.bitboy.mobile.miner_launcher.services.stats.data.data_source.secure_storage.ciphers;

public interface StorageCipher {
    byte[] encrypt(byte[] input) throws Exception;

    byte[] decrypt(byte[] input) throws Exception;
}
