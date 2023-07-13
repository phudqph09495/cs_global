import 'package:cs_global/bloc/event_bloc.dart';
import 'package:cs_global/bloc/notify/bloc_listNoti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/notify/model_listNoti.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../styles/init_style.dart';
import '../../widget/loadPage/item_loadfaild.dart';

class ListNotiScreen extends StatefulWidget {
  const ListNotiScreen({super.key});

  @override
  State<ListNotiScreen> createState() => _ListNotiScreenState();
}

class _ListNotiScreenState extends State<ListNotiScreen> {
  BlocListNoti blocListNoti = BlocListNoti()..add(GetData());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.green00,
        title: Text(
          'Thông báo'.toUpperCase(),
          style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: BlocBuilder(
            builder: (_, StateBloc state) {
              if (state is Loading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorApp.main,
                  ),
                );
              }
              if (state is LoadFail) {
                return ItemLoadFaild(error: state.error, onTap: () {});
              }
              if (state is LoadSuccess) {
                ModelListNoti modelListNoti = state.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        print(modelListNoti.notify![index].id);
                      },
                      child: Card(
                        color: ColorApp.whiteF0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                              '${modelListNoti.notify![index].title}' ,
                                style: StyleApp.textStyle500(
                                    color: ColorApp.dark500),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                '${modelListNoti.notify![index].message}',
                                style: StyleApp.textStyle700(
                                    color: ColorApp.redText),
                              ),

                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${Const.convertTime('${modelListNoti.notify![index].createdAt}')}',
                                    style: StyleApp.textStyle500(
                                        color: ColorApp.dark500),
                                  ),
                                  Text(
                                    'Xem chi tiết',
                                    style: StyleApp.textStyle500(
                                        color: ColorApp.dark500,
                                        decoration:
                                        TextDecoration.underline),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: modelListNoti.notify!.length,
                );
              }
              return SizedBox();
            },
            bloc: blocListNoti,
          ),
        ),
      ),
    );
  }
}
