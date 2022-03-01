# Connect-Four-Dart
Implementation of a Connect Four game, programmed in the Programming Language Dart

This is a console-based application for playing Connect Four using a specific Web service. Object-Oriented programming is being used, separating functionalities from I/O (represented in the console_ui file), getting information from the Web Service (web_client file) and representing information in classes like Player and Info.

There is a class called Board, that will represent the actual board of the game as well as having special functions to let the player know if there is an open slot or if the game has ended due to a win, draw or a loss. This program checks for a win, by checking rows, columns, and diagonals.
