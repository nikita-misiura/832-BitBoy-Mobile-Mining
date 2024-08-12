import 'package:flutter/material.dart';

enum Environment { dev, stage, prod }

class EnvironmentValues {
  final String key;
  final String baseUrl;

  const EnvironmentValues({
    required this.key,
    required this.baseUrl,
  });
}

class EnvironmentConfig {
  final String text;
  final Color color;
  final Environment environment;
  final EnvironmentValues values;

  static EnvironmentConfig? _instance;

  factory EnvironmentConfig({
    required Environment environment,
    required EnvironmentValues values,
    Color color = Colors.blue,
  }) {
    return _instance ??= EnvironmentConfig._internal(
      environment,
      environment.name.toUpperCase(),
      color,
      values,
    );
  }

  EnvironmentConfig._internal(
      this.environment,
      this.text,
      this.color,
      this.values,
      );

  static EnvironmentConfig get instance => _instance!;

  static bool get isDev => _instance!.environment == Environment.dev;
  static bool get isStage => _instance!.environment == Environment.stage;
  static bool get isProd => _instance!.environment == Environment.prod;
}
