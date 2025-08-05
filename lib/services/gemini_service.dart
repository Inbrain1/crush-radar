import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = 'AIzaSyD0QPIsEiLzVkR09d6W0gvsBOPMgQkw9uY'; // 👈 Pega tu clave aquí
  static const String _url = 'https://generativelanguage.googleapis.com/v1/models/gemini-1.5-flash-002:generateContent?key=$_apiKey';
  static Future<String> getGeminiResponse(String message) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": "Eres una persona coqueta y divertida. El usuario te dice: '$message'. Responde como si te gustara hablar con él:"
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["candidates"][0]["content"]["parts"][0]["text"];
    } else {
      print('ERROR: ${response.statusCode} - ${response.body}');
      return "Ups, no pude responder ahora 😢";

    }
  }
}