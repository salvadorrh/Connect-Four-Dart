import 'dart:convert';

import 'package:ConnectFour/ConnectFour.dart' as ConnectFour;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  var default2 = 'http://cheon.atwebpages.com/c4/info';
  stdout.write('Enter the server URL [default: $default2] ');
  // var url = stdin.readLineSync();
  // var response = await http.get(Uri.parse(url!));

  var url = stdin.readLineSync();
  if (url == '') {
    url = default2;
  }
  var response = await http.get(Uri.parse(url!));

  // var url = Uri.parse(default2);
  // var response = await http.get(url);

  stdout.write('\nObtaining server information ...\n');
  var info = json.decode(response.body);
  var width = info['width'];
  var height = info['height'];
  var strategy = info['strategies'];

  stdout.write('Width: $width, Height: $height, Strategies: $strategy\n');

  var selectStrategy = 'Select the sever strategy: ';

  for (var i = 0; i < strategy.length; i++) {
    var strategyOption = strategy[i];
    var j = i+1;
    selectStrategy += '$j. $strategyOption  ';
  }
  selectStrategy += '[default: 1]';

  var line;
  var correctStrategy = false;
  var selection;
  var selectedStrategy;
  while (!correctStrategy) {
    try {
      stdout.write(selectStrategy);
      line =  stdin.readLineSync();
      // DEFAULT
      if (line == '') {
        selection = 1;
        selectedStrategy = strategy[0];
        stdout.write('Selected strategy: $selectedStrategy\n');
        break;
      }
      selection = int.parse(line!);
      selection -= 1;
      if (selection >= 0 && selection < strategy.length) {
        selectedStrategy = strategy[selection];
        stdout.write('Selected strategy: $selectedStrategy\n');
        correctStrategy = true;
      }
      else {
        selection += 1;
        stdout.write('Invalid selection: $selection\n');
      }
    } on FormatException {
      stdout.write('\nEnter a number please :)\n');
    }
  }
}
