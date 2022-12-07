import 'package:flutter/material.dart';
import 'package:async/async.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  String result = 'no data found';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future test'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  futureTest();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Future test',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                result,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.redAccent,
                ),
              ),
              const Divider(
                height: 20.0,
                thickness: 2.0,
              ),
              FutureBuilder(
                future: _myFuture(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    debugPrint('connect waiting');
                    return CircularProgressIndicator();
                    // return const Text(
                    //   'waiting',
                    //   style: TextStyle(
                    //     fontSize: 20.0,
                    //     color: Colors.amber,
                    //   ),
                    // );
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    debugPrint('connect done');
                    return Text(
                      '${snapshot.data}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.blue,
                      ),
                    );
                  }

                  return const Text('fetching data...');
                  //return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 1.Dart가 await 키워드를 만나면 => Future.delayed 메서드가 끝날 때까지 3초를 기다린다
  // 2. 3초 후 then 메서드가 실행된다.
  // 3. then 메서드 실행이 다 끝나고 그 아래 코드들이 실행된다.
  Future<void> futureTest() async {
    // setState(() {
    //   result = 'no data found';
    //   debugPrint(result);
    //   debugPrint('init');
    // });
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      debugPrint('Here comes second');
      setState(() {
        result = 'The data is fetched';
        debugPrint(result);
        debugPrint('Here comes third');
      });
    });
    debugPrint('Here comes first');
    debugPrint('Here is the last one');
  }

  // UI에 리턴된 String 값을 그려줄 때 FutureBuilder를 사용한다.
  // FutureBuilder의 builder의 snapshot : 특정 시점에 데이터를 복사해서 보관한다.
  // 이 방식은 FutureBuilder에서 함수를 중복 호출한다.
  // StatefulWidgets에서 rebuilder할 때 future을 재실행해서 중복 호출됨.
  // Future<String> myFuture() async {
  //   debugPrint('myFuture start');
  //   await Future.delayed(const Duration(seconds: 2));
  //   debugPrint('myFuture end');
  //   return 'another Future completed';
  // }

  // UI에 리턴된 String 값을 그려줄 때 FutureBuilder를 사용한다.
  // FutureBuilder의 builder의 snapshot : 특정 시점에 데이터를 복사해서 보관한다.
  // 이 방식은 FutureBuilder에서 함수를 중복 호출을 방지한다.
  // asyncMemoizer.runOnce() => stateful 위젯에서 변경이 생겼을 때만 변화가 일어남. (rebuild 방지)
  _myFuture() async {
    return _memoizer.runOnce(() async {
      debugPrint('myFuture start');
      await Future.delayed(const Duration(seconds: 2));
      debugPrint('myFuture end');
      return 'another Future completed';
    });
  }
}
