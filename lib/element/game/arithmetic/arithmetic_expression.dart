import 'dart:math';

enum Operator { add, reduce }

class OperatorValue {
  static String getValue(Operator operator) {
    switch(operator) {
      case Operator.add:
        return "+";
      case Operator.reduce:
        return "-";
      default:
        throw ArgumentError("运算符参数不正确");
    }
  }
}

class ArithmeticExpression {
  final int a;
  final int b;
  final Operator operator;

  ArithmeticExpression(this.a, this.b, this.operator);
}

class ArithmeticStrategy {
  //计算题目
  final List<ArithmeticExpression> expressions;

  //每条题目的答题时间（秒）
  final int duration;

  //同时出现题目的个数
  final int puzzleCount;

  ArithmeticStrategy(this.expressions, this.duration, this.puzzleCount);
}

class ArithmeticStrategyFactory {
  static ArithmeticStrategy getSimpleAddStrategy() {
    final expressions = List.generate(
        10,
        (index) => ArithmeticExpression(
            Random().nextInt(10), Random().nextInt(10), Operator.add)).toList();
    return ArithmeticStrategy(expressions, 10, 4);
  }

  static ArithmeticStrategy getSimpleReduceStrategy() {
    final expressions = List.generate(
        10,
            (index) => ArithmeticExpression(
            Random().nextInt(10), Random().nextInt(10), Operator.reduce)).toList();
    return ArithmeticStrategy(expressions, 10, 4);
  }

  static ArithmeticStrategy getSimpleAddAndReduceStrategy() {
    final addExpressions = List.generate(
        5,
            (index) => ArithmeticExpression(
            Random().nextInt(10), Random().nextInt(10), Operator.add)).toList();

    final reduceExpressions = List.generate(
        5,
            (index) => ArithmeticExpression(
            Random().nextInt(10), Random().nextInt(10), Operator.reduce)).toList();
    addExpressions.addAll(reduceExpressions);
    addExpressions.shuffle();
    return ArithmeticStrategy(addExpressions, 10, 4);
  }
}
