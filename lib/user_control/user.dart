import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class userInfo {
  String? username;
  String? password;

  userInfo({
    required this.username,
    required this.password,
  });

  factory userInfo.fromJson(Map<String, dynamic> json) {
    return userInfo(
      username: json["user_id"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.username;
    data['password'] = this.password;

    return data;
  }
}
