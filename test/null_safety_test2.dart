import 'package:flutter/material.dart';

// late => class 내의 인스턴스의 값을 잠시후에 초기화하고 싶을 때 사용.
class Person {
  late int age;

  int sum(int age, int num) {
    this.age = age;
    int total = age + num;
    return total + age;
  }
}

void main() {
  Person p = Person();
  print(p.sum(100, 50));
}