import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ordertracking/model/failure_model.dart';
import 'package:ordertracking/model/item_model.dart';

class OrderTracking {
  static const String _baseurl = "https://api.notion.com/v1/";
  Future<List<Item>> getItem() async {
    final url = '${_baseurl}databases/${dotenv.env['DATABASE_ID']}/query';
    try {
      final response = await http.post(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${dotenv.env['API_KEY']}',
        'Notion-Version': "2021-05-13",
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        var finalData = (data['results'] as List)
            .map((e) => Item.fromMap(e))
            .toList()
              ..sort((a, b) => b.time.compareTo(a.time));
        return finalData;
      } else {
        throw const Failure(message: "Something Went Wrong");
      }
    } catch (e) {
      throw const Failure(message: "Something Went Wrong");
    }
  }
}
