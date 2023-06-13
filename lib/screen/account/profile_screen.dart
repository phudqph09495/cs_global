import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/choose_image_bloc.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.green00,
        title: Text(
          'Thông tin cá nhân',
          style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
        ),
      ),
      body: BlocBuilder(builder: (_,StateBloc state){
          if (state is Loading) {
            return
                 Center(
                  child: CircularProgressIndicator(
                    color: ColorApp.main,
                  ),
                );
          }
          if (state is LoadFail) {
            return
                ItemLoadFaild(error: state.error,
                  onTap: (){
                    blocProfile.add(GetData());
                  },

                );
          }
        if(state is LoadSuccess){
          ModelProfile modelProfile=state.data;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                    Stack(
                      children: [
                        Container(
                            alignment: Alignment.topLeft,
                            height: MediaQuery.of(context).size.width * 0.51,
                            child: BlocBuilder(
                              builder: (context, XFile? snapshot) {
                                return snapshot != null
                                    ? Image.file(
                                  File(snapshot.path),
                                  fit: BoxFit.fitWidth,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width *
                                      0.38,
                                )
                                    : LoadImage(
                                  url:
                                  'https://www.pngitem.com/pimgs/m/35-350426_profile-icon-png-default-profile-picture-png-transparent.png',
                                  fit: BoxFit.fitWidth,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width *
                                      0.38,
                                );
                              },
                              bloc: chooseImageBloc2,
                            )),
                        Positioned(
                            top: 100,
                            right: 0,
                            child: InkWell(
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border:
                                        Border.all(color: ColorApp.orangeF0),
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 16,
                                    )),
                                onTap: () {})),
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
                                    url: 'https://i.imgur.com/k0UTIr6.jpeg',
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  InkWell(
                                    onTap: () {
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
                      },
                      bloc: chooseImageBloc,
                    ),
                  ]),
                  Text(modelProfile.profile!.name??'',style: StyleApp.textStyle700(),)

                ],
              ),
            ),
          );
        }
        return SizedBox();
      },bloc: blocProfile,)
    );
  }
}
