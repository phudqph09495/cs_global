import 'package:cs_global/model/model_listMostSale.dart';
import 'package:cs_global/model/model_listSug.dart';
import 'package:cs_global/widget/item/input/text_filed.dart';
import 'package:cs_global/widget/item/input/text_filed2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:group_button/group_button.dart';
import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/cart/bloc_cart.dart';
import '../../bloc/cart/event_bloc2.dart';
import '../../bloc/cart/model_sp.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_listCate.dart';
import '../../bloc/product/bloc_listMostSale.dart';
import '../../bloc/product/bloc_listSuggest.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../config/path/share_pref_path.dart';
import '../../model/model_listCate.dart';
import '../../start.dart';
import '../../styles/init_style.dart';
import '../../widget/item/custom_toast.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';
import '../cart/gio_hang_screen.dart';
import 'infoPro_screen.dart';
import 'item/product_item.dart';
import 'listPro_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = GroupButtonController();
  BlocListCate blocListCate = BlocListCate()..add(GetData());
  BlocListSuggest blocListSuggest = BlocListSuggest()..add(GetData());
  List<String> listButton = ['Sản phẩm', 'Dịch vụ', 'Đào Tạo', 'HT Land'];
  int tab = 0;
  BlocListMostSale blocListMostSale = BlocListMostSale()..add(GetData());

  List<String> htLand = [
    'Giới thiệu HT LAND',
    'Sự kiện',
    'Khoá đào tạo BĐS',
    'Tin Tức',
    'Đối Tác'
  ];

  BlocProfile blocProfile = BlocProfile();

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
    blocProfile.add(GetData());
    context.read<BlocCartLocal>().add(GetCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: Image.asset('assets/images/img.png'),
                ),
                SizedBox(
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
                        child: InputText1(
                          colorShadow: Colors.transparent,
                          label: 'Tìm kiếm sản phẩm',
                          colorBg: ColorApp.green.withOpacity(0.5),
                          colorLabel: Colors.white,
                          hasLeading: true,
                          iconPreFix: const Icon(
                            Icons.search_outlined,
                            color: Colors.white,
                          ),
                        )),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.qr_code_scanner_outlined,
                            color: Colors.white,
                          ),
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
                                          builder: (context, StateBloc state) {
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
                          Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Icon(
                                  Icons.notifications_none_outlined,
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
                                      child: Text(
                                        '0',
                                        style: StyleApp.textStyle500(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
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
                        width: (MediaQuery.of(context).size.width - 16) / 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: selected ? ColorApp.redText : Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FaIcon(listIcon[index],
                                size: 12,
                                color:
                                    selected ? Colors.white : ColorApp.green),
                            Text(
                              listButton[index],
                              style: StyleApp.textStyle700(
                                  color: selected
                                      ? Colors.white
                                      : ColorApp.green1),
                            ),
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
          BlocBuilder(
            builder: (_, StateBloc state) {
              if (state is LoadFail) {
                Future.delayed(const Duration(seconds: 1), () async {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            state.error,
                            style: StyleApp.textStyle500(),
                          ),
                          actions: [
                            InkWell(
                              onTap: () async {
                                await SharePrefsKeys.removeAllKey();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StartScreen()));
                              },
                              child: Container(
                                  width: double.infinity,
                                  decoration:
                                      const BoxDecoration(color: Colors.green),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Quay lại trang đăng nhập',
                                      textAlign: TextAlign.center,
                                      style: StyleApp.textStyle500(
                                          color: Colors.white),
                                    ),
                                  )),
                            )
                          ],
                        );
                      });
                  // await SharePrefsKeys.removeAllKey();
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => StartScreen()));
                });
                return const SizedBox();
              }
              return const SizedBox();
            },
            bloc: blocProfile,
          ),
          tab == 0
              ? Expanded(
                  child: SingleChildScrollView(
                  child: Padding(
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
                                ModelListCate model = state.data;
                                return GridView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: model.categories!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10.0,
                                          mainAxisExtent: 160),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListProScreen(
                                                      id: model
                                                          .categories![index]
                                                          .id!,
                                                      title: model
                                                          .categories![index]
                                                          .name!,
                                                    ))).then((value) => context
                                            .read<BlocCartLocal>()
                                            .add(GetCart()));
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
                                              fit: BoxFit.cover,
                                              url: model.categories![index]
                                                          .image !=
                                                      null
                                                  ? '${Const.image_host}${model.categories![index].image}'
                                                  : '',
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              model.categories![index].name ??
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
                                      child: Image.network(
                                        'https://cdn.chanhtuoi.com/uploads/2023/04/lazada-sale-5-5.jpg',
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
                              itemCount: 10),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sản phẩm mua nhiều nhất',
                          style: StyleApp.textStyle700(
                              color: ColorApp.darkGreen, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocBuilder(
                          builder: (_, StateBloc state) {
                            if (state is LoadSuccess) {
                              ModelListMostSale model = state.data;
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.33,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    BlocCartLocal blocCartLocal =
                                        BlocCartLocal();
                                    return InkWell(
                                      onTap: () {
                                        context
                                            .read<BlocCartLocal>()
                                            .add(GetCart());
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    InfoProdScreen(
                                                      id: model
                                                          .mostSaleProduct![0]
                                                          .id
                                                          .toString(),
                                                      cateID: model
                                                          .mostSaleProduct![0]
                                                          .category![0]
                                                          .id
                                                          .toString(),
                                                    )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.33,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.43,
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.24,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.43,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topLeft: Radius
                                                                  .circular(12),
                                                              topRight: Radius
                                                                  .circular(
                                                                      12)),
                                                      child: LoadImage(
                                                        fit: BoxFit.cover,
                                                        url:
                                                            '${Const.image_host}${model.mostSaleProduct![0].thumbnail}',
                                                      ),
                                                    ),
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
                                                        //           .mostSaleProduct![
                                                        //               index]
                                                        //           .code ??
                                                        //       '',
                                                        //   style: StyleApp
                                                        //       .textStyle600(),
                                                        // ),
                                                        Text(
                                                          model.mostSaleProduct![0]
                                                                  .name ??
                                                              '',
                                                          maxLines: 2,
                                                          style: StyleApp
                                                              .textStyle500(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Giá bán: ',
                                                              style: StyleApp
                                                                  .textStyle500(),
                                                            ),
                                                            Text(
                                                              '${Const.ConvertPrice.format(int.parse('${model.mostSaleProduct![0].discountPrice}'))}',
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
                                            BlocListener(
                                              bloc: blocCartLocal,
                                              listener:
                                                  (context, StateBloc state) {
                                                if (state is LoadSuccess) {
                                                  context
                                                      .read<BlocCartLocal>()
                                                      .add(GetCart());
                                                  CustomToast.showToast(
                                                      context: context,
                                                      msg:
                                                          'Đã thêm vào giỏ hàng thành công',
                                                      duration: 1,
                                                      gravity:
                                                          ToastGravity.BOTTOM);
                                                }
                                              },
                                              child: InkWell(
                                                onTap: () {
                                                  blocCartLocal.add(AddData(
                                                      modelSanPhamMain:
                                                          ModelSanPhamMain(
                                                              id: model
                                                                  .mostSaleProduct![
                                                                      0]
                                                                  .id,
                                                              amount: 1,
                                                              max: model
                                                                  .mostSaleProduct![
                                                                      0]
                                                                  .amount)));
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    12),
                                                          ),
                                                          color: Colors.red),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Icon(
                                                      Icons
                                                          .shopping_cart_outlined,
                                                      color: Colors.white,
                                                      size: 18,
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
                                  itemCount: 5,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
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
                        Text(
                          'Sản phẩm E - commerce đề xuất',
                          style: StyleApp.textStyle700(
                              color: ColorApp.darkGreen, fontSize: 18),
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
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        mainAxisExtent:
                                            MediaQuery.of(context).size.height *
                                                0.33),
                                itemBuilder: (context, index) {
                                  BlocCartLocal blocCartLocal = BlocCartLocal();
                                  return InkWell(
                                    onTap: () {
                                      context
                                          .read<BlocCartLocal>()
                                          .add(GetCart());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InfoProdScreen(
                                                    id: model
                                                        .productSugges![index]
                                                        .id
                                                        .toString(),
                                                    cateID: model
                                                        .productSugges![index]
                                                        .category![0]
                                                        .id
                                                        .toString(),
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.33,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.43,
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.24,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.43,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12),
                                                            topRight:
                                                                Radius.circular(
                                                                    12)),
                                                    child: LoadImage(
                                                      fit: BoxFit.cover,
                                                      url:
                                                          '${Const.image_host}${model.productSugges![index].thumbnail}',
                                                    ),
                                                  ),
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
                                                                .productSugges![
                                                                    index]
                                                                .name ??
                                                            '',
                                                        maxLines: 2,
                                                        style: StyleApp
                                                            .textStyle500(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Giá bán: ',
                                                            style: StyleApp
                                                                .textStyle500(),
                                                          ),
                                                          Text(
                                                            '${Const.ConvertPrice.format(int.parse('${model.productSugges![index].discountPrice}'))}',
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
                                          BlocListener(
                                            bloc: blocCartLocal,
                                            listener:
                                                (context, StateBloc state) {
                                              if (state is LoadSuccess) {
                                                context
                                                    .read<BlocCartLocal>()
                                                    .add(GetCart());
                                                CustomToast.showToast(
                                                    context: context,
                                                    msg:
                                                        'Đã thêm vào giỏ hàng thành công',
                                                    duration: 1,
                                                    gravity:
                                                        ToastGravity.BOTTOM);
                                              }
                                            },
                                            child: InkWell(
                                              onTap: () {
                                                blocCartLocal.add(AddData(
                                                    modelSanPhamMain:
                                                        ModelSanPhamMain(
                                                            id: model
                                                                .productSugges![
                                                                    index]
                                                                .id,
                                                            amount: 1,
                                                            max: model
                                                                .productSugges![
                                                                    index]
                                                                .amount)));
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12),
                                                      bottomRight:
                                                          Radius.circular(12),
                                                    ),
                                                    color: Colors.red),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons
                                                        .shopping_cart_outlined,
                                                    color: Colors.white,
                                                    size: 18,
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
                      ],
                    ),
                  ),
                ))
              : const SizedBox(),
          tab == 3
              ? Expanded(
                  child: SingleChildScrollView(
                  child: Padding(
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
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: htLand.length,
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
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    height: 100,
                                    child: SvgPicture.asset(
                                        'assets/svg/htland${index}.svg'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      htLand[index],
                                      style: StyleApp.textStyle500(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Sản phẩm mua nhiều nhất',
                          style: StyleApp.textStyle700(
                              color: ColorApp.darkGreen, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocBuilder(
                          builder: (_, StateBloc state) {
                            if (state is LoadSuccess) {
                              ModelListMostSale model = state.data;
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.33,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    BlocCartLocal blocCartLocal =
                                        BlocCartLocal();
                                    return InkWell(
                                      onTap: () {
                                        context
                                            .read<BlocCartLocal>()
                                            .add(GetCart());
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    InfoProdScreen(
                                                      id: model
                                                          .mostSaleProduct![
                                                              index]
                                                          .id
                                                          .toString(),
                                                      cateID: model
                                                          .mostSaleProduct![
                                                              index]
                                                          .category![0]
                                                          .id
                                                          .toString(),
                                                    )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.33,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.48,
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.19,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.48,
                                                      child: LoadImage(
                                                        fit: BoxFit.cover,
                                                        url:
                                                            '${Const.image_host}${model.mostSaleProduct![index].thumbnail}',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.12,
                                                    child: Padding(
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
                                                          Text(
                                                            model
                                                                    .mostSaleProduct![
                                                                        index]
                                                                    .code ??
                                                                '',
                                                            style: StyleApp
                                                                .textStyle600(),
                                                          ),
                                                          Text(
                                                            model
                                                                    .mostSaleProduct![
                                                                        index]
                                                                    .name ??
                                                                '',
                                                            style: StyleApp
                                                                .textStyle500(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Giá bán: ',
                                                                style: StyleApp
                                                                    .textStyle500(),
                                                              ),
                                                              Text(
                                                                '${Const.ConvertPrice.format(int.parse('${model.mostSaleProduct![index].discountPrice}'))}',
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
                                                  ),
                                                ],
                                              ),
                                            ),
                                            BlocListener(
                                              bloc: blocCartLocal,
                                              listener:
                                                  (context, StateBloc state) {
                                                if (state is LoadSuccess) {
                                                  context
                                                      .read<BlocCartLocal>()
                                                      .add(GetCart());
                                                  CustomToast.showToast(
                                                      context: context,
                                                      msg:
                                                          'Đã thêm vào giỏ hàng thành công',
                                                      duration: 1,
                                                      gravity:
                                                          ToastGravity.BOTTOM);
                                                }
                                              },
                                              child: InkWell(
                                                onTap: () {
                                                  blocCartLocal.add(AddData(
                                                      modelSanPhamMain:
                                                          ModelSanPhamMain(
                                                              id: model
                                                                  .mostSaleProduct![
                                                                      index]
                                                                  .id,
                                                              amount: 1,
                                                              max: model
                                                                  .mostSaleProduct![
                                                                      index]
                                                                  .amount)));
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    12),
                                                          ),
                                                          color: Colors.red),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Icon(
                                                      Icons
                                                          .shopping_cart_outlined,
                                                      color: Colors.white,
                                                      size: 18,
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
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
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
                        Text(
                          'Sản phẩm E - commerce đề xuất',
                          style: StyleApp.textStyle700(
                              color: ColorApp.darkGreen, fontSize: 18),
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
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        mainAxisExtent:
                                            MediaQuery.of(context).size.height *
                                                0.33),
                                itemBuilder: (context, index) {
                                  BlocCartLocal blocCartLocal = BlocCartLocal();
                                  return InkWell(
                                    onTap: () {
                                      context
                                          .read<BlocCartLocal>()
                                          .add(GetCart());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InfoProdScreen(
                                                    id: model
                                                        .productSugges![index]
                                                        .id
                                                        .toString(),
                                                    cateID: model
                                                        .productSugges![index]
                                                        .category![0]
                                                        .id
                                                        .toString(),
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.33,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.48,
                                            decoration: BoxDecoration(
                                                border: Border.all(),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.19,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.48,
                                                    child: LoadImage(
                                                      fit: BoxFit.cover,
                                                      url:
                                                          '${Const.image_host}${model.productSugges![index].thumbnail}',
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.12,
                                                  child: Padding(
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
                                                        Text(
                                                          model
                                                                  .productSugges![
                                                                      index]
                                                                  .code ??
                                                              '',
                                                          style: StyleApp
                                                              .textStyle600(),
                                                        ),
                                                        Text(
                                                          model
                                                                  .productSugges![
                                                                      index]
                                                                  .name ??
                                                              '',
                                                          style: StyleApp
                                                              .textStyle500(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Giá bán: ',
                                                              style: StyleApp
                                                                  .textStyle500(),
                                                            ),
                                                            Text(
                                                              '${Const.ConvertPrice.format(int.parse('${model.productSugges![index].discountPrice}'))}',
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
                                                ),
                                              ],
                                            ),
                                          ),
                                          BlocListener(
                                            bloc: blocCartLocal,
                                            listener:
                                                (context, StateBloc state) {
                                              if (state is LoadSuccess) {
                                                context
                                                    .read<BlocCartLocal>()
                                                    .add(GetCart());
                                                CustomToast.showToast(
                                                    context: context,
                                                    msg:
                                                        'Đã thêm vào giỏ hàng thành công',
                                                    duration: 1,
                                                    gravity:
                                                        ToastGravity.BOTTOM);
                                              }
                                            },
                                            child: InkWell(
                                              onTap: () {
                                                blocCartLocal.add(AddData(
                                                    modelSanPhamMain:
                                                        ModelSanPhamMain(
                                                            id: model
                                                                .productSugges![
                                                                    index]
                                                                .id,
                                                            amount: 1,
                                                            max: model
                                                                .productSugges![
                                                                    index]
                                                                .amount)));
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12),
                                                      bottomRight:
                                                          Radius.circular(12),
                                                    ),
                                                    color: Colors.red),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons
                                                        .shopping_cart_outlined,
                                                    color: Colors.white,
                                                    size: 18,
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
                      ],
                    ),
                  ),
                ))
              : const SizedBox()
        ],
      ),
    );
  }
}
