import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Animation 103'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  AnimationController _animationController;
  Animation flip_anim;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    flip_anim = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Center(
              child: InkWell(
                onTap: () {
                  _animationController.repeat();
                },
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.005)
                      ..rotateY(2 * pi * flip_anim.value),
                    alignment: Alignment.center,
                    child: Container(
                      height: 100.0,
                      width: 100.0,
                      color: Colors.green.withOpacity(0.2),
                      child: RotationTransition(
                        turns: flip_anim,
                        child: Center(
                          child: Text(
                            'Flip',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
