import 'dart:convert';
import 'package:doshex_weight_tracker/models/user.dart';
import 'package:doshex_weight_tracker/models/weight.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesProvider extends ChangeNotifier {
  static var client = http.Client();

  User currentUser =
      User(name: '', email: '', password: '', confirm_password: '');

  Weight currentWeight = Weight(current_weight: '', created_at: '');

// Sign Up
  Future<User> signUp(String name, String email, String password,
      String confirm_password) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.200:8000/signUp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': confirm_password,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Create User');
    }
  }

  // Login
  Future<User> loginAccount(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.200:8000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Sign In User');
    }
  }

  // Logout
  Future<User> logoutAccount() async {
    final response = await http.get(
      Uri.parse('http://192.168.0.200:8000/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return User.fromJson(jsonDecode(response.body));
  }

  // Save Weight
  Future<Weight> saveWeight(String current_weight) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.200:8000/weight'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'current_weight': current_weight}),
    );

    if (response.statusCode == 201) {
      return Weight.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Save Users Weight');
    }
  }

  // Update Weight
  Future<Weight> updateWeight(String current_weight) async {
    final response = await http.put(
      Uri.parse('http://192.168.0.200:8000/weight/:id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'current_weight': current_weight,
      }),
    );

    if (response.statusCode == 201) {
      return Weight.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Update User Weight');
    }
  }

  // Get Weight History
  Future<Weight> getWeightHistory() async {
    final response = await http.get(
      Uri.parse('http://192.168.0.200:8000/weight'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

      List jsonResponse = json.decode(response.body);
      var data = jsonResponse.map((job) => Weight.fromJson(job)).toList();


    if (response.statusCode == 201) {
      return data[0];
    } else {
      throw Exception('Failed to Get User Weight');
    }
  }

  // Delete Weight
  Future<Weight> deleteWeight(String current_weight) async {
    final response = await http.put(
      Uri.parse('http://192.168.0.200:8000/weight/:id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'current_weight': current_weight,
      }),
    );

    if (response.statusCode == 201) {
      return Weight.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Delete User Weight');
    }
  }
}
