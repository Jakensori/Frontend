import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:temp_project/start.dart';
import 'package:temp_project/const/colors.dart';


class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  double _value1=3.0;
  //double _value2=0.0;
  double _value3=3000.0;


  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages:[
        PageViewModel(
          title: '권은정 님, 환영해요',
          body: 'Pass the Meal은 \'기부금을 모으다\' 의 표현,\n\'Pass the Hat\'에서 유래했어요\n'
              '은정 님이 아낀 식비만큼\n 배고픈 사람들에게 기부할 수 있어요\n\n'
              'LET\'S PASS THE MEAL TOGETHER!\n',
          image:Image.asset(
            'assets/logo3.png'),
          decoration: getPageDecoration1()
        ),

        PageViewModel(
            title: '',
            body: '\n하루에 몇 끼 드시나요? \n\n ${_value1.toInt()} 회',
            footer:SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 20.0,
                  trackShape: RoundedRectSliderTrackShape(),
                  activeTrackColor: PRIMARY_COLOR.withOpacity(0.8),
                  inactiveTrackColor:GREY_COLOR.withOpacity(0.6),
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 14.0,
                    pressedElevation: 8.0,
                  ),
                  thumbColor: PRIMARY_COLOR,
                  overlayColor:PRIMARY_COLOR.withOpacity(0.2),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 32.0),
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 3.0),
                  activeTickMarkColor: WHITE_COLOR,
                  inactiveTickMarkColor: WHITE_COLOR,
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: BLACK_COLOR,
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              child:Slider(
                value:_value1,
                min:0.0,
                max:5.0,
                divisions:5,
                label:'${_value1.round()}',
                onChanged: (newValue){
                  setState(() {
                    _value1=newValue;
                  });
                },
              )
            ),
            decoration: getPageDecoration2()
        ),
        PageViewModel(
            title: '',
            body: '\n이번 달 목표 식비는\n얼마인가요?\n\n${_value3.round()*100} 원',
            footer:SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  showValueIndicator: ShowValueIndicator.always,
                  trackHeight: 20.0,
                  trackShape: RoundedRectSliderTrackShape(),
                  activeTrackColor: PRIMARY_COLOR.withOpacity(0.8),
                  inactiveTrackColor:GREY_COLOR.withOpacity(0.6),
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 14.0,
                    pressedElevation: 8.0,
                  ),
                  thumbColor: PRIMARY_COLOR,
                  overlayColor:PRIMARY_COLOR.withOpacity(0.2),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 32.0),
                  tickMarkShape: RoundSliderTickMarkShape(),
                  activeTickMarkColor: GREY_COLOR,
                  inactiveTickMarkColor: WHITE_COLOR,
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: BLACK_COLOR,
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                child:Slider(
                  value: _value3,
                  min:500.0,
                  max:10000.0,
                  label:'${_value3.round()*100}',
                  onChanged: (newValue){
                    setState(() {
                      _value3=newValue;
                    });
                  },
                )
            ),
            decoration: getPageDecoration2()
        )
      ],
      done: Text('Go to Login',
          style:TextStyle(
            fontSize:17,
            color: PRIMARY_COLOR,
            fontWeight:FontWeight.w900,
            letterSpacing:1
          )),
      onDone:(){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const StartPage()),);
      },
      next: const Icon(Icons.arrow_forward),
      dotsDecorator: DotsDecorator(
        color: BLACK_COLOR,
        size: Size(10,10),
        activeSize: Size(22,10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)
        ),
        activeColor: PRIMARY_COLOR,
      ),
      curve: Curves.easeInCirc
    );
  }

  PageDecoration getPageDecoration1(){
    return PageDecoration(
      titleTextStyle: TextStyle(
        fontSize:25,
        fontWeight: FontWeight.w600,
          color: BLACK_COLOR,
      ),
      bodyTextStyle: TextStyle(
        fontSize:17,
        color: BLACK_COLOR,
          fontWeight: FontWeight.w700,
        height:2
      ),
      imagePadding:EdgeInsets.only(top:100),
      boxDecoration: BoxDecoration(
        color:WHITE_COLOR,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: PRIMARY_COLOR, // 테두리 색상
          width: 20.0,
          //top: BorderSide(width: 10, color: Colors.transparent),
            //bottom: BorderSide(width: 10, color: Colors.transparent),
            //left: BorderSide(width: 10, color: Colors.transparent),
            //right: BorderSide(width: 10, color: Colors.transparent)// 여백의 두께와 색상 설정
        ),
      )
    );
  }
  PageDecoration getPageDecoration2(){
    return PageDecoration(
        titleTextStyle: TextStyle(
          fontSize:25,
          fontWeight: FontWeight.bold,
          color: BLACK_COLOR,
        ),
        bodyTextStyle: TextStyle(
            fontSize:28,
            color: BLACK_COLOR,
            fontWeight: FontWeight.w800,
            height:1.7
        ),
        //imagePadding:EdgeInsets.only(top:100),
        boxDecoration: BoxDecoration(
          color:WHITE_COLOR,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: PRIMARY_COLOR, // 테두리 색상
            width: 20.0,
            //top: BorderSide(width: 10, color: Colors.transparent),
            //bottom: BorderSide(width: 10, color: Colors.transparent),
            //left: BorderSide(width: 10, color: Colors.transparent),
            //right: BorderSide(width: 10, color: Colors.transparent)// 여백의 두께와 색상 설정
          ),
        )
    );
  }

  String _formatTime(int hour, int minute) {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
