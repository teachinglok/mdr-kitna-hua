class CalculatorService {
  const CalculatorService();

  double calculate(String expression) {
    final String normalized = _normalizeExpression(expression);

    if (normalized.isEmpty) {
      return 0;
    }

    final List<String> tokens = _tokenize(normalized);

    if (tokens.isEmpty) {
      return 0;
    }

    return _evaluate(tokens);
  }

  String _normalizeExpression(String expression) {
    return expression
        .replaceAll(' ', '')
        .replaceAll('−', '-')
        .replaceAll('×', '*')
        .replaceAll('÷', '/');
  }

  List<String> _tokenize(String expression) {
    final List<String> tokens = [];
    String number = '';

    for (int i = 0; i < expression.length; i++) {
      final String character = expression[i];

      if (_isDigit(character) || character == '.') {
        number += character;
        continue;
      }

      if (_isOperator(character)) {
        if (number.isNotEmpty) {
          tokens.add(number);
          number = '';
        }

        tokens.add(character);
      }
    }

    if (number.isNotEmpty) {
      tokens.add(number);
    }

    return tokens;
  }

  double _evaluate(List<String> tokens) {
    final List<String> working = List<String>.from(tokens);

    _applyPercentage(working);

    _applyOperator(working, '*');
    _applyOperator(working, '/');

    _applyOperator(working, '+');
    _applyOperator(working, '-');

    if (working.length != 1) {
      return 0;
    }

    return double.tryParse(working.first) ?? 0;
  }

  void _applyPercentage(List<String> tokens) {
    int index = 0;

    while (index < tokens.length) {
      if (tokens[index] != '%') {
        index++;
        continue;
      }

      if (index == 0) {
        tokens.removeAt(index);
        continue;
      }

      final double value =
          double.tryParse(tokens[index - 1]) ?? 0;

      final double percentage = value / 100;

      tokens
        ..removeAt(index)
        ..removeAt(index - 1)
        ..insert(index - 1, percentage.toString());

      index = 0;
    }
  }

  void _applyOperator(
      List<String> tokens,
      String operator,
      ) {
    int index = 0;

    while (index < tokens.length) {
      if (tokens[index] != operator) {
        index++;
        continue;
      }

      if (index == 0 || index == tokens.length - 1) {
        return;
      }

      final double left =
          double.tryParse(tokens[index - 1]) ?? 0;

      final double right =
          double.tryParse(tokens[index + 1]) ?? 0;

      double result;

      switch (operator) {
        case '*':
          result = left * right;
          break;

        case '/':
          if (right == 0) {
            result = 0;
          } else {
            result = left / right;
          }
          break;

        case '+':
          result = left + right;
          break;

        case '-':
          result = left - right;
          break;

        default:
          result = 0;
      }

      tokens
        ..removeAt(index - 1)
        ..removeAt(index - 1)
        ..removeAt(index - 1)
        ..insert(index - 1, result.toString());

      index = 0;
    }
  }

  bool _isDigit(String character) {
    return RegExp(r'[0-9]').hasMatch(character);
  }

  bool _isOperator(String character) {
    return '+-*/%'.contains(character);
  }
}