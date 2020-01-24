import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget{
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin{
  Animation<double> catAnimation;
  AnimationController catAnimationController;
  Animation<double> boxAnimaton;
  AnimationController boxAnimationController;

  initState(){
    super.initState();  

    boxAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    boxAnimaton = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: boxAnimationController,
        curve: Curves.easeInOut,
      )
    ); 
    boxAnimationController.addStatusListener((status){
      if(status == AnimationStatus.completed){
        boxAnimationController.repeat();
      }else if(status == AnimationStatus.dismissed){
        boxAnimationController.forward();
      }
    });
    boxAnimationController.forward();

    catAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    catAnimation = Tween(begin: -80.0, end: -140.0).animate(
      CurvedAnimation(
        parent: catAnimationController,
        curve : Curves.easeIn,
      )
    );
  }

  onTap(){

    if(catAnimationController.status == AnimationStatus.completed){
      boxAnimationController.forward();
      catAnimationController.reverse();
    }else if(catAnimationController.status == AnimationStatus.dismissed){
      boxAnimationController.stop();
      catAnimationController.forward();
    }
  }

  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap()
            ],
          ),  
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation(){
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child){
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox(){
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap(){

    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
      animation: boxAnimaton,
        child: Container(
                height: 10.0,
                width: 125.0,
                color: Colors.brown,
              ),
        builder: (context, child){
          return Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle: boxAnimaton.value,
          );
        },
      )
    );
  }

  Widget buildRightFlap(){

    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimaton,
        child: Container(
                height: 10.0,
                width: 125.0,
                color: Colors.brown,
              ),
        builder: (context, child){
          return Transform.rotate(
            child: child,
            alignment: Alignment.topRight,
            angle: -boxAnimaton.value,
          );
        },
      )
    );
  }
}