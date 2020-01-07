import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';
import 'package:spirit_clock/clock_page.dart';

class SpiritClock extends StatefulWidget {

  const SpiritClock(this.model);
  final ClockModel model;

  @override
  _SpiritClockState createState() => _SpiritClockState();
}

class _SpiritClockState extends State<SpiritClock> with TickerProviderStateMixin {

  DateTime _dateTime = DateTime.now();
  Timer _earthTimer;
  Timer _meteorTimer;
  Timer _starOneTimer;
  Timer _starTwoTimer;
  Timer _starThreeTimer;
  AnimationController _earthController;
  AnimationController _meteorController;
  Animation _meteorMovement;
  double opacityOneLevel = 0.0;
  double opacityTwoLevel = 0.0;
  double opacityThreeLevel = 0.0;
  int bOneTime = 1000;
  int bTwoTime = 1000;
  int bThreeTime = 1000;

  _changeOneOpacity() {
    if(opacityOneLevel == 0) {
      setState(() {
        opacityOneLevel = 1.0;
        bOneTime = 100;
      });
    }
    else {
      setState(() {
        opacityOneLevel = 0.0;
        bOneTime = 1000;
      });
    }
  }

  _changeTwoOpacity() {
    if(opacityTwoLevel == 0) {
      setState(() {
        opacityTwoLevel = 1.0;
        bTwoTime = 100;
      });
    }
    else {
      setState(() {
        opacityTwoLevel = 0.0;
        bTwoTime = 1000;
      });
    }
  }

