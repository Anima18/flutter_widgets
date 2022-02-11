enum Operator {
  add, reduce
}

class ArithmeticExpression {
  final int a;
  final int b;
  final Operator operator;

  ArithmeticExpression(this.a, this.b, this.operator);
}