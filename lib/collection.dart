import 'package:flutter/material.dart';

class Collection extends StatefulWidget {
  const Collection({Key? key}) : super(key: key);

  @override
  State<Collection> createState() => CollectionPage();
}

class CollectionPage extends State<Collection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFFFFFF),
        title: Text('도감 페이지'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              /*
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'ListView',
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),*/
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                height: 160,
                child: Stack(
                  children: [
                    Container(
                      width: 600,
                      height: 400,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(70, 40, 180, 5),
                      child: Text(
                        '여기에 이제 캐릭터 나옴',
                        style: TextStyle(
                          fontSize: 18, // 폰트 크기
                          fontWeight: FontWeight.w600, // 폰트 두께
                          color: Colors.black, // 폰트 색상
                        ),
                      ),
                    ),
                  ],
                ),
                /*
                child: ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(right: 8.0),
                      decoration: BoxDecoration(color: Colors.pinkAccent),
                      width: 120,
                      child: Center(
                        child: Text('리스트뷰 ${index + 1}'),
                      ),
                    );
                  },
                ),*/
              ),
              /*
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'GridView',
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),*/
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                height: 400,
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: 12,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(color: Colors.amber[200]),
                      child: Center(
                        child: Text('그리드뷰 ${index + 1}'),
                      ),
                    );
                  },
                ),
              ),
              /*
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Container',
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 300,
                margin: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                ),
                child: Center(
                  child: Text('컨테이너'),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
