import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> fetchHomeUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({http.Client? client})
      : client = client ?? http.Client();

  @override
  Future<List<UserModel>> fetchHomeUsers() async {
    try {
      debugPrint('[UserRemoteDataSource] Fetching: ${ApiConstants.homeUsersUrl}');
      final response = await client.get(
        Uri.parse(ApiConstants.homeUsersUrl),
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        },
      ).timeout(const Duration(seconds: 4));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'] as List<dynamic>? ?? [];

        if (results.isNotEmpty) {
          final users = results.asMap().entries.map((entry) {
            final int index = entry.key;
            final Map<String, dynamic> userJson =
                entry.value as Map<String, dynamic>;
            return UserModel.fromJson(userJson, index);
          }).toList();

          debugPrint(
              '[UserRemoteDataSource] Successfully loaded ${users.length} users from RandomUser API');
          return users;
        }
      }
      debugPrint(
          '[UserRemoteDataSource] Status ${response.statusCode} - using fallback profiles');
      return UserModel.getFallbackProfiles();
    } catch (e) {
      debugPrint(
          '[UserRemoteDataSource] Exception ($e) - using fallback profiles');
      return UserModel.getFallbackProfiles();
    }
  }
}
