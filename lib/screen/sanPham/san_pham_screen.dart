import 'package:flutter/material.dart';

import '../../styles/init_style.dart';

class SanPhamScreen extends StatefulWidget {
  const SanPhamScreen({Key? key}) : super(key: key);

  @override
  State<SanPhamScreen> createState() => _SanPhamScreenState();
}

class _SanPhamScreenState extends State<SanPhamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      backgroundColor: ColorApp.green00,
      title: Text(
        'Sản phẩm',
        style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
      ),
    ),);
  }
}
