/// A library for generating a random choice from an iterable.
/// Inspired by [numpy.random.choice](https://docs.scipy.org/doc/numpy/reference/generated/numpy.random.choice.html)
library dart_random_choice;

import 'dart:math' show Random;

/// Selects a random element from [options] with optional [weights].
/// 
/// If [weights] is provided, it will be used to select an option
/// according to a weighted distribution. If it is not provided,
/// an option will be selected according to a uniform distribution.
/// 
/// Throws an [ArgumentError] if [options] is empty.
/// Throws an [ArgumentError] if [weights] is non-empty and does not
/// match the length of [options].
/// 
/// ```dart
/// randomChoice(['hi', 'hello'], [0.7, 0.3]) // 70% chance of 'hi', 30% chance of 'hello'
/// randomChoice(['hi', 'hey']) // 'hi' and 'hey' are equally likely. Equivalent to randomChoice(['hi', 'hey'], [1, 1])
/// ```
T randomChoice<T>(Iterable<T> options, [ Iterable<double> weights = const [] ]) {
  if (options.isEmpty) {
    throw ArgumentError.value(options.toString(), 'options', 'must be non-empty');
  }
  if (weights.length != 0 && options.length != weights.length) {
    throw ArgumentError.value(weights.toString(), 'weights', 'must be empty or match length of options');
  }

  if (weights.length == 0) {
    return options.elementAt(Random().nextInt(options.length));
  }

  double sum = weights.reduce((val, curr) => val + curr);
  double randomWeight = Random().nextDouble() * sum;

  int i = 0;
  for (int l = options.length; i < l; i++) {
    randomWeight -= weights.elementAt(i);
    if (randomWeight <= 0) {
      break;
    }
  }

  return options.elementAt(i);
}

