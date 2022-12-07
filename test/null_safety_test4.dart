void main() {
  print(add(a: null, b: 5));
}

int add({int? a, int? b}) {
  if (a == null || b == null) {
    return 0;
  }

  int sum = a + b;
  return sum;
}

// Success => required로 매개변수 지정을 해줬고, int? a 변수는 nullable로 지정한다.
//            반드시 a의 null check 코드를 넣어준다.
// void main() {
//   print(add(a: null, b: 5));
// }
// int add({required int? a, required int b}) {
//   if (a == null) {
//     return b;
//   }
//
//   int sum = a + b;
//   return sum;
// }

// Error => Because of null safety
// void main() {
//   print(add(a: null, b: 5));
// }
//
// int add({required int a, required int b}) {
//   int sum = a + b;
//   return sum;
// }