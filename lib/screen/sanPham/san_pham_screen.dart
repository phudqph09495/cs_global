import 'package:cs_global/bloc/product/bloc_listChild.dart';
import 'package:cs_global/model/model_child.dart';
import 'package:cs_global/screen/home/listPro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/cart/bloc_cart.dart';
import '../../bloc/cart/event_bloc2.dart';
import '../../bloc/cart/model_sp.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_listCate.dart';
import '../../bloc/product/bloc_listPro.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../model/model_listCate.dart';
import '../../model/model_listPro.dart';
import '../../styles/init_style.dart';
import '../../widget/item/custom_toast.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';
import '../../widget/loadPage/item_loadmore.dart';
import '../home/infoPro_screen.dart';

class SanPhamScreen extends StatefulWidget {
  const SanPhamScreen({Key? key}) : super(key: key);

  @override
  State<SanPhamScreen> createState() => _SanPhamScreenState();
}

class _SanPhamScreenState extends State<SanPhamScreen> with TickerProviderStateMixin {
  BlocListCate blocListCate = BlocListCate()..add(GetData());
  BlocListCate blocListCate1 = BlocListCate()..add(GetData());
  // BlocListChild blocListChild = BlocListChild();
  int idChild = 0;
  int choose = 0;

  BlocListPro blocListPro = BlocListPro();
  int page = 1;
  ScrollController _controller = ScrollController();
String cateID='';
  Future<void> onRefresh(String id) async {
    page = 1;
    blocListPro.add(
        LoadMoreEvent(page: page, cleanList: true, id: id));
    // blocProductMain.add(LoadMoreEvent(
    //   page: page,
    //   cleanList: true,
    // ));
  }

