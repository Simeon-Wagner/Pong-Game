import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_flutter_game/coverscreen.dart';
import 'package:pong_flutter_game/scorescreen.dart';
import 'brick.dart';
import 'ball.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key:key);

  @override
 _HomePageState createState() => _HomePageState();
}

enum direction{ UP, DOWN, LEFT, RIGHT}

const Color primaryMenuColor = Colors.teal;
Color? secondaryMenuColor = Colors.teal[50];

class _HomePageState extends State<HomePage> {

  double brickRelHeight = 0;
  // Ball variables
  double ballX = 0;
  double ballY = 0;



  double brickWidth = 0.4;

  double playerX = 0;
  int playerScore = 0;
  

  double enemyX = 0;
  int enemyScore = 0;

  //initial direcion of the ball is downwards
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  //Game settings
  bool gameHasStarted = false;

  void startGame() {
    //check if game is already running
    if(gameHasStarted){
      return;
    }

    setState(() {
      gameHasStarted = true;
    });
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      //update direction
      updateDirection();
     //move ball
      moveBall();

      moveEnemy();
      //
      if(isPlayerDead()){
        enemyScore++;
        timer.cancel();
        _showDialog();
      }
      if(isEnemyDead()){
        playerScore++;
        timer.cancel();
        _showDialog();
      }

    });
  }

  void resetGame(){
    Navigator.pop(context, true);
    setState(() {
      gameHasStarted = false;
      ballX = 0;
      ballY = 0;
      playerX = -0.2;
      enemyX = -0.2;
      playerScore = 0;
    });
  }

  
  void updateDirection(){
    /*
    if(ballY >= (0.9-brickRelWidth) && ballX >= playerX && ballX <= playerX + brickWidth){
      ballYDirection = direction.UP;
    } 
    */
    if(ballY >= (0.9-brickRelHeight) && ballX >= playerX && ballX <= (playerX+brickWidth/3)) {
      ballYDirection = direction.UP;
      ballXDirection = direction.LEFT;
      playerScore++;
    } else if(ballY >= (0.9-brickRelHeight) && ballX > (playerX+brickWidth/3) && ballX <= (playerX+brickWidth*2/3)) {
      ballYDirection = direction.UP;
      playerScore++;
    } else if(ballY >= (0.9-brickRelHeight) && ballX > (playerX+brickWidth*2/3) && ballX <= (playerX+brickWidth)) {
      ballYDirection = direction.UP;
      ballXDirection = direction.RIGHT;
      playerScore++;
    } 
    
    
    else if(ballY <= (-0.9+brickRelHeight) && ballX >= enemyX && ballX <= (enemyX+brickWidth/3)) {
      ballYDirection = direction.DOWN;
      ballXDirection = direction.LEFT;
    } else if(ballY <= (-0.9+brickRelHeight) && ballX > (enemyX+brickWidth/3) && ballX <= (enemyX+brickWidth*2/3)) {
      ballYDirection = direction.DOWN;
    } else if(ballY <= (-0.9+brickRelHeight) && ballX > (enemyX+brickWidth*2/3) && ballX <= (enemyX+brickWidth)) {
      ballYDirection = direction.DOWN;
      ballXDirection = direction.RIGHT;
    }

    if(ballX >= 1){
      ballXDirection = direction.LEFT;
    } else if(ballX <= -1) {
      ballXDirection = direction.RIGHT;
    }
  }

  void moveBall(){
    setState(() {
      if(ballYDirection == direction.DOWN){
        ballY += 0.01;
      }else if(ballYDirection == direction.UP){
        ballY -= 0.01;
      }

      if(ballXDirection == direction.RIGHT){
        ballX += 0.007;
      }else if(ballXDirection == direction.LEFT){
        ballX -= 0.007;
      } 
    });
  }

  void moveLeft(){
    setState(() {
      playerX -= 0.1;
      if(playerX < -1){
        playerX = -1;
      }
    });
  }

  void moveRight(){
    setState(() {
      playerX += 0.1;
      if(playerX + brickWidth > 1) {
        playerX = 1 - brickWidth;
      }
    });
  }

  void moveEnemy(){
    enemyX = ballX-0.2;
  }

  bool isPlayerDead(){
    if(ballY >=1){
      return true;
    } else {
      return false;
    }
  }

  bool isEnemyDead(){
      if(ballY <=-1){
        return true;
      } else {
        return false;
      }
    }

  void _showDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: secondaryMenuColor,
            title: const Center(
                child:Text(
                  "You have lost!",
                  style: TextStyle(color: primaryMenuColor),
                )
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child:Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(7),
                    color: primaryMenuColor,
                    child: const Text(
                      "Play Again",
                        style: TextStyle(
                          color: Colors.white,
                        )
                    ),
                  )
                )
              )
            ],
          );
        });
  }
  
  @override
  Widget build(BuildContext context) {
    //Getting the width relative to the screen size
    brickRelHeight = (20 / MediaQuery.of(context).size.height)*2;
    

      return RawKeyboardListener(
        focusNode:FocusNode(),
        autofocus:true,
        onKey: (event) {
          if(event.isKeyPressed(LogicalKeyboardKey.arrowLeft)){
            moveLeft();
          } else if(event.isKeyPressed(LogicalKeyboardKey.arrowRight)){
            moveRight();
          }
        },

        child: GestureDetector(
          onTap: startGame,
          child: Scaffold(
            backgroundColor: Colors.grey[900],
            body: Center(
              child: Stack(
              children: [
                //tap to play
                CoverScreen(
                  gameHasStarted: gameHasStarted,
                  
                ),

                //score Screen
                ScoreScreen(
                  gameHasStarted: gameHasStarted,
                  enemyScore: enemyScore,
                  playerScore: playerScore,
                ),
                // top brick (enemy)
                MyBrick( x: enemyX, y: -0.9, width: brickWidth, thisIsPlayer: false,),
                // bottom brick (Player)
                MyBrick( x: playerX, y: 0.9, width: brickWidth, thisIsPlayer: true,),

                //ball
                MyBall(
                  x: ballX,
                  y: ballY,
                ),
                ]
              ),
            ),
          )
        )
      );
  }


  }

