import 'dart:io';
import 'dart:math';

class Board {
  final width;
  final height;
  var board;
  var playerOne;
  var playerTwo;
  var moveNumber = 0;

  Board(this.width, this.height) {
    board = List.generate(height, (i) => List.filled(width, '.', growable: false));
  }

  bool isSlotFull(slot) {
    if (board[0][slot] == '.') {
      return false;
    }
    return true;
  }

  void setSlot(slot) {
    var i = height-1;
    var filled = false;
    while (!filled && i  >= 0) {
      if (board[i][slot] == playerOne.token || board[i][slot] == playerTwo.token) {
        i--;
      }
      else {
        board[i][slot] = moveNumber % 2 == 0? playerOne.token : playerTwo.token;
        moveNumber++;
        filled = true;
      }
    }
  }

  bool boardIsFull() {
    for (var i  = 0; i < width; i++) {
      if (!isSlotFull(i)) {
        return false;
      }
    }
    return true;
  }

  void undoSetSlot(slot) {
    var i = 0;
    var filled = false;
    while (!filled && i  <= 0) {
      if (board[i][slot] == '.') {
        i++;
      }
      else {
        board[i][slot] = playerOne.token;
        moveNumber--; /// So that the next setSlot is to the same User
        filled = true;
      }
    }
  }

  int cheapMode() {
    /// Checking if you can win
    for (var i = 0; i < width; i++) {
      if (!isSlotFull(i)) {
        if (isWin(i, playerOne.token)) {
          return i;
        }
      }
    }

    /// Checking if server can win, then block it
    for (var i = 0; i < width; i++) {
      if (!isSlotFull(i)) {
        if (isWin(i, playerTwo.token)) {
          return i;
        }
      }
    }

    /// Checking smart win
    /*var isSmartWin = smartWin();
    if (isSmartWin >= 0) {
      return isSmartWin;
    }*/
    /// Return Random Number if no winning possibility
    var random = Random();
    while (true) {
      var randomNumber = random.nextInt(width);
      if (!isSlotFull(randomNumber)) {
        return randomNumber;
      }
    }
  }

 /* int smartWin() {
    for (var i = 0; i < width; i++) {
      if () {

      }
    }
    return -1;
  }*/

  bool isCellEmpty(i, j) {
    return board[i][j] == '.';
  }

  /// Checks if putting a slot in a specific place is a
  /// win position for the User
  bool isWin(slot, token) {
    setSlot(slot);
    if (checkWinDiagonally(token) || checkWinVertically(token) ||
        checkWinHorizontally(token)) {
      undoSetSlot(slot);
      return true;
    }
    return false;
  }

  bool checkWinDiagonally(token) {
    /// Diagonal left-bottom to right-up '/'
    for (var i = height -1; i >= 3; i--) {
      for (var j = 0; j < width - 3; j++) {
        if (board[i][j] == token && board[i-1][j+1] == token &&
            board[i-2][j+2] == token && board[i-3][j+3] == token) {
          return true;
        }
      }
    }
    /// Diagonal right-bottom to left up '\'
    for (var i = height -1; i >= 3; i--) {
      for (var j = width - 1; j >= 3; j--) {
        if (board[i][j] == token && board[i-1][j-1] == token &&
            board[i-2][j-2] == token && board[i-3][j-3] == token) {
          return true;
        }
      }
    }
    return false;
  }

  bool checkWinVertically(token) {
    for (var i = height -1; i >= 3 ; i--) {
      for (var j = 0; j < width; j++) {
        if (board[i][j] == token && board[i-1][j] == token &&
            board[i-2][j] == token && board[i-3][j] == token) {
          return true;
        }
      }
    }
    return false;
  }

  bool checkWinHorizontally(token) {
    for (var i = height - 1; i >= 0 ; i--) {
      for (var j = width; j >= 3; j--) {
        if (board[i][j] == token && board[i][j-1] == token &&
            board[i][j-2] == token && board[i][j-3] == token) {
          return true;
        }
      }
    }
    return false;
  }
}