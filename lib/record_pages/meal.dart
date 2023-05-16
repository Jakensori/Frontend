import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class MealInfo {
  String? when;
  String? category;
  int? price;
  String? memo;

  MealInfo(
      {required this.when,
      required this.category,
      required this.price,
      required this.memo});

  factory MealInfo.fromJson(Map<String, dynamic> json) {
    return MealInfo(
        when: json["when"],
        category: json["category"],
        price: json["price"],
        memo: json["memo"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['when'] = this.when;
    data['category'] = this.category;
    data['price'] = this.price;
    data['memo'] = this.memo;

    return data;
  }
}

class MealRecord {
  List<MealInfo>? breakfast;
  List<MealInfo>? launch;
  List<MealInfo>? dinner;
  List<MealInfo>? snack;
  List<MealInfo>? others;
  final List<MealInfo>? meal;

  final int? day_budget;
  final int? consumption;

  MealRecord({
    required this.meal,
    required this.day_budget,
    required this.consumption,
  });

  factory MealRecord.fromJson(Map<String, dynamic> json) {
    var list = json["records"] as List;
    List<MealInfo> mealInfoList =
        list.map((i) => MealInfo.fromJson(i)).toList();

    return MealRecord(
        meal: mealInfoList,
        day_budget: json["day_budget"],
        consumption: json["comsumption"]);
  }
}
