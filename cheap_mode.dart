/// Implements cheap mode. Checks vertically, horizontally and diagonally for win
import 'board.dart';
class CheapMode {
  Board? board;
  void setBoard(Board board) => this.board = board;

  static int getCheapModeSlot() {
    return 1;
  }

  /*int winVertical() {
    for (var i = 0; i < board!.width; i++) {
      for (var j = board!.height; j > 2; j--) {
        if (board!.playerOne.token)
      }
    }
    return 1;
  }*/

  int winHorizontal() {
    return 1;
  }

  int blockWinVertical() {
    return 1;
  }

  int blockWinHorizontal() {
    return 1;
  }
}