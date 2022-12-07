void main() {
  int x = 50;
  int? y;
  if (x > 0) {
    y = x;
  }

  // valueName + ! => it means that this value is always not nullable type
  // ! => Exclamation Mark or Bang Mark
  int value = y!;
  print(value);
}