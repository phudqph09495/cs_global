import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_listPro.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../model/model_listPro.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadfaild.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocListPro.add(GetData(param: widget.id.toString()));
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
      body: SingleChildScrollView(
        child: BlocBuilder(
            bloc: blocListPro,
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
                ModelListPro model = state.data;
                return GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 0,
                      mainAxisExtent:
                          MediaQuery.of(context).size.height * 0.33),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.33,
                            width: MediaQuery.of(context).size.width * 0.48,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.19,
                                    width: MediaQuery.of(context).size.width *
                                        0.48 ,
                                    child: LoadImage(fit: BoxFit.cover,
                                      url:
                                          '${Const.image_host}${model.products!.data![index].thumbnail}',
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          model.products!.data![index].code??'',
                                          style: StyleApp.textStyle600(),
                                        ),
                                        Text(
                                          model.products!.data![index].name ??
                                              '',
                                          style: StyleApp.textStyle500(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Giá bán: ',
                                              style: StyleApp.textStyle500(),
                                            ),
                                            Text(
                                              '${Const.ConvertPrice.format(int.parse('${model.products!.data![index].price}'))}',
                                              style: StyleApp.textStyle700(
                                                  color: ColorApp.redText),
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
                          Container(
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
                                color: Colors.white,size: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: model.products!.data!.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                );
              }
              return Container();
            }),
      ),
    );
  }
}
