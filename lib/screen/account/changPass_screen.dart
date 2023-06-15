import 'package:flutter/material.dart';

import '../../styles/init_style.dart';

class ChangePassProfile extends StatefulWidget {
  const ChangePassProfile({Key? key}) : super(key: key);

  @override
  State<ChangePassProfile> createState() => _ChangePassProfileState();
}

class _ChangePassProfileState extends State<ChangePassProfile> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.green00,
        title: Text(
          'Đổi mật khẩu',
          style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
