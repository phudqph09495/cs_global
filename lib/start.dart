import 'package:cs_global/screen/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'bloc/auth/bloc_checkLogin.dart';
import 'bloc/event_bloc.dart';
import 'bloc/state_bloc.dart';
import 'home.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void initialization() {
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initialization();

  }
  @override
  Widget build(BuildContext context) {

    return MyHomePage();
  }
}
