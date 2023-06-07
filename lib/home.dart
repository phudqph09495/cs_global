import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:url_launcher/url_launcher.dart';



import '../bloc/event_bloc.dart';
import '../bloc/state_bloc.dart';
import '../styles/init_style.dart';
import '../widget/app_bar.dart';
import 'bloc/auth/bloc_checkLogin.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _launchURL(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Đã có lỗi , vui lòng quay lại sau';
    }
  }


  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BlocCheckLogin>().add(GetData());
    // context.read<BlocFireBaseMS>().add(firebase());

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<BlocCheckLogin, StateBloc>(
        builder: (context, StateBloc state) {
          final check = state is LoadSuccess ? state.data as bool : false;
          return IndexedStack(
            index: index,
            children: [
              // HomeScreen(),
Container(color: Colors.red,),
              Container()

              // LoveScreen(),
              // check ? LoggedScreen() : NoLogScreen()
              // AccountScreen()
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 23,
        items: [
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Icon(Icons.home_outlined),
              ), label: "HOME"),


          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded), label: "TÀI KHOẢN"),
          // BottomNavigationBarItem(
          //     icon:ImageIcon(AssetImage(ImagePath.bottomBarAccount)), label: "Tài khoản"),
        ],
        onTap: (val) {
          index = val;
          setState(() {});
          // if(index==1){
          //   _launchURL(Uri.parse('https://www.messenger.com/t/khohangnhat.vn'));
          //
          // }
        },
        backgroundColor: Colors.white,
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorApp.red,
        selectedLabelStyle:
        StyleApp.textStyle400(color: ColorApp.red, fontSize: 12),
        unselectedItemColor: ColorApp.black,
        unselectedLabelStyle:
        StyleApp.textStyle400(color: ColorApp.black, fontSize: 12),
      ),
    );
  }
}