  loadmore(String id) async {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        page++;
        blocListPro.add(LoadMoreEvent(
            page: page, loadMore: true, id: id));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.green00,
        title: Text(
          'Sản phẩm'.toUpperCase(),
          style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
        ),
      ),
      // body: Row(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Expanded(
      //         flex: 2,
      //         child: SingleChildScrollView(
      //           child: BlocBuilder(
      //               bloc: blocListCate,
      //               builder: (_, StateBloc state) {
      //                 if (state is Loading) {
      //                   return Center(
      //                     child: CircularProgressIndicator(
      //                       color: ColorApp.main,
      //                     ),
      //                   );
      //                 }
      //                 if (state is LoadFail) {
      //                   return ItemLoadFaild(
      //                     error: state.error,
      //                     onTap: () {},
      //                   );
      //                 }
      //                 if (state is LoadSuccess) {
      //                   ModelListCate model = state.data;
      //                   blocListChild.add(GetData(
      //                       param: model.categories![choose].id.toString()));
      //                   return Container(
      //                     color: ColorApp.pink.withOpacity(0.5),
      //                     child: ListView.builder(
      //                       itemBuilder: (context, index) {
      //                         return InkWell(
      //                           onTap: () {
      //                             choose = index;
      //                             setState(() {});
      //                             idChild = model.categories![choose].id!;
      //                             blocListChild
      //                                 .add(GetData(param: idChild.toString()));
      //                           },
      //                           child: Container(
      //                             height: 130,
      //                             alignment: Alignment.center,
      //                             decoration: BoxDecoration(
      //                                 color: choose == index
      //                                     ? ColorApp.green
      //                                     : ColorApp.whiteF0,
      //                                 border: Border(
      //                                   top: BorderSide(color:Color(0xffDDDDDD),width: 2 ),
      //
      //                                 )),
      //                                 // border:
      //                                 //     Border.all(color: Color(0xffDDDDDD))),
      //                             child: Padding(
      //                               padding: const EdgeInsets.all(8.0),
      //                               child: Column(
      //                                 mainAxisAlignment:
      //                                     MainAxisAlignment.spaceEvenly,
      //                                 children: [
      //                                   LoadImage(
      //                                     height: 50,
      //                                     width: 50,
      //                                     fit: BoxFit.fill,
      //                                     url: model.categories![index].image !=
      //                                             null
      //                                         ? '${Const.image_host}${model.categories![index].image}'
      //                                         : '',
      //                                   ),
      //                                   Text(
      //                                     model.categories![index].name ?? '',
      //                                     style: StyleApp.textStyle500(
      //                                       color:choose == index?Colors.white:Colors.black,
      //                                       fontSize: 13
      //                                     ),
      //                                     textAlign: TextAlign.center,
      //                                   ),
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                         );
      //                       },
      //                       shrinkWrap: true,
      //                       physics: NeverScrollableScrollPhysics(),
      //                       itemCount: model.categories!.length,
      //                     ),
      //                   );
      //                 }
      //                 return SizedBox();
      //               }),
      //         )),
      //     Expanded(
      //         flex: 6,
      //         child: SingleChildScrollView(
      //           child: BlocBuilder(
      //               bloc: blocListChild,
      //               builder: (_, StateBloc state) {
      //                 if (state is Loading) {
      //                   return Center(
      //                     child: CircularProgressIndicator(
      //                       color: ColorApp.main,
      //                     ),
      //                   );
      //                 }
      //                 if (state is LoadFail) {
      //                   return ItemLoadFaild(
      //                     error: state.error,
      //                     onTap: () {},
      //                   );
      //                 }
      //                 if (state is LoadSuccess) {
      //                   ModelChild modelChild = state.data;
      //                   return Stack(
      //                     children: [
      //                       Container(
      //                         width: double.infinity,
      //                         height: MediaQuery.of(context).size.height * 3,
      //                         decoration: BoxDecoration(
      //                           image: DecorationImage(
      //                             image: AssetImage("assets/images/bg.png"),
      //                             fit: BoxFit.cover,
      //                           ),
      //                         ),
      //                       ),
      //                       GridView.builder(
      //                         padding: EdgeInsets.symmetric(horizontal: 8),
      //                         itemCount: modelChild.child!.length,
      //                         physics: const NeverScrollableScrollPhysics(),
      //                         shrinkWrap: true,
      //                         gridDelegate:
      //                             const SliverGridDelegateWithFixedCrossAxisCount(
      //                                 crossAxisCount: 3,
      //                                 mainAxisSpacing: 10,
      //                                 crossAxisSpacing: 10.0,
      //                                 mainAxisExtent: 150),
      //                         itemBuilder: (BuildContext context, int index) {
      //                           return InkWell(
      //                             onTap: () {
      //                               Navigator.push(
      //                                   context,
      //                                   MaterialPageRoute(
      //                                       builder: (context) => ListProScreen(
      //                                           title:
      //                                               '${modelChild.child![index].name}',
      //                                           id: modelChild
      //                                               .child![index].id!)));
      //                             },
      //                             child: Column(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceEvenly,
      //                               children: [
      //                                 LoadImage(
      //                                     url:
      //                                         '${Const.image_host}${modelChild.child![index].image}'),
      //                                 Text(
      //                                   '${modelChild.child![index].name}',
      //                                   style: StyleApp.textStyle700(),
      //                                 ),
      //                               ],
      //                             ),
      //                           );
      //                         },
      //                       )
      //                     ],
      //                   );
      //                 }
      //                 return Container();
      //               }),
      //         ))
      //   ],
      // ),
      body: Column(
        children: [
          BlocBuilder(
              bloc: blocListCate1,
              builder: (_, StateBloc state) {
                if (state is LoadSuccess) {
                  ModelListCate model = state.data;
                  cateID=model.categories![0].id.toString();
                  onRefresh(model.categories![0].id.toString());
                  loadmore(model.categories![0].id.toString());
                return SizedBox();
                }
                return SizedBox();
              }),
          BlocBuilder(
              bloc: blocListCate,
              builder: (_, StateBloc state) {
                if (state is LoadSuccess) {
                  ModelListCate model = state.data;
                  TabController? _tabController = TabController(
                      length: model.categories!.length,
                      vsync: this,
                      initialIndex: 0);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(
                            color: Color(0xffDDDDDD)
                          ))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TabBar(
                          isScrollable: true,
                          controller: _tabController,
                          onTap: (value) {
                            cateID=model.categories![value].id.toString();
                            onRefresh(model.categories![value].id.toString());
loadmore(model.categories![value].id.toString());
                            // blocListNews.add(GetData(
                            //     param: model.serviceCate![value].id.toString()));
                          },
                          indicator: BoxDecoration(

                            color: ColorApp.green00,
                          ),
                          labelPadding:

                          const EdgeInsets.symmetric(horizontal: 10),
                          labelStyle: StyleApp.textStyle700(fontSize: 16),
                          indicatorColor: Colors.transparent,
                          unselectedLabelStyle:
                          StyleApp.textStyle500(fontSize: 14),
                          labelColor: ColorApp.whiteF7,
                          unselectedLabelColor: Colors.black,
                          tabs: <Widget>[
                            ...List.generate(
                              model.categories!.length,
                                  (index) => Tab(
                                child: Text(
                                  model.categories![index].name ?? '',
                                ),
                              ),
                            )
                            // Tab(
                            //   child: Text(
                            //     'Chi tiết',
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox();
              }),
          Expanded(
            child: BlocBuilder(
                bloc: blocListPro,
                builder: (_, StateBloc state) {
                  if (state is Loading) {
                    return  Center(
                      child: CircularProgressIndicator(
                        color: ColorApp.main,
                      ),
                    );
                  }
                  if (state is LoadFail) {
                    return ItemLoadFaild(
                      error: state.error,
                      onTap: () {

                      },
                    );
                  }
                  if (state is LoadSuccess) {
                    List<Prod> model = state.data;
                    final length = state.checkLength;
                    final hasMore = state.hasMore;
                    return SingleChildScrollView(
                      controller: _controller,
                      child: Column(
                        children: [

                          GridView.builder(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 0,
                                mainAxisExtent:
                                MediaQuery.of(context).size.height * 0.34),
                            itemBuilder: (context, index) {
                              BlocCartLocal blocCartLocal = BlocCartLocal();
                              return InkWell(
                                onTap: () {
                                  context.read<BlocCartLocal>().add(GetCart());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => InfoProdScreen(
                                            id: model[index].id.toString(),
                                            cateID: cateID,
                                          )));
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child:Stack(alignment: Alignment.bottomRight,
                                    children: [
                                      Stack(

                                        children: [
                                          Container(
                                            height:
                                            MediaQuery.of(context).size.height * 0.34,
                                            width:
                                            MediaQuery.of(context).size.width * 0.47,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorApp.grey4F
                                                ),
                                                borderRadius: BorderRadius.circular(12)),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    SizedBox(
                                                      height: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height *
                                                          0.24,
                                                      width: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .width *
                                                          0.47,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        const BorderRadius
                                                            .only(
                                                            topLeft: Radius
                                                                .circular(
                                                                12),
                                                            topRight: Radius
                                                                .circular(
                                                                12)),
                                                        child: LoadImage(
                                                          fit: BoxFit.fill,
                                                          url:
                                                          '${Const.image_host}${model![index].thumbnail}',
                                                        ),
                                                      ),
                                                    ),
                                                    Container(

                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          const BorderRadius
                                                              .only(

                                                              topRight: Radius
                                                                  .circular(
                                                                  12)),
                                                          image: DecorationImage(scale: 0.2,
                                                              image: ExactAssetImage(
                                                                  'assets/images/giam.png',scale: 0.2),
                                                              fit: BoxFit.fill)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              ' - ${model[index].discount} ',
                                                              style: StyleApp.textStyle700(
                                                                  color: ColorApp.redText),
                                                            ),
                                                            Text(
                                                              'GIẢM',
                                                              style: StyleApp.textStyle700(
                                                                  color: Colors.white),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 4),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      // Text(
                                                      //   model
                                                      //           .productSugges![
                                                      //               index]
                                                      //           .code ??
                                                      //       '',
                                                      //   style: StyleApp
                                                      //       .textStyle600(),
                                                      // ),

                                                      Text(
                                                        model
                                                        [
                                                        index]
                                                            .name ??
                                                            '',
                                                        maxLines: 1,
                                                        textAlign: TextAlign.center,
                                                        style: StyleApp
                                                            .textStyle500(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),

                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            '${Const.ConvertPrice.format(int.parse('${model[index].price}'))} đ',
                                                            style: StyleApp
                                                                .textStyle500(
                                                                decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                          ),
                                                          Text(
                                                            '${Const.ConvertPrice.format(int.parse('${model[index].discountPrice}'))} đ',
                                                            style: StyleApp
                                                                .textStyle700(
                                                                color: ColorApp
                                                                    .redText),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      bottomLeft: Radius.circular(12),
                                                      topRight: Radius.circular(12)
                                                  ),
                                                  color: Colors.red),

                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 5),
                                                child: Text(
                                                  'Còn lại : ${model![index].amount}',
                                                  style: StyleApp.textStyle500(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      Positioned(

                                        child: BlocListener(
                                          bloc: blocCartLocal,
                                          listener: (context, StateBloc state) {
                                            if (state is LoadSuccess) {
                                              CustomToast.showToast(
                                                  context: context,
                                                  msg:
                                                  'Đã thêm vào giỏ hàng thành công',
                                                  duration: 1,
                                                  gravity: ToastGravity.BOTTOM);
                                            }
                                          },
                                          child: InkWell(
                                            onTap: () {
                                              blocCartLocal.add(AddData(
                                                  modelSanPhamMain: ModelSanPhamMain(
                                                      id: model[index].id,
                                                      amount: 1,
                                                      max: model[index].amount)));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(12),
                                                    bottomRight: Radius.circular(12),
                                                  ),
                                                  color: Colors.red),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.shopping_cart_outlined,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: model.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                          ),
                          ItemLoadMore(
                            hasMore: hasMore,
                            length: length,
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                }),
          ),
        ],
      ),
    );
  }
}
