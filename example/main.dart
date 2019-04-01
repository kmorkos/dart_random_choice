import 'dart:math' show Point;
import 'package:dart_random_choice/dart_random_choice.dart';

void main() {
  const List<String> foodOptions = ['burger', 'pizza', 'salad'];
  const List<double> weights = [10, 20, 0.4];
  String whatToEat = randomChoice<String>(foodOptions, weights);
  // I probably won't be eating a salad...
  print('You should eat a $whatToEat.');


  Set<Point> cardinalDirections = {
    Point(0, 1), Point(0, -1),
    Point(1, 0), Point(-1, 0),
  };
  Point direction = randomChoice<Point>(cardinalDirections);
  // Each direction is equally likely.
  print('Move to $direction.');


  Runes alphabet = Runes('abcdefghijklmnopqrstuvwxyz');
  int charCode = randomChoice<int>(alphabet);
  String char = String.fromCharCode(charCode);
  // Any iterable works!
  print('$char is my favorite letter.');
}

