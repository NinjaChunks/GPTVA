import 'dart:convert';
import 'dart:developer';

import 'config.dart' as config;
import 'package:gptva/src/src.dart';
import 'package:http/http.dart' as http;
// import 'package:beautiful_soup_dart/beautiful_soup.dart';

// Represents the GPT server API
class GPTServerApi {
  // Sends a message to the GPT server and retrieves a response
  static Future<GPTResponse> sendMessage(String message) async {
    try {
      final response = await http.post(
        config.url,
        headers: config.headers,
         body: jsonEncode({'user_message': message}),
      );
      if (response.statusCode == 200) {
        log(jsonDecode(response.body)["bot_response"]
            .toString());
        return GPTResponse(
          message: jsonDecode(response.body)["bot_response"],
          status: ResponseStatus.done,
        );
      } else {
        return GPTResponse(
          message:
              "${config.error}\nthe status from the server is ${response.statusCode} try to ask me what does that means later ok",
          status: ResponseStatus.error,
        );
      }
    } catch (e) {
      return GPTResponse(
        message: config.error,
        status: ResponseStatus.error,
      );
    }
  }

  // Creates a prompt for the GPT server based on the message and chat history
  // static Future<String> basePrompt(String message, ChatModel chat) async {
  //   final List<MessageModel> lastMessages = chat.messages.sublist(
  //     chat.messages.length > 4 ? chat.messages.length - 4 : 0,
  //   );
  //   List<String> urls = extractUrls(lastMessages.last.message);

  //   if (urls.isNotEmpty) {
  //     lastMessages.removeLast();
  //     lastMessages.add(
  //       MessageModel(
  //         message: "$message\n${jsonEncode({
  //               "question": message,
  //               "urls": [for (String url in urls) (await getPageContent(url))]
  //             })}",
  //         isUser: true,
  //       ),
  //     );
  //   }
  //   final String prompt = jsonEncode({
  //     "System": config.systemChat,
  //     "UserInfo": {
  //       // "username": AuthOptions.user.displayName,
  //       // "email": AuthOptions.user.email,
  //       // "photo_url": AuthOptions.user.photoURL,
  //     },
  //     "History": [for (MessageModel msg in lastMessages) msg.json]
  //   });
  //   return prompt;
  // }

  // Retrieves the title from the GPT server based on the chat history
  // static Future<GPTResponse> getTitle(ChatModel chat) async {
  //   final String prompt = jsonEncode({
  //     "System": config.titleSystem,
  //     "Conversation": [
  //       {"User": chat.messages.first.message},
  //       {"Assistant": chat.messages[1].message}
  //     ]
  //   });
  //   return await GPTServerApi.sendMessage(prompt);
  // }

  // Retrieves the content of a webpage from a given URL
  // static Future<Map<String, dynamic>> getPageContent(String url) async {
  //   final http.Response response;

  //   try {
  //     response = await http.get(Uri.parse(url));
  //   } catch (e) {
  //     return {"error": e};
  //   }
  //   Map<String, dynamic> result = {};

  //   if (response.statusCode == 200) {
  //     BeautifulSoup soup = BeautifulSoup(response.body);

  //     soup.findAll("script").forEach((tag) => tag.extract());
  //     soup.findAll("style").forEach((tag) => tag.extract());

  //     var metaData = {};
  //     soup.findAll('meta').forEach((tag) {
  //       var property = tag.attributes['property'];
  //       var content = tag.attributes['content'];
  //       if (property != null && content != null) {
  //         metaData[property] = content;
  //       }
  //     });

  //     var visibleText = soup
  //         .findAll("*")
  //         .map((e) => e.text.trim())
  //         .where((text) => text.isNotEmpty)
  //         .join(' ')
  //         .replaceAll(RegExp(r'\s\s+'), ' ');

  //     result = {
  //       "meta": metaData,
  //       "chunks": visibleText.length > 8000
  //           ? visibleText.substring(0, 8000)
  //           : visibleText,
  //     };
  //   } else {
  //     result = {
  //       "error": "Failed to load the webpage",
  //     };
  //   }
  //   return result;
  // }

  // Extracts URLs from the given text
  // static List<String> extractUrls(String text) {
  //   RegExp urlRegex = RegExp(r'(http|https)://([^\s]+)', caseSensitive: false);

  //   Iterable<RegExpMatch> matches = urlRegex.allMatches(text);
  //   return matches.map((match) => match.group(0) ?? '').toList();
  // }

  // Checks if the given text contains any URLs
  // static bool containsUrls(String text) => extractUrls(text).isNotEmpty;
}