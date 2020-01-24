import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget{
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin{
  Animation<double> catAnimation;
  AnimationController catAnimationController;

  initState(){
    super.initState();   

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
      catAnimationController.reverse();
    }else if(catAnimationController.status == AnimationStatus.dismissed){
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
      child: Transform.rotate(
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        angle: pi * 0.6,
        alignment: Alignment.topLeft,
      ),
    );
  }
}