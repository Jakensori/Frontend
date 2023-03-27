import 'package:flutter/material.dart';
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
              ),
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
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      if (_level.currentLevel == 1) {
                        return Container(
                          //color: Colors.amber[400],
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(30),
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
                  borderRadius: BorderRadius.circular(8.0)),
              title: const Text('당근'),
              content: const Text(
                  '별명: ㄷㄱ \n기부 횟수: 5회\n기부 금액: 100000원 이상\n\n\n           --- 사진 첨부 예정---'),
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
        size: 50,
        color: Colors.black,
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
              title: const Text('아직이야'),
              content: const Text('이건 아직 잠겨있음'),
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
