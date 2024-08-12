abstract class SharedPreferencesService {
  Future<T?> getValue<T>({required String key});

  Future<bool> remove({required String key});

  Future<void> setValue<T>({required String key, required T value});
}
