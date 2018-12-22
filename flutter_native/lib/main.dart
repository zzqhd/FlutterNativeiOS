import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


  /*创建channel -- 发送到原生的方法*/
  static const methodChannel = const MethodChannel('FlutterChannel');
  //向iOS发送请求
  _pushToNative() {
    methodChannel.invokeMethod('iOSFlutter','参数');
  }

  /*接收原生方法*/
  static const eventChannel = const EventChannel('iOSEventChannel');
  _rectiveNativeEvent(Object event) {
    print("接收到iOS发的请求了: $event");
  }
  _onError() {

  }


  @override
  void initState() {
    super.initState();

    eventChannel.receiveBroadcastStream().listen(_rectiveNativeEvent,onError: _onError());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterNative交互"),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushToNative,
        tooltip: 'tooltip',
        child: Icon(Icons.add),
      ),
    );
  }
}
