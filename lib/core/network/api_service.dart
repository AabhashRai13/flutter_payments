import 'dart:convert';
import 'dart:developer';

import 'package:flutter_checkout_implementation/core/params/payment_params.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'http://10.10.15.144:3000';

  Future<http.Response> processPayment(PaymentParams params) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/process-payment'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(params.toJson()),
    );
    log('--------------------------------');
    log('Response: ${response.body}');
    log('--------------------------------');
    return response;
  }
}
