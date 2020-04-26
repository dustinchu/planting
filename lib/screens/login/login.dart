import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/common/login_animation.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
    with TickerProviderStateMixin, AfterLayoutMixin {
  AnimationController _loginButtonController;
  bool isLoading = false;

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
      print("[Login] afterFirstLayout error${e}");
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
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
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
    );
  }
}
