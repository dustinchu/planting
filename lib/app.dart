import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:logger/logger.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login_animation.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with TickerProviderStateMixin, AfterLayoutMixin {
  AnimationController _loginButtonController;
  bool isLoading = false;
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    try {
      setState(() {});
    } catch (e) {
      logger.e("[Login] afterFirstLayout error${e}");
    }
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      logger.e('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      logger.e('[_stopAnimation] error');
    }
  }

  _loginGoogle(context) async {
    await _playAnimation();
    Future.delayed(const Duration(milliseconds: 2000), () {
      _stopAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () => _loginGoogle(context),
              child: Icon(
                FontAwesomeIcons.google,
                color: Colors.red,
                size: 24.0,
              ),
              shape: CircleBorder(),
              elevation: 0.4,
              fillColor: Colors.grey.shade50,
              padding: const EdgeInsets.all(15.0),
            ),
            StaggerAnimation(
              titleButton: "S.of(context).signInWithEmail",
              buttonController: _loginButtonController.view,
              onTap: () {
                if (!isLoading) {
                }
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
