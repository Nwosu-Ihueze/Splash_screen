import 'package:splash_screens/Animations/fadeanimation.dart';
import 'package:splash_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage()
  )
);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
   
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300)
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0, end: 0.8
    ).animate(_scaleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _widthController.forward();
      }
    });

    _widthController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600)
    );

    _widthAnimation = Tween<double>(
      begin: 80.0,
      end: 300.0
    ).animate(_widthController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _positionController.forward();
      }
    });

    _positionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000)
    );

    _positionAnimation = Tween<double>(
      begin: 0.0,
      end: 215.0
    ).animate(_positionController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          hideIcon = true;
        });
        _scale2Controller.forward();
      }
    });

    _scale2Controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300)
    );

    _scale2Animation = Tween<double>(
      begin: 1.0,
      end: 32.0
    ).animate(_scale2Controller)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return new Scaffold(
      body: Stack(
        fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.green[800]),
              child: FadeAnimation(1, Container(
                width: width,
                height: 400,
              
                ),
              )
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: Icon(
                            Icons.local_pharmacy,
                            color: Colors.green[800],
                            size: 50.0,
                          )
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                             FadeAnimation(1, Text("MediRemind",
                          style: TextStyle(
                            color: Colors.white, 
                            fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                          ),
                          
                          ) 
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       Padding(
                         padding: EdgeInsets.only(top: 20.0),
                         ),
                         FadeAnimation(1.3, Text("A reminder you can trust",
                         style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                         ),
                         ),
                      ],
                    )
                  ),
                    Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1.6, AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, child) => Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _widthController,
                        builder: (context, child) => Container(
                          width: _widthAnimation.value,
                          height: 80,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.green[900].withOpacity(.4)
                          ),
                          child: InkWell(
                            onTap: () {
                              _scaleController.forward();
                            },
                            child: Stack(
                              children: <Widget> [
                                AnimatedBuilder(
                                  animation: _positionController,
                                  builder: (context, child) => Positioned(
                                    left: _positionAnimation.value,
                                    child: AnimatedBuilder(
                                      animation: _scale2Controller,
                                      builder: (context, child) => Transform.scale(
                                        scale: _scale2Animation.value,
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green[900]
                                          ),
                                          child: hideIcon == false ? Icon(Icons.arrow_forward, color: Colors.white,) : Container(),
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ),
                      ),
                    )),
                  )),
                  SizedBox(height: 60,),
                ],
              ),
            )
                ],
                )
          ]
          ),
    );
  }
}
