import 'package:cs_global/screen/account/account_screen.dart';
import 'package:cs_global/screen/donhang/quanly_screen.dart';
import 'package:cs_global/screen/home/home_screen.dart';
import 'package:cs_global/screen/sanPham/san_pham_screen.dart';
import 'package:cs_global/widget/loadPage/item_loadfaild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:url_launcher/url_launcher.dart';



import '../bloc/event_bloc.dart';
import '../bloc/state_bloc.dart';
import '../styles/init_style.dart';
import '../widget/app_bar.dart';
import 'bloc/auth/bloc_checkLogin.dart';
import 'bloc/auth/bloc_profile.dart';


class MyHomePage extends StatefulWidget {
  int index;
  MyHomePage({this.index=0});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initialization() {
    FlutterNativeSplash.remove();
  }
  _launchURL(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Đã có lỗi , vui lòng quay lại sau';
    }
  }





@override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: IndexedStack(
        index: widget.index,
        children: [
          // HomeScreen(),
          HomeScreen(),
          SanPhamScreen(),
          QuanLyScreen(),
          AccountScreen(),

          // LoveScreen(),
          // check ? LoggedScreen() : NoLogScreen()
          // AccountScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 23,
        items:  [
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 3),
                child: Image.asset('assets/images/trangchu.png',height: 25,width: 25,color: widget.index==0?ColorApp.green:ColorApp.black,),
              ), label: "TRANG CHỦ"),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 3),
                child: SvgPicture.asset('assets/svg/product.svg',color: widget.index==1?ColorApp.green:ColorApp.black,),
              ), label: "SẢN PHẨM"),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 3),
                child: SvgPicture.asset('assets/svg/donHang.svg',color: widget.index==2?ColorApp.green:ColorApp.black,),
              ), label: "ĐƠN HÀNG"),


          BottomNavigationBarItem(
              icon: Image.asset('assets/images/taikhoan.png',height: 25,width: 25,color: widget.index==3?ColorApp.green:ColorApp.black,), label: "TÀI KHOẢN",),
          // BottomNavigationBarItem(
          //     icon:ImageIcon(AssetImage(ImagePath.bottomBarAccount)), label: "Tài khoản"),
        ],
        onTap: (val) {
          widget.index = val;
          setState(() {});
          // if(index==1){
          //   _launchURL(Uri.parse('https://www.messenger.com/t/khohangnhat.vn'));
          //
          // }
        },
        backgroundColor: Colors.white,
        currentIndex: widget.index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorApp.green,
        selectedLabelStyle:
        StyleApp.textStyle400(color: ColorApp.red, fontSize: 12),
        unselectedItemColor: ColorApp.black,
        unselectedLabelStyle:
        StyleApp.textStyle400(color: ColorApp.black, fontSize: 12),
      ),
    );
  }
}
