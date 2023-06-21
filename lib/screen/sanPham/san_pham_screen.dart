import 'package:cs_global/bloc/product/bloc_listChild.dart';
import 'package:cs_global/model/model_child.dart';
import 'package:cs_global/screen/home/listPro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_listCate.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../model/model_listCate.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';

class SanPhamScreen extends StatefulWidget {
  const SanPhamScreen({Key? key}) : super(key: key);

  @override
  State<SanPhamScreen> createState() => _SanPhamScreenState();
}

class _SanPhamScreenState extends State<SanPhamScreen> {
  BlocListCate blocListCate = BlocListCate()..add(GetData());
  BlocListChild blocListChild = BlocListChild();
  int idChild = 0;
  int choose = 0;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: BlocBuilder(
                    bloc: blocListCate,
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
                          onTap: () {},
                        );
                      }
                      if (state is LoadSuccess) {
                        ModelListCate model = state.data;
                        blocListChild.add(GetData(
                            param: model.categories![choose].id.toString()));
                        return Container(
                          color: ColorApp.pink.withOpacity(0.5),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  choose = index;
                                  setState(() {});
                                  idChild = model.categories![choose].id!;
                                  blocListChild
                                      .add(GetData(param: idChild.toString()));
                                },
                                child: Container(
                                  height: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: choose == index
                                          ? ColorApp.green.withOpacity(0.3)
                                          : ColorApp.pink.withOpacity(0.5),
                                      border: Border.all()),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        LoadImage(
                                          fit: BoxFit.fill,
                                          url: model.categories![index].image !=
                                                  null
                                              ? '${Const.image_host}${model.categories![index].image}'
                                              : '',
                                        ),
                                        Text(
                                          model.categories![index].name ?? '',
                                          style: StyleApp.textStyle700(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: model.categories!.length,
                          ),
                        );
                      }
                      return SizedBox();
                    }),
              )),
          Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: BlocBuilder(
                    bloc: blocListChild,
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
                          onTap: () {},
                        );
                      }
                      if (state is LoadSuccess) {
                        ModelChild modelChild = state.data;
                        return GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          itemCount: modelChild.child!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10.0,
                                  mainAxisExtent: 150),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListProScreen(
                                            title:
                                                '${modelChild.child![index].name}',
                                            id: modelChild.child![index].id!)));
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  LoadImage(
                                      url:
                                          '${Const.image_host}${modelChild.child![index].image}'),
                                  Text(
                                    '${modelChild.child![index].name}',
                                    style: StyleApp.textStyle700(),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    }),
              ))
        ],
      ),
    );
  }
}
