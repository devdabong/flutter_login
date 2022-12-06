import 'package:flutter/material.dart';
import 'package:flutter_login/login_app/login.dart';

// 로고 이미지
// 텍스트
// 버튼 색상
// 버튼 모서리 둥글기
// onPressed 함수
class MyButton extends StatelessWidget {

  MyButton({required this.image, required this.text, required this.color, required this.radius, required this.onPressed});

  final Widget image;
  final Widget text;
  final Color color;
  final double radius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {

    final LogIn logIn = new LogIn();


    return ButtonTheme(
      height: 50.0,
      child: RaisedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            image,
            text,
            Opacity(
              opacity: 0.0,
              child: Image.asset('images/glogo.png'),
            ),
          ],
        ),
        color: color,
        onPressed: onPressed,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
    );
  }
}
