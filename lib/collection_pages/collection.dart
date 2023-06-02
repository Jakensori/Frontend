import 'package:flutter/material.dart';
import 'package:temp_project/collection_pages/level.dart';
//import 'package:temp_project/collection_pages/new_character.dart';

import 'api_mealpoint.dart';
import 'api_substract_mealpoint.dart';
import 'package:temp_project/const/colors.dart';
import 'package:flutter/cupertino.dart';

class Collection extends StatefulWidget {
  const Collection({Key? key}) : super(key: key);

  @override
  State<Collection> createState() => CollectionPage();
}

class CollectionPage extends State<Collection> {
  Level _level = Level(1, 10);
  MealPoint? mealPoint;
  late Future<MealPoint> _futureMealPoint;
  late Future<Map<String, dynamic>> _futureMoneyBox;

  void increaseMealPoint() {
    sendRequest(1).then((data) {
      setState(() {
        if (data != null) {
          final int mealPointNow = data - 1;
          print('meal_point: $mealPointNow');
          mealPoint = MealPoint(
            meal_point: mealPointNow,
            level: null,
          );
          updateMealpointNow(mealPointNow);
        }
      });
    }).catchError((error) {
      print('Request failed: $error');
    });
  }

  int mealpointNow = 0;

  void updateMealpointNow(int newMealpoint) {
    setState(() {
      mealpointNow = newMealpoint;
    });
  }

  void onOKPressed(int newMealpoint) {
    increaseMealPoint();
    updateMealpointNow(newMealpoint);
  }

