import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class UserInfo {
  int? id;
  String? username;
  String? email;
  String? password;
  String? token;

  UserInfo({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.token,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        id: json["user_info"]["id"],
        username: json["user_info"]["username"],
        email: json["user_info"]["email"],
        password: json["user_info"]["password"],
        token: json["token"]);
  }
/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;

    return data;
  }
  */
}
