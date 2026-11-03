extension QuantityFormat on num {
  String toQuantityString() => this % 1 == 0 ? toInt().toString() : toString();
}