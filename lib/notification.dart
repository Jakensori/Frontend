import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class Noti {
  int? id;
  String? createdAt;
  String? title;
  String? foundation;
  String? content;
  String? image;
  String? campaine;

  Noti(
      {required this.id,
      required this.createdAt,
      required this.title,
      required this.foundation,
      required this.content,
      required this.image,
      required this.campaine});

  factory Noti.fromJson(Map<String, dynamic> json) {
    return Noti(
      id: json["id"],
      createdAt: json["createdAt"],
      title: json["title"],
      foundation: json["foundation"],
      content: json["content"],
      image: json["image"],
      campaine: json["campaine"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['title'] = this.title;
    data['foundation'] = this.foundation;
    data['content'] = this.content;
    data['image'] = this.image;
    data['campaine'] = this.campaine;

    return data;
  }
}

/*
class NotiList {
  List<Noti>? notificationList;

  factory NotiList.fromJson(List<dynamic> json) {
    List<Noti> NotiList;
    var list = json[""] as List;
    NotiList = list.map((i) => Noti.fromJson(i)).toList();

    return NotiList;
  }
}
*/