import 'dart:io';
import 'console_ui.dart';
import 'web_client.dart';
import 'board.dart';
import 'player.dart';

/// Controls C4
class Controller {
  /// Called from Main, starts the Connect Four Application
  start() async {
    var ui = ConsoleUI();
    ui.welcome();
    var url; var web; var info;
    var maxTries = 5; /// User has 5 chances max to enter a valid URL
    /// Loop until correct URL provided
    while (maxTries > 0) {
      url = ui.promptForServer();
      web = WebClient();
      web.setServerUrl(url);
      stdout.write('$url\n');
      ui.showMessage('Connecting to the server...\n');
      try {
        info = await web.getInfo();
        break;
      } on Error {
        ui.invalidServer(maxTries-1);
        maxTries--;
      }
    }
    if (maxTries == 0) {
      ui.showMessage('\nReached maximum number of tries :(\n');
      ui.showMessage('Finishing Connect Four :(');
      return;
    }
    /// Prompts to select a Strategy
    var selectedStrategy = ui.promptForStrategy(info.strategies);
    ui.enterGame();
    var newInfo;
    try {
      newInfo = await web.getNewInfo(selectedStrategy);
    } on Error{
      ui.errorInServer();
      return;
    }
    /// Setting new board with two players
    var playerUser = Player('X');
    var playerServer = Player('O');
    var board = Board(info.width, info.height)
      ..playerOne = playerUser
      ..playerTwo = playerServer;
    ui.setBoard(board);
    url += '/play/?pid=' + newInfo.get_pid + '&move=';
    /// Loop of game
    var statusGame = 'Continue';
    while (statusGame == 'Continue') {
      statusGame = await ui.promptForSlot(url);
    }
    /// Ends game by checking who wins ('Win', 'Loose', 'Draw')
    ui.endGame(statusGame);
  }
}