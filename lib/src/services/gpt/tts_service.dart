// tts_service.dart
import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts _tts = FlutterTts();
  final List<String> _messagesToSpeak = [];
  bool _isSpeaking = false;

  Future<void> speakMessage(String message) async {
    _messagesToSpeak.add(message);

    // Start speaking if not already active
    if (!_isSpeaking) {
      _isSpeaking = true;
      _speakNextMessage();
    }
  }

  Future<void> _speakNextMessage() async {
    if (_messagesToSpeak.isNotEmpty) {
      final message = _messagesToSpeak.removeAt(0);
      await _tts.speak(message);
    }
    _isSpeaking = false;
  }

  Future<void> stop() async {
    // Add code here to stop the TTS engine
    // For example:
    await _tts.stop();
  }
}