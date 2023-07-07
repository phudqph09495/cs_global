import 'package:cs_global/bloc/cart/event_bloc2.dart';
import 'package:cs_global/bloc/cart/model_sp.dart';
import 'package:cs_global/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/cart/bloc_cart.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_listPro.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../config/path/share_pref_path.dart';
import '../../model/model_listPro.dart';
import '../../start.dart';
import '../../styles/init_style.dart';
import '../../widget/item/custom_toast.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';
import '../../widget/loadPage/item_loadmore.dart';
import 'infoPro_screen.dart';
import 'item/product_item.dart';

class ListProScreen extends StatefulWidget {
  String title;
  int id;
  ListProScreen({required this.title, required this.id});

  @override
  State<ListProScreen> createState() => _ListProScreenState();
}

class _ListProScreenState extends State<ListProScreen> {
  BlocListPro blocListPro = BlocListPro();
  int page = 1;
  ScrollController _controller = ScrollController();

  Future<void> onRefresh() async {
    page = 1;
    blocListPro.add(
        LoadMoreEvent(page: page, cleanList: true, id: widget.id.toString()));
    // blocProductMain.add(LoadMoreEvent(
    //   page: page,
    //   cleanList: true,
    // ));
  }

  loadmore() async {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        page++;
        blocListPro.add(LoadMoreEvent(
            page: page, loadMore: true, id: widget.id.toString()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh();
    loadmore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.green00,
        title: Text(
          widget.title,
          style: StyleApp.textStyle500(fontSize: 20, color: Colors.white),
        ),
      ),
      body: BlocBuilder(
          bloc: blocListPro,
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
                onTap: () {
                  blocListPro.add(GetData(param: widget.id.toString()));
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
                                          cateID: widget.id.toString(),
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
                                      MediaQuery.of(context).size.width * 0.45,
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
                                                    0.45,
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
                                                horizontal: 8,
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
                                                SizedBox(
                                                  height: 10,
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
    );
  }
}
