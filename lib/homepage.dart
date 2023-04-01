import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pong_flutter_game/coverscreen.dart';
import 'brick.dart';
import 'ball.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key:key);

  @override
 _HomePageState createState() => _HomePageState();
}

enum direction{ UP, DOWN}

class _HomePageState extends State<HomePage> {
  // Ball variables
  double ballX = 0;
  double ballY = 0;

  //initial direcion of the ball is downwards
  var ballDirection = direction.DOWN;

  //Game settings
  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      //update direction
      updateDirection();

      //move ball
      moveBall();

    });
  }

  void updateDirection(){
    if(ballY >= 0.9){
      ballDirection = direction.UP;
    } else if(ballY <= -0.9) {
      ballDirection = direction.DOWN;
    }
  }

  void moveBall(){
    if(ballDirection == direction.DOWN){
      ballY += 0.01;
    }else if(ballDirection == direction.UP){
      ballY -= 0.01;
    }
  }


  @override
  Widget build(BuildContext context) {
   
      return GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          body: Center(
            child: Stack(
            children: [
              //tap to play
              CoverScreen(
                gameHasStarted: gameHasStarted
              ),
              // top brick
              MyBrick( x: 0, y: -0.9),
              // bottom brick
              MyBrick( x: 0, y: 0.9),

              //ball
              MyBall(
                x: ballX,
                y: ballY,
              )
            
            ]
          ),
        ),
      )
    );
  }
    
  }

