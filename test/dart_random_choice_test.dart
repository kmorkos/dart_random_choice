import 'dart:math';

import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:test/test.dart';

void main() {
  test('Empty options list throws ArgumentError.', () {
    expect(() => randomChoice([]), throwsArgumentError);
  });

  test('Different length weights throws ArgumentError.', () {
    expect(() => randomChoice([1, 2], [1]), throwsArgumentError);
  });

  const numTries = 10000;
  test('Leaving out weights generates according to uniform distribution.', () {
    const numOptions = 4;

    var options = List.generate(numOptions, (i) => i);
    var results = List.generate(numOptions, (_) => 0);

    for (int i = 0; i < numTries; i++) {
      results[randomChoice(options)]++;
    }

    // Hard to test this deterministically. Allow 5% room for error.
    expect(results,
        everyElement(closeTo(numTries / options.length, 0.05 * numTries)));
  });

  test('Including weights generates according to weighted distribution.', () {
    const numOptions = 4;

    var options = List.generate(numOptions, (i) => i);
    var weights = List.generate(numOptions, (_) => Random().nextDouble());
    var results = List.generate(numOptions, (_) => 0);

    for (int i = 0; i < numTries; i++) {
      results[randomChoice(options, weights)]++;
    }

    var totalWeight = weights.reduce((val, curr) => val + curr);
    var expected = List.generate(
        numOptions, (i) => ((weights[i] / totalWeight) * numTries).floor());

    // Hard to test this deterministically. Allow 5% room for error.
    var delta = 0.05 * numTries;
    expect(
        results,
        pairwiseCompare<num, num>(expected,
            (num e, num a) => (e - a).abs() <= delta, 'within 5% error.'));
  });
}
