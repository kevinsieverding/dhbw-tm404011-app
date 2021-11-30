class Problem {
  final int operand1;
  final int operand2;
  final int result;

  Problem(this.operand1, this.operand2) : result = operand1 * operand2;
  Problem.withResult(this.operand1, this.operand2, this.result);

  bool isValid() {
    return operand1 * operand2 == result;
  }

  @override
  String toString() {
    return '$operand1 x $operand2 = $result';
  }
}
