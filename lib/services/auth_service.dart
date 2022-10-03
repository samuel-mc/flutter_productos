import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyDAqPvKUsNBUGvOf5TuP3of8t_DCrkufvs';

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    final url =
        Uri.https(_baseUrl, 'v1/accounts:signUp', {'key': _firebaseToken});

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResponse = json.decode(response.body);

    if (decodedResponse.containsKey('idToken')) {
      print(decodedResponse);
    } else {
      print('Error al guardar la información');
    }
  }
}
