package io.bitboy.mobile.miner_launcher.services.stats.data.data_source.secure_storage.ciphers;

import java.security.Key;

public interface KeyCipher {
    byte[] wrap(Key key) throws Exception;

    Key unwrap(byte[] wrappedKey, String algorithm) throws Exception;
}
