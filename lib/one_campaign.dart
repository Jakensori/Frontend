import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api_campaign.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
//캠페인 하나만 불러오려고 만든 파일이지만 필요가 없어져 결제로 바꿈
//나중에 헷갈리지 말기~ㅎㅎ

class OneCampaignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('여기서 결제하나요?'),
      ),
    ); // MaterialApp
  }
}
