import 'package:flutter/material.dart';

class Person {
  String? name;

  String nameChange(String? name) {
    this.name = name;

    if (name == null) {
      return 'need a name!';
    }
    return name.toUpperCase();
  }
}

void main() {
  Person p = Person();
  debugPrint(p.nameChange(p.name));
}