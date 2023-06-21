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
      ),
      body: Row(
        children: [
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      decoration: BoxDecoration(border: Border.all()),
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 20,
                ),
              )),
          Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(20, (index) => Column(
                      children: [
                        Row(
                          children: [Text('a'), Text('data'), Text('2')],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [Text('a'), Text('data'), Text('2')],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [Text('a'), Text('data'), Text('2')],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [Text('a'), Text('data'), Text('2')],
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    )),

                  ],
                ),
              ))
        ],
      ),
    );
  }
}
