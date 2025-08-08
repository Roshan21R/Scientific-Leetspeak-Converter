import 'package:flutter/material.dart';
import 'package:scientific_leetspeak_app/data/repositories/settings_repository_impl.dart';
import 'package:scientific_leetspeak_app/domain/entities/settings.dart';
import 'package:scientific_leetspeak_app/domain/repositories/settings_repository.dart';
import 'package:scientific_leetspeak_app/domain/usecases/get_settings.dart';
import 'package:scientific_leetspeak_app/presentation/navigation/main_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final SettingsRepository _settingsRepository = SettingsRepositoryImpl();
  late final GetSettings _getSettings;
  AppSettings? _settings;

  @override
  void initState() {
    super.initState();
    _getSettings = GetSettings(_settingsRepository);
    _loadSettings();
  }

  void _loadSettings() async {
    final settings = await _getSettings();
    setState(() {
      _settings = settings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scientific Leetspeak Converter',
      theme: ThemeData(
        brightness: _settings?.isDarkMode ?? false ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainNavigator(),
    );
  }
}