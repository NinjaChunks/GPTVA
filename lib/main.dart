// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:gptva/firebase_options.dart';
import 'package:gptva/gptva.dart';
import 'package:gptva/src/src.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Storage.initialize();
  // await Storage.prefs.clear();
  List<ChatModel> chats = await Storage.getChats();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomePageProvider(chats)),
      ],
      child: const GPTVA(),
    ),
  );
}
