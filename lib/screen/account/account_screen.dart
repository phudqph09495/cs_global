import 'dart:convert';
import 'dart:io';

import 'package:cs_global/bloc/auth/bloc_profile.dart';
import 'package:cs_global/bloc/check_log_state.dart';
import 'package:cs_global/bloc/event_bloc.dart';
import 'package:cs_global/config/const.dart';
import 'package:cs_global/model/model_profile.dart';
import 'package:cs_global/screen/account/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/auth/bloc_updateProfile.dart';
import '../../bloc/choose_image_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../config/path/share_pref_path.dart';
import '../../start.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';
import 'changPass_screen.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

import 'gioithieu_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool showMoney = true;
  bool showMoney2 = true;
  BlocProfile blocProfile = BlocProfile()..add(GetData());
  ChooseImageBloc chooseImageBloc = ChooseImageBloc();
  BlocUpdateProfile blocUpdateProfile = BlocUpdateProfile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        builder: (_, StateBloc state) {
          if (state is LoadSuccess) {
            ModelProfile modelProfile = state.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: Const.size(context).height * 0.25,
                        width: double.infinity,
                        child: LoadImage(
                          url:
                              '${Const.image_host}${modelProfile.profile!.banner}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>GioiThieuScreen()));
                        },
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Row(
                                  children: [
                                    Text(
                                      'Giới thiệu bạn bè  ',
                                      style: StyleApp.textStyle500(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    Icon(
                                      Icons.info_rounded,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.account_balance_wallet_outlined),
                                Text(
                                  ' Số dư ví (VNĐ) : ',
                                  style: StyleApp.textStyle500(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  showMoney
                                      ? '${Const.ConvertPrice.format(int.parse('${modelProfile.profile!.balance}'))}'
                                      : '*******',
                                  style: StyleApp.textStyle500(fontSize: 16),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        showMoney = !showMoney;
                                      });
                                    },
                                    child: Icon(showMoney
                                        ? CupertinoIcons.eye_slash
                                        : CupertinoIcons.eye))
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(2), // Border width
                          decoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(60), // Image radius
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  LoadImage(
                                    url:
                                        '${Const.image_host}${modelProfile.profile!.avatar}',
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  BlocListener(
                                    bloc: blocUpdateProfile,
                                    listener: (_, StateBloc state) {
                                      CheckLogState.check(context,
                                          state: state,
                                          isShowMsg: false, success: () {
                                        blocProfile.add(GetData());
                                      });
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        ImagePicker _picker = ImagePicker();
                                        _picker
                                            .pickImage(
                                                source: ImageSource.gallery)
                                            .then((value) {
                                          if (value != null) {
                                            final bytes = File(value.path)
                                                .readAsBytesSync();
                                            String avatar =
                                                "data:image/png;base64," +
                                                    base64Encode(bytes);
                                            blocUpdateProfile.add(UpdateProfile(
                                                name:
                                                    modelProfile.profile!.name,
                                                email:
                                                    modelProfile.profile!.email,
                                                address: modelProfile
                                                    .profile!.address,
                                                avatar: avatar));
                                          }
                                        });
                                      },
                                      child: Container(
                                          height: 20,
                                          width: double.infinity,
                                          color: Colors.white.withOpacity(0.5),
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: ColorApp.dark500,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          modelProfile.profile!.name ?? '',
                          style: StyleApp.textStyle600(fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Row(
                              children: [
                                Text(
                                  'ID khách hàng: ',
                                  style: StyleApp.textStyle500(fontSize: 16),
                                ),
                                Text(
                                  modelProfile.profile!.code ?? '',
                                  style: StyleApp.textStyle500(fontSize: 16),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                              text:
                                                  modelProfile.profile!.code ??
                                                      ''))
                                          .then((value) {
                                        //only if ->
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Đã copy '))); // -> show a notification
                                      });
                                    },
                                    child: Icon((Icons.copy)))
                              ],
                            ),
                            SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Row(
                              children: [
                                Text(
                                  'Cập nhật Sologan ',
                                  style: StyleApp.textStyle500(fontSize: 16),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: Icon((FontAwesomeIcons.penToSquare)))
                              ],
                            ),
                            SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Text(
                              modelProfile.profile!.phone ?? '',
                              style: StyleApp.textStyle500(fontSize: 16),
                            ),
                            SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              color: ColorApp.greyE6,
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Row(
                              children: [
                                Image.asset('assets/images/rank.png'),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Hạng tài khoản'),
                                    Text('Hạng: Vàng')
                                  ],
                                ),
                                SizedBox()
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            InkWell(
                                onTap: () {},
                                child: Text(
                                  'Kích hoạt hạng tài khoản',
                                  style: StyleApp.textStyle500(
                                      color: ColorApp.blue00),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              color: ColorApp.greyE6,
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Row(
                              children: [
                                Image.asset('assets/images/meeting.png'),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Người giới thiệu:',
                                      style: StyleApp.textStyle500(),
                                    ),
                                    Text(
                                      'Diễm Quỳnh',
                                      style: StyleApp.textStyle700(),
                                    ),
                                    Text(
                                      'C5784781',
                                      style: StyleApp.textStyle500(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              color: ColorApp.greyE6,
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Row(
                              children: [
                                Image.asset('assets/images/vi.png'),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ví CS',
                                      style: StyleApp.textStyle500(),
                                    ),
                                    Text(
                                      modelProfile.profile!.name ?? '',
                                      style: StyleApp.textStyle700(),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Số dư (VNĐ): ',
                                          style: StyleApp.textStyle500(),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              showMoney2
                                                  ? '${Const.formatPrice(modelProfile.profile!.balance)}'
                                                  : '*******',
                                              style: StyleApp.textStyle500(
                                                  fontSize: 14),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    showMoney2 = !showMoney2;
                                                  });
                                                },
                                                child: Icon(
                                                  showMoney2
                                                      ? CupertinoIcons.eye_slash
                                                      : CupertinoIcons.eye,
                                                  size: 18,
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox()
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen()))
                                .then((value) => blocProfile.add(GetData()));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                                color: ColorApp.greyE6,
                                borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.person,
                                        color: ColorApp.yellow,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Thông tin tài khoản',
                                        style:
                                            StyleApp.textStyle700(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  FaIcon(FontAwesomeIcons.longArrowRight)
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              color: ColorApp.greyE6,
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/quydinh.png'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Quy định App CS Global',
                                      style:
                                          StyleApp.textStyle700(fontSize: 16),
                                    ),
                                  ],
                                ),
                                FaIcon(FontAwesomeIcons.longArrowRight)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              color: ColorApp.greyE6,
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/htkh.png'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Hỗ trợ khách hàng',
                                      style:
                                          StyleApp.textStyle700(fontSize: 16),
                                    ),
                                  ],
                                ),
                                FaIcon(FontAwesomeIcons.longArrowRight)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                              color: ColorApp.greyE6,
                              borderRadius: BorderRadius.circular(40)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/splash.png'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Giới thiệu CS Global',
                                      style:
                                          StyleApp.textStyle700(fontSize: 16),
                                    ),
                                  ],
                                ),
                                FaIcon(FontAwesomeIcons.longArrowRight)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChangePassProfile()));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Đổi mật khẩu',
                                    style: StyleApp.textStyle700(fontSize: 16),
                                  ),
                                  FaIcon(FontAwesomeIcons.key)
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                                  ),
                                  backgroundColor: ColorApp.whiteF7,
                                  actionsPadding: EdgeInsets.only(bottom: 10),
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      scrollable: true,
                                      content: Container(
                                          width: Const.sizeWidth(context, 370),
                                          height: Const.sizeHeight(context, 50),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Bạn muốn đăng xuất',
                                              style: StyleApp.textStyle500(),
                                            ),
                                          )),
                                      actions: [
                                        InkWell(
                                          onTap: ()async{
                                           await SharePrefsKeys.removeAllKey();
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>StartScreen())).then((value) {

                                             FlutterExitApp.exitApp(iosForceExit: true);
                                           });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                                color: ColorApp.redText),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Đồng ý',
                                                style: StyleApp.textStyle500(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12),
                                                color: ColorApp.redText),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Huỷ bỏ',
                                                style: StyleApp.textStyle500(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(40)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Đăng xuất',
                                    style: StyleApp.textStyle700(fontSize: 16),
                                  ),
                                  FaIcon(FontAwesomeIcons.rightFromBracket)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is LoadFail) {
            return ItemLoadFaild(
              error: state.error,
              titleButton: 'Đăng nhập lại',
              onTap: () async {
                await SharePrefsKeys.removeAllKey();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StartScreen()));
              },
            );
          }
          return SizedBox();
        },
        bloc: blocProfile,
      ),
    );
  }
}
