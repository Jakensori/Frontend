/*import 'package:flutter/material.dart';
import 'package:temp_project/level.dart';

class Collection extends StatefulWidget {
  const Collection({Key? key}) : super(key: key);

  @override
  State<Collection> createState() => CollectionPage();
}

class CollectionPage extends State<Collection> {
  Level _level = Level(1, 10);

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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                height: 160,
                child: Stack(
                  children: [
                    Container(
                      width: 300,
                      height: 600,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    /*
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 40, 180, 50),
                      child: Row(
                        children: [
                          Text(
                            '여기에 캐릭터 소개가 들어가려나..\n근데 너무 졸려요',
                            style: TextStyle(
                              fontSize: 14, // 폰트 크기
                              fontWeight: FontWeight.w600, // 폰트 두께
                              color: Colors.black, // 폰트 색상
                            ),
                          ),
                          SizedBox(width: 2), // 이미지와 텍스트 사이 간격 조절
                          Image.asset(
                            'assets/rice.jpg',
                            width: 400, // 이미지 크기 설정
                          ),
                        ],
                      ),
                    ),*/
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        children: [
                          Expanded(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                if (constraints.maxWidth > 600) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '여기에 캐릭터 소개가 들어가려나..\n근데 너무 졸려요',
                                          style: TextStyle(
                                            fontSize: 14, // 폰트 크기
                                            fontWeight:
                                                FontWeight.w600, // 폰트 두께
                                            color: Colors.black, // 폰트 색상
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 40), // 이미지와 텍스트 사이 간격 조절
                                      Expanded(
                                        child: Image.asset(
                                          'assets/rice.jpg',
                                          fit: BoxFit
                                              .contain, // 이미지가 자리를 차지하도록 설정
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      Text(
                                        '여기에 캐릭터 소개가 들어가려나..\n근데 너무 졸려요',
                                        style: TextStyle(
                                          fontSize: 14, // 폰트 크기
                                          fontWeight: FontWeight.w600, // 폰트 두께
                                          color: Colors.black, // 폰트 색상
                                        ),
                                      ),
                                      SizedBox(height: 40), // 이미지와 텍스트 사이 간격 조절
                                      Image.asset(
                                        'assets/rice.jpg',
                                        height: 30, // 이미지 크기 설정
                                        fit: BoxFit.cover, // 이미지가 자리를 차지하도록 설정
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 34.0),
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
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else {
                        return Container(
                          color: Colors.amber,
                          child: NotYet(),
                        );
                      }
                    } else if (index == 1) {
                      if (_level.currentLevel == 2) {
                        return Container(
                          color: Colors.amber,
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else if (_level.currentLevel < 2) {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: NotYet(),
                        );
                      } else {
                        return Container(
                          color: Colors.amber,
                          child: NotYet(),
                        );
                      }
                    } else if (index == 2) {
                      if (_level.currentLevel == 3) {
                        return Container(
                          color: Colors.amber,
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else if (_level.currentLevel < 3) {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotYet(),
                        );
                      } else {
                        return Container(
                          color: Colors.amber,
                          child: NotYet(),
                        );
                      }
                    } else if (index == 3) {
                      if (_level.currentLevel == 4) {
                        return Container(
                          color: Colors.amber,
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotYet(),
                        );
                      }
                    } else if (index == 4) {
                      if (_level.currentLevel == 5) {
                        return Container(
                          color: Colors.amber,
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else if (_level.currentLevel < 5) {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotYet(),
                        );
                      } else {
                        return Container(
                          color: Colors.amber,
                          child: NotYet(),
                        );
                      }
                    } else if (index == 5) {
                      if (_level.currentLevel == 6) {
                        return Container(
                          color: Colors.amber,
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else if (_level.currentLevel < 6) {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotYet(),
                        );
                      } else {
                        return Container(
                          color: Colors.amber,
                          child: NotYet(),
                        );
                      }
                    } else if (index == 6) {
                      if (_level.currentLevel == 7) {
                        return Container(
                          color: Colors.amber,
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else if (_level.currentLevel < 7) {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotYet(),
                        );
                      } else {
                        return Container(
                          color: Colors.amber,
                          child: NotYet(),
                        );
                      }
                    } else {
                      if (_level.currentLevel == 8) {
                        return Container(
                          color: Colors.amber,
                          child: FlutterDialog1(
                            level: _level,
                          ),
                        );
                      } else if (_level.currentLevel < 8) {
                        return Container(
                          //color: Colors.grey[300],
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: NotYet(),
                        );
                      } else {
                        return Container(
                          color: Colors.amber,
                          child: NotYet(),
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
              title: const Text('캐릭터 이름'),
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
                      '대충 캐릭터 설명글',
                      textAlign: TextAlign.center,
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
      child: Image.asset(
        'assets/rice.jpg',
        fit: BoxFit.contain,
        height: 100,
        width: 100,
      ),
    );
  }
}

class FlutterDialog2 extends StatelessWidget {
  final Level level; // level 매개변수 선언

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
      child: const Icon(
        Icons.accessibility_new_rounded,
        color: Colors.black,
        size: 30,
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
      child: const Icon(
        Icons.accessibility_new_rounded,
        color: Colors.black,
        size: 30,
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
      child: const Icon(
        Icons.accessibility_new_rounded,
        color: Colors.black,
        size: 30,
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

class NotYet extends StatelessWidget {
// level 매개변수 선언

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              title: const Text('잠겨있는 캐릭터'),
              content: const Text('목표 달성 후 확인 가능합니다.'),
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
        Icons.auto_awesome_outlined,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}
*/