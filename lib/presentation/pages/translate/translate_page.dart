import 'package:flutter/material.dart';
import 'package:scientific_leetspeak_app/data/repositories/history_repository_impl.dart';
import 'package:scientific_leetspeak_app/domain/entities/translation.dart';
import 'package:scientific_leetspeak_app/domain/repositories/history_repository.dart';
import 'package:scientific_leetspeak_app/domain/usecases/add_translation_to_history.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final TextEditingController _controller = TextEditingController();
  String _translatedText = 'Translated text will appear here';
  bool _isLoading = false;

  // In a real app, you would inject these dependencies.
  final HistoryRepository _historyRepository = HistoryRepositoryImpl();
  late final AddTranslationToHistory _addTranslationToHistory;

  @override
  void initState() {
    super.initState();
    _addTranslationToHistory = AddTranslationToHistory(_historyRepository);
  }

  void _translate() async {
    setState(() {
      _isLoading = true;
    });

    // This is where you would inject and use your translation logic
    await Future.delayed(const Duration(seconds: 1));
    final originalText = _controller.text;
    final translated = 'Translated: $originalText';
    final translation = Translation(originalText: originalText, translatedText: translated);
    await _addTranslationToHistory(translation);

    setState(() {
      _translatedText = translated;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter text to translate',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isLoading ? null : _translate,
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Translate'),
          ),
          const SizedBox(height: 16),
          Text(_translatedText),
        ],
      ),
    );
  }
}