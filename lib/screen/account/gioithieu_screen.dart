import 'package:cs_global/bloc/auth/bloc_profile.dart';
import 'package:cs_global/model/model_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../styles/init_style.dart';
import '../../widget/loadPage/item_loadfaild.dart';
import 'gioiThieu/ds_gioiThieu_screen.dart';

class GioiThieuScreen extends StatefulWidget {
  const GioiThieuScreen({Key? key}) : super(key: key);

  @override
  State<GioiThieuScreen> createState() => _GioiThieuScreenState();
}

class _GioiThieuScreenState extends State<GioiThieuScreen> {
  BlocProfile blocProfile = BlocProfile()..add(GetData());
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: blocProfile,
        builder: (_, StateBloc state) {
          if (state is Loading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: ColorApp.main,
                ),
              ),
            );
          }
          if (state is LoadFail) {
            return ItemLoadFaild(
              error: state.error,
              onTap: () {},
            );
          }
          if (state is LoadSuccess) {
            ModelProfile modelProfile = state.data;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: ColorApp.green00,
                title: Text(
                  'Giới thiệu người mua',
                  style:
                      StyleApp.textStyle500(fontSize: 20, color: Colors.white),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/logo.png'),
                      Text(
                        'Mã giới thiệu của bạn',
                        style: StyleApp.textStyle500(),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      PhysicalModel(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        elevation: 5.0,
                        shadowColor: ColorApp.pink,
                        color: Colors.transparent,
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              Expanded(
                                  flex: 10,
                                  child: Text(
                                    modelProfile.profile!.code ?? '',
                                    textAlign: TextAlign.center,
                                  )),
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(
                                            text: modelProfile.profile!.code ??
                                                ''))
                                        .then((value) {
                                      //only if ->
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Đã copy '))); // -> show a notification
                                    });
                                  },
                                  child: Container(
                                    child: Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                    ),
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: ColorApp.green00,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                    ),
                                  ),
                                ),
                              ),
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
                              onTap: () {
                                Share.share('${modelProfile.profile!.code}');
                              },
                              child: Text(
                                'Chia sẻ đến bạn bè ',
                                style: StyleApp.textStyle500(
                                    fontSize: 16,
                                    color: ColorApp.blue00,
                                    decoration: TextDecoration.underline),
                              )),
                          SizedBox()
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Danh sách khách hàng được giới thiệu',
                        style: StyleApp.textStyle700(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                        return     Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: PhysicalModel(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            elevation: 5.0,
                            shadowColor: ColorApp.pink,
                            color: Colors.transparent,
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                                  Expanded(
                                      flex: 10,
                                      child: Text(
                                        '${index+1}.${modelProfile.profile!.refer![index].name}' ,style: StyleApp.textStyle500(),
                                        textAlign: TextAlign.center,
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                        },
                        itemCount: modelProfile.profile!.refer!.length > 3
                            ? 3
                            : modelProfile.profile!.refer!.length,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [SizedBox(),
                          InkWell(onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DSGTLogin()));
                          },child: Text('Xem tất cả',style: StyleApp.textStyle500(decoration: TextDecoration.underline,color: ColorApp.dark500),)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Scaffold();
        });
  }
}