  @override
  void initState() {
    super.initState();
    _futureMealPoint = getInfo();
    _futureMoneyBox = _futureMealPoint.then((mealPoint) {
      final moneyBoxData = {
        'mealPoint': mealPoint.meal_point,
        'level': mealPoint.level,
      };
      return Future.delayed(Duration.zero, () => moneyBoxData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: WHITE_COLOR,
        actions:[
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: IconButton(
              icon: Icon(CupertinoIcons.mail, color: BLACK_COLOR),
              iconSize: 35.0,
              onPressed: () {
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          //padding: EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    decoration: BoxDecoration(
                      color: Color(0xffFFC646),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 200,
                    height: 120,
                    child: FutureBuilder<Map<String, dynamic>>(
                      future: _futureMoneyBox,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          final moneyBoxData = snapshot.data;
                          final mealPoint = moneyBoxData?['mealPoint'] ?? 0;
                          final level = moneyBoxData?['level'] ?? 0;
                          final mealpointNow = moneyBoxData?['mealPoint'] ?? 0;

                          return Container(
                            alignment: Alignment.center,
                            child: mealPoint != null &&
                                    level != null &&
                                    mealpointNow != null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '보유 포인트: $mealpointNow p',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        '캐릭터 레벨: Lv. $level',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  )
                                : CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Image.asset(
                        'assets/rice.png',
                        fit: BoxFit.contain, // 이미지가 자리를 차지하도록 설정
                      ),
                    ),
                  ),
                ],
              ),
              //Spacer(flex: 2),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                padding: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                height: 600,
                child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      if (_level.currentLevel == 1) {
                        return Container(
                          //color: Colors.amber[400],
                          decoration: BoxDecoration(
                            color: Color(0xffFFC646),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else {
                        return Container(
                          color: Color(0xffFFC646),
                          child: NotYet(
                              index: index,
                              onOKPressed: () {
                                increaseMealPoint();
                                updateMealpointNow(mealpointNow);
                              }),
                        );
                      }
                    } else if (index == 1) {
                      if (_level.currentLevel == 2) {
                        return Container(
                          color: Color(0xffFFC646),
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else if (_level.currentLevel < 2) {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotYet(
                              index: index,
                              onOKPressed: () {
                                increaseMealPoint();
                                updateMealpointNow(mealpointNow);
                              }),
                        );
                      } else {
                        return Container(
                          color: Color(0xffFFC646),
                          child: NotYet(
                              index: index, onOKPressed: increaseMealPoint),
                        );
                      }
                    } else if (index == 2) {
                      if (_level.currentLevel == 3) {
                        return Container(
                          color: Color(0xffFFC646),
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else if (_level.currentLevel < 3) {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotYet(
                              index: index,
                              onOKPressed: () {
                                increaseMealPoint();
                                updateMealpointNow(mealpointNow);
                              }),
                        );
                      } else {
                        return Container(
                          color: Color(0xffFFC646),
                          child: NotYet(
                              index: index,
                              onOKPressed: () {
                                increaseMealPoint();
                                updateMealpointNow(mealpointNow);
                              }),
                        );
                      }
                    } else if (index == 3) {
                      if (_level.currentLevel == 4) {
                        return Container(
                          color: Color(0xffFFC646),
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotYet(
                              index: index,
                              onOKPressed: () {
                                increaseMealPoint();
                                updateMealpointNow(mealpointNow);
                              }),
                        );
                      }
                    } else if (index == 4) {
                      if (_level.currentLevel == 5) {
                        return Container(
                          color: Colors.yellow,
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else if (_level.currentLevel < 5) {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotYet(
                              index: index,
                              onOKPressed: () {
                                increaseMealPoint();
                                updateMealpointNow(mealpointNow);
                              }),
                        );
                      } else {
                        return Container(
                          color: Colors.yellow,
                          child: NotYet(
                              index: index,
                              onOKPressed: () {
                                increaseMealPoint();
                                updateMealpointNow(mealpointNow);
                              }),
                        );
                      }
                    } else if (index == 5) {
                      if (_level.currentLevel == 6) {
                        return Container(
                          color: Colors.yellow,
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else if (_level.currentLevel < 6) {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotYet(
                              index: index,
                              onOKPressed: () {
                                increaseMealPoint();
                                updateMealpointNow(mealpointNow);
                              }),
                        );
                      } else {
                        return Container(
                          color: Colors.yellow,
                          child: NotYet(
                              index: index,
                              onOKPressed: () {
                                increaseMealPoint();
                                updateMealpointNow(mealpointNow);
                              }),
                        );
                      }
                    } else if (index == 6) {
                      if (_level.currentLevel == 7) {
                        return Container(
                          color: Colors.yellow,
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else if (_level.currentLevel < 7) {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotYet(
                              index: index,
                              onOKPressed: () {
                                increaseMealPoint();
                                updateMealpointNow(mealpointNow);
                              }),
                        );
                      } else {
                        return Container(
                          color: Colors.yellow,
                          child: NotYet(
                              index: index,
                              onOKPressed: () {
                                increaseMealPoint();
                                updateMealpointNow(mealpointNow);
                              }),
                        );
                      }
                    } else {
                      if (_level.currentLevel == 8) {
                        return Container(
                          color: Colors.yellow,
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else if (_level.currentLevel < 8) {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotYet(
                              index: index,
                              onOKPressed: () {
                                increaseMealPoint();
                                updateMealpointNow(mealpointNow);
                              }),
                        );
                      } else {
                        return Container(
                          color: Colors.yellow,
                          child: NotYet(
                              index: index,
                              onOKPressed: () {
                                increaseMealPoint();
                                updateMealpointNow(mealpointNow);
                              }),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlutterDialog1 extends StatelessWidget {
  final Level level; // level 매개변수 선언

  const FlutterDialog1({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (level.currentLevel == 1) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              title: const Text('주먹밥'),
              content: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/rice.jpg',
                      fit: BoxFit.contain,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '이름: 주먹밥 \n 나이: 14 \n MBTI: ISTJ \n 취미: 키보드 치는 것을 좋아해요~ 같이 합주해요!!',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Image.asset(
        'assets/rice.png',
        fit: BoxFit.contain,
        height: 100,
        width: 100,
      ),
    );
  }
}

class NotYet extends StatelessWidget {
  final VoidCallback? onOKPressed;
  final int index;

  NotYet({this.onOKPressed, required this.index});

  Map<int, String> imagePaths = {
    0: 'assets/lock.png',
    1: 'assets/guesswhat1.png',
    2: 'assets/guesswhat2.png',
    3: 'assets/lock.png',
    4: 'assets/lock.png',
    5: 'assets/lock.png',
    6: 'assets/lock.png',
    7: 'assets/lock.png',
    8: 'assets/lock.png',
  };

  @override
  Widget build(BuildContext context) {
    String imagePath = imagePaths[index] ?? 'assets/lock.png';

    return TextButton(
      onPressed: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('잠겨있는 캐릭터'),
            content: const Text('밀포인트를 이용해서 캐릭터를 잠금해제하시겠습니까?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (onOKPressed != null) {
                    onOKPressed!();
                  }
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        height: 100,
        width: 100,
      ),
    );
  }
}

class FlutterDialog2 extends StatelessWidget {
  final Level level;

  const FlutterDialog2({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (level.currentLevel == 2) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              title: const Text('캐릭터 이름'),
              content: Row(
                children: [
                  Expanded(
                    child: Text(
                      '대충 캐릭터 설명글',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'images/rice.png',
                      fit: BoxFit.contain,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      /*
      child: const Icon(
        Icons.accessibility_new_rounded,
        color: Colors.black,
        size: 30,
      ),*/
      child: Image.asset(
        'images/rice.png',
        fit: BoxFit.contain,
        height: 100,
        width: 100,
      ),
    );
  }
}

class FlutterDialog3 extends StatelessWidget {
  final Level level; // level 매개변수 선언

  const FlutterDialog3({Key? key, required this.level}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (level.currentLevel == 3) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              title: const Text('             캐릭터 이름           '),
              content: const Text('대충 캐릭터 설명글 \n\n\n\n\n\n\n\n\n\n\n'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Image.asset(
        'assets/lock.png',
        fit: BoxFit.contain,
        height: 100,
        width: 100,
      ),
    );
  }
}

class FlutterDialog4 extends StatelessWidget {
  final Level level; // level 매개변수 선언

  const FlutterDialog4({Key? key, required this.level}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (level.currentLevel == 4) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              title: const Text('             캐릭터 이름           '),
              content: const Text('대충 캐릭터 설명글 \n\n\n\n\n\n\n\n\n\n\n'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Image.asset(
        'assets/lock.png',
        fit: BoxFit.contain,
        height: 100,
        width: 100,
      ),
    );
  }
}

class FlutterDialog5 extends StatelessWidget {
  final Level level; // level 매개변수 선언

  const FlutterDialog5({Key? key, required this.level}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (level.currentLevel == 5) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              title: const Text('             캐릭터 이름           '),
              content: const Text('대충 캐릭터 설명글 \n\n\n\n\n\n\n\n\n\n\n'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Image.asset(
        'assets/lock.png',
        fit: BoxFit.contain,
        height: 100,
        width: 100,
      ),
    );
  }
}

class FlutterDialog6 extends StatelessWidget {
  final Level level; // level 매개변수 선언

  const FlutterDialog6({Key? key, required this.level}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (level.currentLevel == 6) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              title: const Text('             캐릭터 이름           '),
              content: const Text('대충 캐릭터 설명글 \n\n\n\n\n\n\n\n\n\n\n'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: const Icon(
        Icons.accessibility_new_rounded,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}

class FlutterDialog7 extends StatelessWidget {
  final Level level; // level 매개변수 선언

  const FlutterDialog7({Key? key, required this.level}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (level.currentLevel == 7) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              title: const Text('             캐릭터 이름           '),
              content: const Text('대충 캐릭터 설명글 \n\n\n\n\n\n\n\n\n\n\n'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: const Icon(
        Icons.accessibility_new_rounded,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}

class FlutterDialog8 extends StatelessWidget {
  final Level level; // level 매개변수 선언

  const FlutterDialog8({Key? key, required this.level}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (level.currentLevel == 8) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              title: const Text('             캐릭터 이름           '),
              content: const Text('대충 캐릭터 설명글 \n\n\n\n\n\n\n\n\n\n\n'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: const Icon(
        Icons.accessibility_new_rounded,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}
