import 'dart:convert';
import 'dart:io';

import 'package:cs_global/bloc/check_log_state.dart';
import 'package:cs_global/widget/item/input/text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/auth/bloc_updateProfile.dart';
import '../../bloc/choose_image_bloc.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../model/model_profile.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  BlocProfile blocProfile = BlocProfile()..add(GetData());
  ChooseImageBloc chooseImageBloc = ChooseImageBloc();
  ChooseImageBloc chooseImageBloc2 = ChooseImageBloc();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
String avatar='';
String banner='';
  BlocUpdateProfile blocUpdateProfile=BlocUpdateProfile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener(
          bloc: blocUpdateProfile,
          listener: (_,StateBloc state) {
            CheckLogState.check(context, state: state,msg: 'Cập nhật thành công',
            success: (){
              blocProfile.add(GetData());
            });
          },
          child: InkWell(
            onTap: (){
              blocUpdateProfile.add(UpdateProfile(
name: name.text,
                email: email.text,
                address: address.text,
                avatar: avatar,
                banner: banner
              ));
            },
            child: Container(width: double.infinity,
              decoration: BoxDecoration(color: ColorApp.green00,borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('CẬP NHẬT',style: StyleApp.textStyle600(color: Colors.white,fontSize: 16),textAlign: TextAlign.center,),
              ),
            ),
          ),
        ),
      ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorApp.green00,
          title: Text(
            'Thông tin cá nhân',
            style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
          ),
        ),
        body: BlocBuilder(
          builder: (_, StateBloc state) {
            if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorApp.main,
                ),
              );
            }
            if (state is LoadFail) {
              return ItemLoadFaild(
                error: state.error,
                onTap: () {
                  blocProfile.add(GetData());
                },
              );
            }
            if (state is LoadSuccess) {
              ModelProfile modelProfile = state.data;


              name.text = modelProfile.profile!.name ?? '';
              email.text = modelProfile.profile!.email ?? '';
              address.text = modelProfile.profile!.address ?? '';
              phone.text = modelProfile.profile!.phone ?? '';
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(alignment: Alignment.bottomCenter, children: <
                          Widget>[
                        Stack(
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                height:
                                    MediaQuery.of(context).size.width * 0.51,
                                child: BlocBuilder(
                                  builder: (context, XFile? snapshot) {
                                    return snapshot != null
                                        ? Image.file(
                                            File(snapshot.path),
                                            fit: BoxFit.fitWidth,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.38,
                                          )
                                        : LoadImage(
                                            url:
                                                '${Const.image_host}${modelProfile.profile!.banner}',
                                            fit: BoxFit.fitWidth,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.38,
                                          );
                                  },
                                  bloc: chooseImageBloc2,
                                )),
                            Positioned(
                                top: 10,
                                right: 10,
                                child: InkWell(
                                    child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorApp.orangeF0),
                                            shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          size: 16,
                                        )),
                                    onTap: () {
                                      ImagePicker _picker = ImagePicker();
                                      _picker
                                          .pickImage(
                                          source: ImageSource.gallery)
                                          .then((value) {
                                        if(value!=null){
                                          final bytes = File(value.path).readAsBytesSync();
                                          banner = "data:image/png;base64," + base64Encode(bytes);
                                        }
                                        chooseImageBloc2.getImage(
                                            image: value);
                                      });
                                    })),
                          ],
                        ),
                        BlocBuilder(
                          builder: (context, XFile? snapshot) {
                            return Container(
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
                                            )
                                          : LoadImage(
                                              url:
                                              '${Const.image_host}${modelProfile.profile!.avatar}',
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover,
                                            ),
                                      InkWell(
                                        onTap: () {
                                          ImagePicker _picker = ImagePicker();
                                          _picker
                                              .pickImage(
                                                  source: ImageSource.gallery)
                                              .then((value) {
                                            if(value!=null){
                                              final bytes = File(value.path).readAsBytesSync();
                                              avatar = "data:image/png;base64," + base64Encode(bytes);
                                            }

                                            chooseImageBloc.getImage(
                                                image: value);
                                          });
                                        },
                                        child: Container(
                                            height: 20,
                                            width: double.infinity,
                                            color:
                                                Colors.white.withOpacity(0.5),
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
                          },
                          bloc: chooseImageBloc,
                        ),
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Text(
                            modelProfile.profile!.name ?? '',
                            style: StyleApp.textStyle700(),
                          ),
                          SizedBox()
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Họ và tên',
                        style: StyleApp.textStyle500(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputText1(
                        onChanged: (val){
                          modelProfile.profile!.name=val;
                        },
                        colorShadow: Colors.transparent,
                        radius: 5,
                        label: 'Nhập họ và tên',
                        controller: name,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Emai;',
                        style: StyleApp.textStyle500(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputText1(colorShadow: Colors.transparent,
                        radius: 5,
                        onChanged: (val){
                          modelProfile.profile!.email=val;
                        },
                        label: 'Nhập email',
                        controller: email,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Số điện thoại',
                        style: StyleApp.textStyle500(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputText1(colorShadow: Colors.transparent,
                        radius: 5,
                        label: 'Nhập số điện thoại',
                        controller: phone,
                        readOnly: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Địa chỉ',
                        style: StyleApp.textStyle500(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InputText1(colorShadow: Colors.transparent,
                        radius: 5,
                        onChanged: (val){
                          modelProfile.profile!.address=val;
                        },
                        label: 'Nhập địa chỉ',
                        controller: address,
                        maxLine: 4,
                      ),
                      SizedBox(height: 100,)
                    ],
                  ),
                ),
              );
            }
            return SizedBox();
          },
          bloc: blocProfile,
        ));
    
  }
}
