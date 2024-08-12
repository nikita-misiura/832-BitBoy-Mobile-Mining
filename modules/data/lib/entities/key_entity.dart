class KeyEntity {
  final String key;
  final String value;

  const KeyEntity({
    required this.key,
    required this.value,
  });

  KeyEntity copyWith({String? key, String? value}) {
    return KeyEntity(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }
}
