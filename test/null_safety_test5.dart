
//lazy initialization => 변수의 초기화가 필요에 따라 천천히 실행됨.
class Person {
  // late => calculation() 이 실행되지 않고, age 변수가 처음으로 참조될 때 실행됨.
  late int age = calculation();

  void printAge() {
    print('age');
  }
}

int calculation() {
  print('calculate');
  return 30;
}

void main() {
  Person p = Person();
  p.printAge();
  print(p.age);
}


// late 키워드를 사용하지 않았을 때 => main 메서드에서 Person 클래스의 인스턴스를 생성할 때
//                                동시에 Person 내 calculation 메서드도 실행됨.
// class Person {
//   int age = calculation();
//
//   void printAge() {
//     print('age');
//   }
// }
//
// int calculation() {
//   print('calculate');
//   return 30;
// }
//
// void main() {
//   Person p = Person();
//   p.printAge();
//   print(p.age);
// }