  _changeThreeOpacity() {
    if(opacityThreeLevel == 0) {
      setState(() {
        opacityThreeLevel = 1.0;
        bThreeTime = 100;
      });
    }
    else {
      setState(() {
        opacityThreeLevel = 0.0;
        bThreeTime = 1000;
      });
    }
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _earthTimer = Timer(Duration(seconds: 1), _updateTime,);
    });
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  Widget buildEarthRotationTransition() {
    return Center(
      child: RotationTransition(
        alignment: Alignment.center,
        turns: _earthController,
        child: Container(
          child: Center(
            child: FractionallySizedBox(
              heightFactor: 0.8,
              child: Image.asset(
                'assets/earth.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 0xff64ffda - dark
  /// 0xff2196f3 - light
  Widget themeIcon(BuildContext context) {
    // light
    if(Theme.of(context).accentColor == Color(0xff2196f3)) {
      return Container(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 10.0),
        child: Image.asset(
          "assets/light.png",
          width: 30.0,
          height: 30.0,
        ),
      );
    }
    // dark
    else {
      return Container(
        padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 10.0),
        child: Image.asset(
          "assets/dark.png",
          width: 30.0,
          height: 30.0,
        ),
      );
    }
  }

  Widget weatherIcon(String weatherString) {
    if(weatherString == "cloudy") {
      return Image.asset(
        "assets/cloudy-fill.png",
        width: 22.0,
        height: 22.0,
      );
    }
    else if(weatherString == "foggy") {
      return Image.asset(
        "assets/foggy-fill.png",
        width: 22.0,
        height: 22.0,
      );
    }
    else if(weatherString == "rainy") {
      return Image.asset(
        "assets/rainy-fill.png",
        width: 22.0,
        height: 22.0,
      );
    }
    else if(weatherString == "snowy") {
      return Image.asset(
        "assets/snowy-fill.png",
        width: 22.0,
        height: 22.0,
      );
    }
    else if(weatherString == "sunny") {
      return Image.asset(
        "assets/sunny-fill.png",
        width: 22.0,
        height: 22.0,
      );
    }
    else if(weatherString == "thunderstorm") {
      return Image.asset(
        "assets/thunderstorm-fill.png",
        width: 22.0,
        height: 22.0,
      );
    }
    else {
      return Image.asset(
        "assets/windy-fill.png",
        width: 22.0,
        height: 22.0,
      );
    }
  }

  Widget starOneBreathe(int bTime) {
    return AnimatedOpacity(
      opacity: opacityOneLevel,
      duration: new Duration(milliseconds: bTime),
      child: Container(
        color: Colors.white,
        width: 4.0,
        height: 4.0,
      ),
      onEnd: () {
        if(opacityOneLevel == 1.0) {
          _changeOneOpacity();
        }
        else {
          _loopOneStarAnimation();
        }
      },
    );
  }

  Widget starTwoBreathe(int bTime) {
    return AnimatedOpacity(
      opacity: opacityTwoLevel,
      duration: new Duration(milliseconds: bTime),
      child: Container(
        color: Colors.white,
        width: 4.0,
        height: 4.0,
      ),
      onEnd: () {
        if(opacityTwoLevel == 1.0) {
          _changeTwoOpacity();
        }
        else {
          _loopTwoStarAnimation();
        }
      },
    );
  }

  Widget starThreeBreathe(int bTime) {
    return AnimatedOpacity(
      opacity: opacityThreeLevel,
      duration: new Duration(milliseconds: bTime),
      child: Container(
        color: Colors.white,
        width: 4.0,
        height: 4.0,
      ),
      onEnd: () {
        if(opacityThreeLevel == 1.0) {
          _changeThreeOpacity();
        }
        else {
          _loopThreeStarAnimation();
        }
      },
    );
  }

  Widget _timeUnit() {
    if(int.parse(DateFormat('HH').format(_dateTime)) > 12) {
      return Container(
        child: Text(
          'P M',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: "SubwayTicker",
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      );
    }
    else {
      return Container(
        child: Text(
          'A M',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: "SubwayTicker",
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _earthController = AnimationController(duration: const Duration(milliseconds: 500000), vsync: this);
    _meteorController = AnimationController(duration: Duration(milliseconds: 5000), vsync: this,);
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
    _earthController.forward();
    _earthController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _earthController.reset();
        _earthController.forward();
      } else if (status == AnimationStatus.dismissed) {
        //动画从 controller.reverse() 反向执行 结束时会回调此方法
      } else if (status == AnimationStatus.forward) {
        //执行 controller.forward() 会回调此状态
      } else if (status == AnimationStatus.reverse) {
        //执行 controller.reverse() 会回调此状态
      }
    });
    _initMeteorAnimation();
    _loopOneStarAnimation();
    _loopTwoStarAnimation();
    _loopThreeStarAnimation();
  }

  void _meteorForward() {
    _meteorController.reset();
    _meteorController.forward();
  }

  _initMeteorAnimation(){
    _meteorMovement = Tween(
        begin: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0,),
        end: EdgeInsets.only(left: 1000.0, top: 530.0,)
    ).animate(
        _meteorController
    )..addListener((){
      setState(() {

      });
    })
    ..addStatusListener((listener) {
      if(listener == AnimationStatus.completed) {
        _loopMeteorAnimation();
      }
    });
    _meteorForward();
  }

  void _loopMeteorAnimation() {
    setState(() {
      _meteorTimer = Timer(Duration(seconds: 25), _meteorForward, );
    });
  }

  void _loopOneStarAnimation() {
    setState(() {
      _starOneTimer = Timer(Duration(seconds: 7), _changeOneOpacity, );
    });
  }

  void _loopTwoStarAnimation() {
    setState(() {
      _starTwoTimer = Timer(Duration(seconds: 9), _changeTwoOpacity, );
    });
  }

  void _loopThreeStarAnimation() {
    setState(() {
      _starThreeTimer = Timer(Duration(seconds: 11), _changeThreeOpacity, );
    });
  }

  @override
  void didUpdateWidget(SpiritClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }


  @override
  Widget build(BuildContext context) {

    String month = DateFormat('MM').format(_dateTime);
    if(month == "01") {
      month = "Jan";
    }
    else if(month == "02") {
      month = "Feb";
    }
    else if(month == "03") {
      month = "Mar";
    }
    else if(month == "04") {
      month = "Apr";
    }
    else if(month == "05") {
      month = "May";
    }
    else if(month == "06") {
      month = "Jun";
    }
    else if(month == "07") {
      month = "Jul";
    }
    else if(month == "08") {
      month = "Aug";
    }
    else if(month == "09") {
      month = "Sep";
    }
    else if(month == "10") {
      month = "Oct";
    }
    else if(month == "11") {
      month = "Nov";
    }
    else {
      month = "Dec";
    }
    final day = DateFormat('dd').format(_dateTime);
    final fontSize = MediaQuery.of(context).size.width / 15;

    return Container(
      color: Colors.black87,
      child: Stack(
        children: <Widget>[

          // 星星图片 背景部分
          Container(
            color: Colors.black,
            child: ConstrainedBox(
              constraints: new BoxConstraints.expand(),
              child: Image.asset(
                'assets/star.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 流星动画效果
          Container(
            padding: _meteorMovement.value,
            child: Image.asset(
              "assets/meteor.png",
              width: 12.0,
              height: 12.0,
            ),
          ),

          // 星星1号
          Container(
            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 5, MediaQuery.of(context).size.width / 10, 0.0, 0.0),
            child: starOneBreathe(bOneTime),
          ),

          // 星星2号
          Container(
            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 15, MediaQuery.of(context).size.height / 2, 0.0, 0.0),
            child: starTwoBreathe(bTwoTime),
          ),

          // 星星3号
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, MediaQuery.of(context).size.width / 10, MediaQuery.of(context).size.height / 3),
            child: Align(
              alignment: Alignment.bottomRight,
              child: starOneBreathe(bOneTime),
            ),
          ),

          // 星星4号
          Container(
            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 5, 0.0, 0.0, MediaQuery.of(context).size.height / 10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: starThreeBreathe(bThreeTime),
            ),
          ),

          // 地球背景部分
          buildEarthRotationTransition(),

          // 黑色蒙版
          Container(
            color: Colors.black26,
          ),

          // 内容部分
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                // 上部分
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      // 日期
                      Container(
                        padding: EdgeInsets.fromLTRB(40.0, 25.0, 0.0, 0.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${day}  ${month}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                      ),

                      // 时间
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        padding: EdgeInsets.fromLTRB(0.0, 15.0, 53.0, 0.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: widget.model.is24HourFormat ? Clock24Page(fontSize, true) : Clock12Page(fontSize, false),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 58.0, 0.0),
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: widget.model.is24HourFormat ? SizedBox.shrink() : _timeUnit(),
                        ),
                      ),

                    ],
                  ),
                ),

                // 下部分
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      // 左边
                      themeIcon(context),

                      // 天气
                      Container(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 15.0),
                        child:  Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                                      child: weatherIcon(widget.model.weatherString),
                                    ),
                                    Container(
                                      child: Text(
                                        '${widget.model.temperature} ${widget.model.unitString}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 2.0),
                              child: Text(
                                '${widget.model.low} ~ ${widget.model.high} ${widget.model.unitString}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    _meteorController?.dispose();
    _starThreeTimer?.cancel();
    _starTwoTimer?.cancel();
    _starOneTimer?.cancel();
    _meteorTimer?.cancel();
    _earthTimer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

}
