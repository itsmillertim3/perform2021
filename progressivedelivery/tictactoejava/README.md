# TicTacToe AI Project [![HitCount](http://hits.dwyl.io/ramanshsharma2806/TicTacToe.svg)](http://hits.dwyl.io/ramanshsharma2806/TicTacToe)

This is a Tic Tac Toe console game made with Java. I have given my own touch to the console game with a unique (yet simple) board. 

## Update
I made small changes to the code so that the program will not crash if inappropriate data types are passed as inputs. It will merely notify the user. This makes the game even more appealing as a console-game.

## Methodology
I used a minimax algorithm to construct the basis of this game. My friend and I referred to basic minimax structure from online sources when writing this code. Therefore there are a few cases in which the computer player still does not make the right choice. It will be fixed in further updates. 

## Comments appreciated!
If you have a suggestion or comment, please send me an email at sharmar@bxscience.edu ! Thank you.

## To Run It

java TicTacToeAI.java

## To Run It with Dynatrace Release Management

**Caution** If you run this as part of HOTDAY and have previously set DT_TENANT env variable its time to clear that to avoid any conflict.

```console
export DT_TENANT=
export DT_APPLICATION_RELEASE_VERSION=1
export DT_APPLICATION_NAME=tictactoe
export DT_APPLICATION_ENVIRONMENT=gameenvironment
java TicTacToeAI
```