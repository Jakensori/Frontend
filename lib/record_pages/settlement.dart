import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';

class SettlementInfo {
  final int? count;
  final int? donation_possible;
  final int? today_donation;

  SettlementInfo(
      {required this.count,
      required this.donation_possible,
      required this.today_donation});

  factory SettlementInfo.fromJson(Map<String, dynamic> json) {
    return SettlementInfo(
        count: json["count"],
        donation_possible: json["donation_possible"],
        today_donation: json["today_donation"]);
  }
}
