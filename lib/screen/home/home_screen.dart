import 'package:cs_global/bloc/banner/model_listBanner.dart';
import 'package:cs_global/bloc/news/model_cateNews.dart';
import 'package:cs_global/model/model_listMostSale.dart';
import 'package:cs_global/model/model_listSug.dart';
import 'package:cs_global/screen/home/search_screen.dart';
import 'package:cs_global/widget/item/input/text_filed.dart';
import 'package:cs_global/widget/item/input/text_filed2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_button/group_button.dart';

import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/banner/bloc_listBanner.dart';
import '../../bloc/cart/bloc_cart.dart';
import '../../bloc/cart/event_bloc2.dart';
import '../../bloc/cart/model_sp.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/news/bloc_listCateNews.dart';
import '../../bloc/product/bloc_listCate.dart';
import '../../bloc/product/bloc_listMostSale.dart';
import '../../bloc/product/bloc_listPro.dart';
import '../../bloc/product/bloc_listSuggest.dart';
import '../../bloc/service/bloc_listServiceCate.dart';
import '../../bloc/service/model_listServiceCate.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../config/path/share_pref_path.dart';
import '../../model/model_listCate.dart';
import '../../model/model_listPro.dart';
import '../../start.dart';
import '../../styles/init_style.dart';
import '../../widget/item/custom_toast.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';
import '../cart/gio_hang_screen.dart';
import 'infoPro_screen.dart';
import 'item/product_item.dart';
import 'listPro_screen.dart';
import 'list_new_screen.dart';
import 'list_ser_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = GroupButtonController();
  BlocListCate blocListCate = BlocListCate()..add(GetData());
  BlocListSuggest blocListSuggest = BlocListSuggest()..add(GetData());
  List<String> listButton = ['Sản phẩm', 'Dịch vụ', 'HT Land'];
  int tab = 0;
  BlocListMostSale blocListMostSale = BlocListMostSale()..add(GetData());

  BlocListServiceCate blocListService = BlocListServiceCate()..add(GetData());
  BlocListBanner banner = BlocListBanner()..add(GetData());
  BlocListNewsCate blocListNewsCate = BlocListNewsCate()..add(GetData());
  BlocListPro blocListPro0 = BlocListPro();
  BlocListPro blocListPro1 = BlocListPro();
  List<IconData> listIcon = [
    FontAwesomeIcons.boxArchive,
    FontAwesomeIcons.screwdriverWrench,
    FontAwesomeIcons.graduationCap,
    FontAwesomeIcons.buildingColumns
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.selectIndex(0);

    context.read<BlocCartLocal>().add(GetCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: double.infinity,
                    child: BlocBuilder(
                      builder: (_, StateBloc state) {
                        if (state is LoadSuccess) {
                          ModelListBanner model = state.data;
                          return ImageSlideshow(
                            height: MediaQuery.of(context).size.height * 0.33,
                            width: double.infinity,
                            indicatorBackgroundColor: Colors.transparent,
                            indicatorColor: Colors.transparent,
                            isLoop: true,
                            autoPlayInterval: 5000,
                            children: List.generate(
                                model.banners!.length,
                                (index) => LoadImage(
                                      fit: BoxFit.cover,
                                      url:
                                          '${Const.image_host}${model.banners![index].image}',
                                    )),
                          );
                        }
                        return Image.asset(
                          'assets/images/img.png',
                          fit: BoxFit.fill,
                        );
                      },
                      bloc: banner,
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.02,
                  )
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.05,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Container(
                            height: 40,
                            child: InputText1(
                              readOnly: true,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchScreen()));
                              },
                              colorShadow: Colors.transparent,
                              label: 'Tìm kiếm sản phẩm',
                              colorBg: Colors.white.withOpacity(0.5),
                              colorLabel: Colors.white,
                              borderColor: Colors.white,
                              hasLeading: true,
                              iconPreFix: const Icon(
                                Icons.search_outlined,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            // const Icon(
                            //   Icons.qr_code_scanner_outlined,
                            //   color: Colors.white,
                            // ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const GioHangScreen()));
                              },
                              child: Stack(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: BlocBuilder<BlocCartLocal,
                                              StateBloc>(
                                            builder:
                                                (context, StateBloc state) {
                                              List<ModelSanPhamMain> list =
                                                  state is LoadSuccess
                                                      ? state.data
                                                      : [];

                                              return Text(
                                                list.length.toString(),
                                                style: StyleApp.textStyle500(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              );
                                            },
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            SizedBox()
                            // Stack(
                            //   children: [
                            //     const Padding(
                            //       padding: EdgeInsets.all(3.0),
                            //       child: Icon(
                            //         Icons.notifications_none_outlined,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //     Positioned(
                            //         top: 0,
                            //         right: 0,
                            //         child: Container(
                            //           decoration: const BoxDecoration(
                            //               color: Colors.red,
                            //               shape: BoxShape.circle),
                            //           child: Padding(
                            //             padding: const EdgeInsets.all(4.0),
                            //             child: Text(
                            //               '0',
                            //               style: StyleApp.textStyle500(
                            //                   fontSize: 10,
                            //                   color: Colors.white),
                            //             ),
                            //           ),
                            //         ))
                            //   ],
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GroupButton<String>(
                    buttonIndexedBuilder: (selected, index, context) {
                      return PhysicalModel(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        color: Colors.transparent,
                        elevation: 5.0,
                        shadowColor: Colors.grey,
                        child: Container(
                          height: 50,
                          width: (MediaQuery.of(context).size.width - 16) / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: selected ? ColorApp.redText : Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FaIcon(
                                    listIcon[index],
                                    size: 12,
                                    color: selected
                                        ? Colors.white
                                        : Color(0xff019549),
                                  ),
                                  Text(
                                    ' ${listButton[index]}',
                                    style: StyleApp.textStyle700(
                                        color: selected
                                            ? Colors.white
                                            : ColorApp.green1),
                                  ),
                                ],
                              ),
                              SizedBox(),
                            ],
                          ),
                        ),
                      );
                    },
                    controller: controller,
                    options: GroupButtonOptions(
                      selectedTextStyle:
                          StyleApp.textStyle500(color: Colors.white),
                      selectedColor: ColorApp.red1,
                      unselectedTextStyle:
                          StyleApp.textStyle500(color: ColorApp.green1),
                      buttonHeight: 50,
                      borderRadius: BorderRadius.circular(12),
                      spacing: 2,
                      // buttonWidth:
                      //     (MediaQuery.of(context).size.width - 16) / 4
                    ),
                    isRadio: true,
                    onSelected: (text, index, bool) {
                      tab = index;
                      setState(() {});
                    },
                    buttons: listButton,
                  ),
                ),
              ),
            ]),
            tab == 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Nhóm sản phẩm',
                          style: StyleApp.textStyle700(
                              color: ColorApp.darkGreen, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocBuilder(
                            bloc: blocListCate,
                            builder: (_, StateBloc state) {
                              if (state is Loading) {
                                return const Center(
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
                                ModelListCate modelListCate = state.data;
                                blocListPro0.add(LoadMoreEvent(
                                    page: 1,
                                    cleanList: true,
                                    id: modelListCate.categories![0].id
                                        .toString(),
                                title:modelListCate.categories![0].name??'' ));
                                blocListPro1.add(LoadMoreEvent(
                                    page: 1,
                                    cleanList: true,
                                    id: modelListCate.categories![1].id
                                        .toString(),
                                    title:modelListCate.categories![1].name??'' ));
                                return Container(
                                  height: Const.sizeHeight(context, 115),
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ListProScreen(
                                                          id: modelListCate
                                                              .categories![
                                                                  index]
                                                              .id!,
                                                          title: modelListCate
                                                              .categories![
                                                                  index]
                                                              .name!,
                                                        ))).then((value) =>
                                                context
                                                    .read<BlocCartLocal>()
                                                    .add(GetCart()));
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08,
                                                child: LoadImage(
                                                  fit: BoxFit.cover,
                                                  url: modelListCate
                                                              .categories![
                                                                  index]
                                                              .image !=
                                                          null
                                                      ? '${Const.image_host}${modelListCate.categories![index].image}'
                                                      : '',
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  child: Text(
                                                    modelListCate
                                                            .categories![index]
                                                            .name ??
                                                        '',
                                                    style:
                                                        StyleApp.textStyle500(
                                                            fontSize: 12),
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    scrollDirection: Axis.horizontal,
                                    itemCount: modelListCate.categories!.length,
                                    shrinkWrap: true,
                                  ),
                                );
                                // return GridView.builder(
                                //   padding: EdgeInsets.zero,
                                //   itemCount: modelListCate.categories!.length > 8
                                //       ? 8
                                //       : modelListCate.categories!.length,
                                //   physics: const NeverScrollableScrollPhysics(),
                                //   shrinkWrap: true,
                                //   gridDelegate:
                                //       SliverGridDelegateWithFixedCrossAxisCount(
                                //           crossAxisCount: 4,
                                //           crossAxisSpacing: 10.0,
                                //           mainAxisExtent:
                                //               Const.sizeHeight(context, 130)),
                                //   itemBuilder:
                                //       (BuildContext context, int index) {
                                //     return InkWell(
                                //       onTap: () {
                                //         Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //                 builder: (context) =>
                                //                     ListProScreen(
                                //                       id: modelListCate
                                //                           .categories![index]
                                //                           .id!,
                                //                       title: modelListCate
                                //                           .categories![index]
                                //                           .name!,
                                //                     ))).then((value) => context
                                //             .read<BlocCartLocal>()
                                //             .add(GetCart()));
                                //       },
                                //       child: Column(
                                //         mainAxisSize: MainAxisSize.min,
                                //         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //         children: [
                                //           Container(
                                //             width: MediaQuery.of(context)
                                //                     .size
                                //                     .width *
                                //                 0.1,
                                //             child: LoadImage(
                                //               fit: BoxFit.fitWidth,
                                //               url: modelListCate.categories![index]
                                //                           .image !=
                                //                       null
                                //                   ? '${Const.image_host}${modelListCate.categories![index].image}'
                                //                   : '',
                                //             ),
                                //           ),
                                //           Padding(
                                //             padding: const EdgeInsets.symmetric(
                                //                 vertical: 10),
                                //             child: Text(
                                //               modelListCate.categories![index].name ??
                                //                   '',
                                //               style: StyleApp.textStyle500(
                                //                   fontSize: 13),
                                //               textAlign: TextAlign.center,
                                //             ),
                                //           )
                                //         ],
                                //       ),
                                //     );
                                //   },
                                // );
                              }
                              return Container();
                            }),
                        SizedBox(
                          height: Const.size(context).width * 0.25 + 10,
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Stack(
                                  fit: StackFit.loose,
                                  clipBehavior: Clip.none,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'slide${index}.png',
                                        width: Const.size(context).width * 0.4,
                                        height:
                                            Const.size(context).width * 0.25,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                              color: ColorApp.background,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 5,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Xem ngay',
                                                style: StyleApp.textStyle700(
                                                  fontSize: 12,
                                                  color: ColorApp.green1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 8,
                                  ),
                              itemCount: 3),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            tab == 1
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   'Nhóm sản phẩm',
                        //   style: StyleApp.textStyle700(
                        //       color: ColorApp.darkGreen, fontSize: 18),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        BlocBuilder(
                          builder: (_, StateBloc state) {
                            if (state is LoadSuccess) {
                              ModelListServiceCate model = state.data;
                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: model.serviceCate!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10.0,
                                        mainAxisExtent: 160),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListSerScreen(
                                                    initIndex: index,
                                                    id: model
                                                        .serviceCate![index].id
                                                        .toString(),
                                                  )));
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             ListNewsScreen(
                                      //               initIndex: index,
                                      //               id: model
                                      //                   .serviceCate![index].id
                                      //                   .toString(),
                                      //             )));
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: 100,
                                          child: LoadImage(
                                            url:
                                                '${Const.image_host}${model.serviceCate![index].image}',
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            model.serviceCate![index].name ??
                                                '',
                                            style: StyleApp.textStyle500(),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                            return SizedBox();
                          },
                          bloc: blocListService,
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
            tab == 4
                ? Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        'Chức năng đang phát triển vui lòng quay lại sau',
                        style: StyleApp.textStyle500(),
                      ),
                    ),
                  )
                : SizedBox(),
            tab == 2
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   'Nhóm sản phẩm',
                        //   style: StyleApp.textStyle700(
                        //       color: ColorApp.darkGreen, fontSize: 18),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        BlocBuilder(
                          builder: (_, StateBloc state) {
                            if (state is LoadSuccess) {
                              ModelListNewCate model = state.data;
                              return GridView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: model.newsCate!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10.0,
                                        mainAxisExtent: 160),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListNewsScreen(
                                                    initIndex: index,
                                                    id: model
                                                        .newsCate![index].id
                                                        .toString(),
                                                  )));
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: 100,
                                          child: Image.asset(
                                              'assets/images/htland${index}.png'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            model.newsCate![index].name ?? '',
                                            style: StyleApp.textStyle500(),
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                            return SizedBox();
                          },
                          bloc: blocListNewsCate,
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sản Phẩm Mua Nhiều Nhất',
                style: StyleApp.textStyle700(
                    color: ColorApp.darkGreen, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder(
              builder: (_, StateBloc state) {
                if (state is LoadSuccess) {
                  ModelListMostSale model = state.data;
                  return SizedBox(
                    height: model.mostSaleProduct!.length > 0
                        ? MediaQuery.of(context).size.height * 0.36
                        : 0,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        BlocCartLocal blocCartLocal = BlocCartLocal();
                        return InkWell(
                          onTap: () {
                            context.read<BlocCartLocal>().add(GetCart());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoProdScreen(
                                          id: model.mostSaleProduct![index].id
                                              .toString(),
                                          cateID: model.mostSaleProduct![index]
                                              .category![0].id
                                              .toString(),
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height:
                                      MediaQuery.of(context).size.height * 0.34,
                                      width:
                                      MediaQuery.of(context).size.width * 0.45,
                                      decoration: BoxDecoration(
                                          border:
                                          Border.all(color: ColorApp.grey4F),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.24,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.45,
                                                child: ClipRRect(
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(12),
                                                      topRight:
                                                      Radius.circular(12)),
                                                  child: LoadImage(
                                                    fit: BoxFit.fill,
                                                    url:
                                                    '${Const.image_host}${model.mostSaleProduct![index].thumbnail}',
                                                  ),
                                                ),
                                              ),
                                              // CircleAvatar(
                                              //   backgroundColor: Color(
                                              //             0xffCD2027),
                                              //   child: Text(
                                              //     ' - ${model.mostSaleProduct![index].discount} ',
                                              //     style: StyleApp
                                              //         .textStyle500(
                                              //         color: Colors
                                              //             .white),
                                              //   ),
                                              // ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                        topRight:
                                                        Radius.circular(
                                                            12)),
                                                    image: DecorationImage(
                                                        scale: 0.2,
                                                        image: ExactAssetImage(
                                                            'assets/images/giam.png',
                                                            scale: 0.2),
                                                        fit: BoxFit.fill)),
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        ' - ${model.mostSaleProduct![index].discount} ',
                                                        style:
                                                        StyleApp.textStyle700(
                                                            color: ColorApp
                                                                .redText),
                                                      ),
                                                      Text(
                                                        'GIẢM',
                                                        style:
                                                        StyleApp.textStyle700(
                                                            color:
                                                            Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                // Text(
                                                //   model
                                                //           .mostSaleProduct![
                                                //               index]
                                                //           .code ??
                                                //       '',
                                                //   style: StyleApp
                                                //       .textStyle600(),
                                                // ),
                                                Text(
                                                  model.mostSaleProduct![index]
                                                      .name ??
                                                      '',
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  style: StyleApp.textStyle500(),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(
                                                      '${Const.convertPrice('${'${model.mostSaleProduct![index].price}'}')} đ',
                                                      style: StyleApp.textStyle500(
                                                          decoration: TextDecoration
                                                              .lineThrough),
                                                    ),
                                                    Text(
                                                      '${Const.ConvertPrice.format(int.parse('${model.mostSaleProduct![index].discountPrice}'))} đ',
                                                      style: StyleApp.textStyle700(
                                                          color: ColorApp.redText),
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
                                                topRight: Radius.circular(12)),
                                            color: Colors.red),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 5),
                                          child: Text(
                                            'Còn lại : ${model.mostSaleProduct![index].amount}',
                                            style: StyleApp.textStyle500(
                                                color: Colors.white, fontSize: 12),
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
                                        context
                                            .read<BlocCartLocal>()
                                            .add(GetCart());
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
                                                id: model
                                                    .mostSaleProduct![index].id,
                                                amount: 1,
                                                max: model
                                                    .mostSaleProduct![index]
                                                    .amount)));
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              bottomRight: Radius.circular(12),
                                            ),
                                            color: Colors.red),
                                        child: const Padding(
                                          padding: EdgeInsets.all(4.0),
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
                      scrollDirection: Axis.horizontal,
                      itemCount: model.mostSaleProduct!.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                  );
                }
                return const SizedBox();
              },
              bloc: blocListMostSale,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sản Phẩm E - Commerce Đề Xuất',
                style: StyleApp.textStyle700(
                    color: ColorApp.darkGreen, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder(
              builder: (_, StateBloc state) {
                if (state is LoadSuccess) {
                  ModelListSugg model = state.data;
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
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
                                        id: model.productSugges![index].id
                                            .toString(),
                                        cateID: model.productSugges![index]
                                            .category![0].id
                                            .toString(),
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child:Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height:
                                    MediaQuery.of(context).size.height * 0.34,
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: ColorApp.grey4F),
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.24,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.45,
                                              child: ClipRRect(
                                                borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(12),
                                                    topRight:
                                                    Radius.circular(12)),
                                                child: LoadImage(
                                                  fit: BoxFit.cover,
                                                  url:
                                                  '${Const.image_host}${model.productSugges![index].thumbnail}',
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                      Radius.circular(12)),
                                                  image: DecorationImage(
                                                      scale: 0.2,
                                                      image: ExactAssetImage(
                                                          'assets/images/giam.png',
                                                          scale: 0.2),
                                                      fit: BoxFit.fill)),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 4),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      ' - ${model.productSugges![index].discount} ',
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                model.productSugges![index].name ??
                                                    '',
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                style: StyleApp.textStyle500(),
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    '${Const.ConvertPrice.format(int.parse('${model.productSugges![index].price}'))} đ',
                                                    style: StyleApp.textStyle500(
                                                        decoration: TextDecoration
                                                            .lineThrough),
                                                  ),
                                                  Text(
                                                    '${Const.ConvertPrice.format(int.parse('${model.productSugges![index].discountPrice}'))} đ',
                                                    style: StyleApp.textStyle700(
                                                        color: ColorApp.redText),
                                                  )
                                                ],
                                              ),
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
                                              topRight: Radius.circular(12)),
                                          color: Colors.red),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 5),
                                        child: Text(
                                          'Còn lại : ${model.productSugges![index].amount}',
                                          style: StyleApp.textStyle500(
                                              color: Colors.white, fontSize: 12),
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
                                      context
                                          .read<BlocCartLocal>()
                                          .add(GetCart());
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
                                              id: model
                                                  .productSugges![index].id,
                                              amount: 1,
                                              max: model.productSugges![index]
                                                  .amount)));
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12),
                                          ),
                                          color: Colors.red),
                                      child: const Padding(
                                        padding: EdgeInsets.all(4.0),
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
                    itemCount: model.productSugges!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  );
                }
                return const SizedBox();
              },
              bloc: blocListSuggest,
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder(builder: (_,StateBloc state){
              if(state is LoadSuccess){
                List<Prod> model = state.data;
                String title=state.data2;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: StyleApp.textStyle700(
                            color: ColorApp.darkGreen, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: model.length > 0
                          ? MediaQuery.of(context).size.height * 0.36
                          : 0,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          BlocCartLocal blocCartLocal = BlocCartLocal();
                          return InkWell(
                            onTap: () {
                              context.read<BlocCartLocal>().add(GetCart());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoProdScreen(
                                        id: model[index].id
                                            .toString(),
                                        cateID: state.data3,
                                      )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height:
                                        MediaQuery.of(context).size.height * 0.34,
                                        width:
                                        MediaQuery.of(context).size.width * 0.47,
                                        decoration: BoxDecoration(
                                            border:
                                            Border.all(color: ColorApp.grey4F),
                                            borderRadius: BorderRadius.circular(12)),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.24,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.47,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(12),
                                                        topRight:
                                                        Radius.circular(12)),
                                                    child: LoadImage(
                                                      fit: BoxFit.fill,
                                                      url:
                                                      '${Const.image_host}${model[index].thumbnail}',
                                                    ),
                                                  ),
                                                ),
                                                // CircleAvatar(
                                                //   backgroundColor: Color(
                                                //             0xffCD2027),
                                                //   child: Text(
                                                //     ' - ${model.mostSaleProduct![index].discount} ',
                                                //     style: StyleApp
                                                //         .textStyle500(
                                                //         color: Colors
                                                //             .white),
                                                //   ),
                                                // ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                          Radius.circular(
                                                              12)),
                                                      image: DecorationImage(
                                                          scale: 0.2,
                                                          image: ExactAssetImage(
                                                              'assets/images/giam.png',
                                                              scale: 0.2),
                                                          fit: BoxFit.fill)),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          ' - ${model[index].discount} ',
                                                          style:
                                                          StyleApp.textStyle700(
                                                              color: ColorApp
                                                                  .redText),
                                                        ),
                                                        Text(
                                                          'GIẢM',
                                                          style:
                                                          StyleApp.textStyle700(
                                                              color:
                                                              Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // Text(
                                                  //   model
                                                  //           .mostSaleProduct![
                                                  //               index]
                                                  //           .code ??
                                                  //       '',
                                                  //   style: StyleApp
                                                  //       .textStyle600(),
                                                  // ),
                                                  Text(
                                                    model[index]
                                                        .name ??
                                                        '',
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    style: StyleApp.textStyle500(),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Text(
                                                        '${Const.convertPrice('${'${model[index].price}'}')} đ',
                                                        style: StyleApp.textStyle500(
                                                            decoration: TextDecoration
                                                                .lineThrough),
                                                      ),
                                                      Text(
                                                        '${Const.ConvertPrice.format(int.parse('${model[index].discountPrice}'))} đ',
                                                        style: StyleApp.textStyle700(
                                                            color: ColorApp.redText),
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
                                                  topRight: Radius.circular(12)),
                                              color: Colors.red),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 5),
                                            child: Text(
                                              'Còn lại : ${model[index].amount}',
                                              style: StyleApp.textStyle500(
                                                  color: Colors.white, fontSize: 12),
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
                                          context
                                              .read<BlocCartLocal>()
                                              .add(GetCart());
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
                                                  id: model
                                                  [index].id,
                                                  amount: 1,
                                                  max: model
                                                  [index]
                                                      .amount)));
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                bottomRight: Radius.circular(12),
                                              ),
                                              color: Colors.red),
                                          child: const Padding(
                                            padding: EdgeInsets.all(4.0),
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
                        scrollDirection: Axis.horizontal,
                        itemCount: model.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            },bloc: blocListPro0,),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder(builder: (_,StateBloc state){
              if(state is LoadSuccess){
                List<Prod> model = state.data;
                String title=state.data2;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: StyleApp.textStyle700(
                            color: ColorApp.darkGreen, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: model.length > 0
                          ? MediaQuery.of(context).size.height * 0.36
                          : 0,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          BlocCartLocal blocCartLocal = BlocCartLocal();
                          return InkWell(
                            onTap: () {
                              context.read<BlocCartLocal>().add(GetCart());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoProdScreen(
                                        id: model[index].id
                                            .toString(),
                                        cateID: state.data3,
                                      )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height:
                                        MediaQuery.of(context).size.height * 0.34,
                                        width:
                                        MediaQuery.of(context).size.width * 0.47,
                                        decoration: BoxDecoration(
                                            border:
                                            Border.all(color: ColorApp.grey4F),
                                            borderRadius: BorderRadius.circular(12)),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              alignment: Alignment.topRight,
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.24,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.47,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                        Radius.circular(12),
                                                        topRight:
                                                        Radius.circular(12)),
                                                    child: LoadImage(
                                                      fit: BoxFit.fill,
                                                      url:
                                                      '${Const.image_host}${model[index].thumbnail}',
                                                    ),
                                                  ),
                                                ),
                                                // CircleAvatar(
                                                //   backgroundColor: Color(
                                                //             0xffCD2027),
                                                //   child: Text(
                                                //     ' - ${model.mostSaleProduct![index].discount} ',
                                                //     style: StyleApp
                                                //         .textStyle500(
                                                //         color: Colors
                                                //             .white),
                                                //   ),
                                                // ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                          Radius.circular(
                                                              12)),
                                                      image: DecorationImage(
                                                          scale: 0.2,
                                                          image: ExactAssetImage(
                                                              'assets/images/giam.png',
                                                              scale: 0.2),
                                                          fit: BoxFit.fill)),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          ' - ${model[index].discount} ',
                                                          style:
                                                          StyleApp.textStyle700(
                                                              color: ColorApp
                                                                  .redText),
                                                        ),
                                                        Text(
                                                          'GIẢM',
                                                          style:
                                                          StyleApp.textStyle700(
                                                              color:
                                                              Colors.white),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // Text(
                                                  //   model
                                                  //           .mostSaleProduct![
                                                  //               index]
                                                  //           .code ??
                                                  //       '',
                                                  //   style: StyleApp
                                                  //       .textStyle600(),
                                                  // ),
                                                  Text(
                                                    model[index]
                                                        .name ??
                                                        '',
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    style: StyleApp.textStyle500(),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Text(
                                                        '${Const.convertPrice('${'${model[index].price}'}')} đ',
                                                        style: StyleApp.textStyle500(
                                                            decoration: TextDecoration
                                                                .lineThrough),
                                                      ),
                                                      Text(
                                                        '${Const.ConvertPrice.format(int.parse('${model[index].discountPrice}'))} đ',
                                                        style: StyleApp.textStyle700(
                                                            color: ColorApp.redText),
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
                                                  topRight: Radius.circular(12)),
                                              color: Colors.red),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 5),
                                            child: Text(
                                              'Còn lại : ${model[index].amount}',
                                              style: StyleApp.textStyle500(
                                                  color: Colors.white, fontSize: 12),
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
                                          context
                                              .read<BlocCartLocal>()
                                              .add(GetCart());
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
                                                  id: model
                                                  [index].id,
                                                  amount: 1,
                                                  max: model
                                                  [index]
                                                      .amount)));
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                bottomRight: Radius.circular(12),
                                              ),
                                              color: Colors.red),
                                          child: const Padding(
                                            padding: EdgeInsets.all(4.0),
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
                        scrollDirection: Axis.horizontal,
                        itemCount: model.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                );
              }
              return SizedBox();
            },bloc: blocListPro1,),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
