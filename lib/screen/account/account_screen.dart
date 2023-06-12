import 'dart:io';

import 'package:cs_global/bloc/auth/bloc_profile.dart';
import 'package:cs_global/bloc/event_bloc.dart';
import 'package:cs_global/config/const.dart';
import 'package:cs_global/model/model_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/choose_image_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        builder: (_, StateBloc state) {
          if(state is LoadSuccess){
            ModelProfile modelProfile=state.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        color: Colors.red,
                        height: Const.size(context).height * 0.25,
                        width: double.infinity,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.2),
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
                        width: double.infinity,
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
                                  showMoney ? '0' : '*******',
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
                     BlocBuilder(builder: (context,XFile? snapshot){
                       return    Container(
                         padding: EdgeInsets.all(2), // Border width
                         decoration: BoxDecoration(
                             color: Colors.red, shape: BoxShape.circle),
                         child: ClipOval(
                           child: SizedBox.fromSize(
                             size: Size.fromRadius(60), // Image radius
                             child: Stack(
                               alignment: Alignment.bottomCenter,
                               children: [
                                 snapshot != null
                                     ? Image.file(
                                   File(snapshot.path),
                                   width: 120,
                                   height: 120,
                                   fit: BoxFit.cover,
                                 ):    LoadImage(
                                   url: 'https://i.imgur.com/k0UTIr6.jpeg',
                                   height: 120,
                                   width: 120,
                                   fit: BoxFit.cover,
                                 ),
                                 InkWell(
                                   onTap: (){
                                     ImagePicker _picker = ImagePicker();
                                     _picker
                                         .pickImage(source: ImageSource.gallery)
                                         .then((value) {

                                       chooseImageBloc.getImage(image: value);
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
                                 )
                               ],
                             ),
                           ),
                         ),
                       );
                     },bloc: chooseImageBloc,),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          modelProfile.profile!.name??'',
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
                                  modelProfile.profile!.code??'',
                                  style: StyleApp.textStyle500(fontSize: 16),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                    onTap: () {
                                      Clipboard.setData(
                                          ClipboardData(text: modelProfile.profile!.name??''))
                                          .then((value) {
                                        //only if ->
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
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
                                    onTap: () {

                                    },
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
                            Row(
                              children: [
                                Text(
                                  '0387159652',
                                  style: StyleApp.textStyle500(fontSize: 16),
                                ),

                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                    onTap: () {

                                    },
                                    child: Icon((FontAwesomeIcons.penToSquare)))
                              ],
                            ),
                            SizedBox(),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Container(width: double.infinity,height: 60,
                          decoration: BoxDecoration(
                              color: ColorApp.grey8B,borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                            child: Row(
                              children: [
                                FaIcon(FontAwesomeIcons.crown,color: ColorApp.yellow,),
                                SizedBox(width: 10,),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        SizedBox(height: 15,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [SizedBox(),
                            InkWell(onTap: (){},child: Text('Kích hoạt hạng tài khoản',style: StyleApp.textStyle500(color: ColorApp.blue00),)),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Container(width: double.infinity,height: 60,
                          decoration: BoxDecoration(
                              color: ColorApp.grey8B,borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                            child: Row(
                              children: [
                                FaIcon(FontAwesomeIcons.crown,color: ColorApp.yellow,),
                                SizedBox(width: 10,),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Người giới thiệu:',style: StyleApp.textStyle500(),),
                                    Text('Diễm Quỳnh',style: StyleApp.textStyle700(),),
                                    Text('C5784781',style: StyleApp.textStyle500(),),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(width: double.infinity,height: 60,
                          decoration: BoxDecoration(
                              color: ColorApp.grey8B,borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                            child: Row(
                              children: [
                                FaIcon(FontAwesomeIcons.crown,color: ColorApp.yellow,),
                                SizedBox(width: 10,),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Ví CS',style: StyleApp.textStyle500(),),
                                    Text('Nguyễn Việt Anh',style: StyleApp.textStyle700(),),
                                    Row(
                                      children: [
                                        Text('Số dư (VNĐ): ',style: StyleApp.textStyle500(),),
                                        Row(
                                          children: [
                                            Text(
                                              showMoney2 ? '0' : '*******',
                                              style: StyleApp.textStyle500(fontSize: 14),
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
                                                child: Icon(showMoney2
                                                    ? CupertinoIcons.eye_slash
                                                    : CupertinoIcons.eye,size: 18,))
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
                        SizedBox(height: 10,),
                        Container(width: double.infinity,height: 60,
                          decoration: BoxDecoration(
                              color: ColorApp.grey8B,borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(

                                  children: [
                                    FaIcon(FontAwesomeIcons.crown,color: ColorApp.yellow,),
                                    SizedBox(width: 10,),
                                    Text('Quy định/quy chế App CS Global',style: StyleApp.textStyle700(fontSize: 16),),

                                  ],
                                ),
                                FaIcon(FontAwesomeIcons.longArrowRight)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(width: double.infinity,height: 60,
                          decoration: BoxDecoration(
                              color: ColorApp.grey8B,borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(

                                  children: [
                                    FaIcon(FontAwesomeIcons.crown,color: ColorApp.yellow,),
                                    SizedBox(width: 10,),
                                    Text('Hỗ trợ khách hàng',style: StyleApp.textStyle700(fontSize: 16),),

                                  ],
                                ),
                                FaIcon(FontAwesomeIcons.longArrowRight)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(width: double.infinity,height: 60,
                          decoration: BoxDecoration(
                              color: ColorApp.grey8B,borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(

                                  children: [
                                    FaIcon(FontAwesomeIcons.crown,color: ColorApp.yellow,),
                                    SizedBox(width: 10,),
                                    Text('Giới thiệu CS Global',style: StyleApp.textStyle700(fontSize: 16),),

                                  ],
                                ),
                                FaIcon(FontAwesomeIcons.longArrowRight)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(width: double.infinity,height: 60,
                          decoration: BoxDecoration(
                              color: Colors.transparent,borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28,vertical: 2),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [


                                Text('Đổi mật khẩu',style: StyleApp.textStyle700(fontSize: 16),),
                                FaIcon(FontAwesomeIcons.key)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(width: double.infinity,height: 60,
                          decoration: BoxDecoration(
                              color: Colors.transparent,borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 28,vertical: 2),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [


                                Text('Đăng xuất',style: StyleApp.textStyle700(fontSize: 16),),
                                FaIcon(FontAwesomeIcons.rightFromBracket)
                              ],
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
          return SizedBox();
        },
        bloc: blocProfile,
      ),
    );
  }
}
