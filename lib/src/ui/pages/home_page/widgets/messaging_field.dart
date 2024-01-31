import 'package:flutter/material.dart';
// import 'package:gptva/src/core/core.dart';
import 'package:gptva/src/src.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MessagingField extends StatefulWidget {
  const MessagingField({super.key});

  @override
  State<MessagingField> createState() => _MessagingFieldState();
}

class _MessagingFieldState extends State<MessagingField> {
  TextEditingController controller = TextEditingController();
  bool isReady = false;
  

  

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 50),
      padding: KTheme.padding.copyWith(
        bottom: MediaQuery.of(context).viewInsets.bottom + 12,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: 6,
              minLines: 1,
              controller: controller,
              onChanged: (String? text) {
                setState(() => isReady = text!.isNotEmpty);
              },
              decoration: InputDecoration(
                hintText: "Message",
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: KTheme.borderRadius * 1.8,
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
            ),
          ),
          SizedBox(width: KTheme.padd),
          IconButton.filled(
          onPressed: isReady && !context.wHome.isLoading
              ? send
              : (controller.text.isEmpty && !_isListening)
                  ? handleMicInput
                  : () => _stopListening(),  // Call _stopListening() to stop recognition
          icon: _isListening
              ? const Icon(Icons.stop)
              : (isReady
                  ? const Icon(Icons.arrow_upward_outlined)
                  : const Icon(Icons.mic)),
        )
        ],
      ),
    );
  }

  void _stopListening() {
    setState(() => _isListening = false);
    _speechToText.stop();  // Stop speech recognition
  }

  Future<void> send() async {
    final String message = controller.text;
    setState(() {
      controller.text = "";
      isReady = false;
    });
    FocusScope.of(context).unfocus();

    await context.rHome.sendMessage(context, message);
  }

  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _speechToText.initialize(); // Initialize speech recognition
  }

  @override
  void dispose() {
    _speechToText.cancel(); // Cancel recognition when widget is disposed
    super.dispose();
  }

  void handleMicInput() async {
    await TTSService().stop();

    if (!_isListening) {
      bool available = await _speechToText.initialize(
        // onStatus: (val) => print('onStatus: $val'),
        // onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speechToText.listen(
          onResult: (val) => setState(() {
            controller.text = val.recognizedWords;
            if (val.finalResult) {
            send(); // Automatically send when a final result is received
            _isListening = false; // **Add this line to stop listening after sending**
          }
          }),
        );
      } else {
        // Speech recognition not available, handle the error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Speech recognition not available')),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speechToText.stop();
    }
  }
}
