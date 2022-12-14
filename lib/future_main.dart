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
  const Home({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.all(30.0),
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

  // 1.Dart??? await ???????????? ????????? => Future.delayed ???????????? ?????? ????????? 3?????? ????????????
  // 2. 3??? ??? then ???????????? ????????????.
  // 3. then ????????? ????????? ??? ????????? ??? ?????? ???????????? ????????????.
  Future<void> futureTest() async {
    setState(() {
      result = 'future delayed will start soon..';
      debugPrint(result);
    });
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

  // UI??? ????????? String ?????? ????????? ??? FutureBuilder??? ????????????.
  // FutureBuilder??? builder??? snapshot : ?????? ????????? ???????????? ???????????? ????????????.
  // ??? ????????? FutureBuilder?????? ????????? ?????? ????????????.
  // StatefulWidgets?????? rebuilder??? ??? future??? ??????????????? ?????? ?????????.
  // Future<String> myFuture() async {
  //   debugPrint('myFuture start');
  //   await Future.delayed(const Duration(seconds: 2));
  //   debugPrint('myFuture end');
  //   return 'another Future completed';
  // }

  // UI??? ????????? String ?????? ????????? ??? FutureBuilder??? ????????????.
  // FutureBuilder??? builder??? snapshot : ?????? ????????? ???????????? ???????????? ????????????.
  // ??? ????????? FutureBuilder?????? ????????? ?????? ????????? ????????????.
  // asyncMemoizer.runOnce() => stateful ???????????? ????????? ????????? ?????? ????????? ?????????. (rebuild ??????)
  _myFuture() async {
    return _memoizer.runOnce(() async {
      debugPrint('myFuture start');
      await Future.delayed(const Duration(seconds: 2));
      debugPrint('myFuture end');
      return 'another Future completed';
    });
  }
}
