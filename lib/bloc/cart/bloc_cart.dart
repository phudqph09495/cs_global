import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../config/path/share_pref_path.dart';
import '../../config/share_pref.dart';

import '../../model/model_infoPro.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';
import 'event_bloc2.dart';
import 'model_sp.dart';

class BlocCartLocal extends Bloc<EventBloc2, StateBloc> {
  BlocCartLocal() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc2 event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (event is AddData) {
      String jsonString = prefs.getString('cart') ?? '[]';
      List<ModelSanPhamMain> list = jsonString != "[]" && jsonString != ''
          ? List<ModelSanPhamMain>.from(
              jsonDecode(jsonString).map((x) => ModelSanPhamMain.fromJson(x)))
          : [];
      bool same=false;
      for(var item in list){
        if(event.modelSanPhamMain.id==item.id){
          same=true;
          item.amount =item.amount! +event.modelSanPhamMain.amount!;
        }
      }

     if(same==false){
       list.add(event.modelSanPhamMain);
     }

      jsonString = jsonEncode(list);
      prefs.setString('cart', jsonString);
      yield LoadSuccess(data: list);
    }
    if (event is GetCart) {
      String jsonString = prefs.getString('cart') ?? '[]';
      print(jsonString);
      int sum=0;
      int discount=0;
      List<ModelInfoPro> list=[];
      List<ModelSanPhamMain> objects = jsonString != '' && jsonString != '[]'
          ? List<ModelSanPhamMain>.from(
              jsonDecode(jsonString).map((x) => ModelSanPhamMain.fromJson(x)))
          : [];
     for(var item in objects){
       var res = await Api.getAsync(endPoint: ApiPath.infoPro+item.id.toString(),);
       if (res['status'] == 'success'){

         ModelInfoPro  model=ModelInfoPro.fromJson(res['data']);
         list.add(model);
sum=sum+item.amount!*int.parse('${model.product!.price}');


       }
     }
      yield LoadSuccess(
        data: objects,
        data2: sum,
        data3: list,
        data4: discount

      );
    }
    if (event is Reduce) {
      String jsonString = prefs.getString('cart') ?? '[]';

      List<ModelSanPhamMain> objects = jsonString != "[]" && jsonString != ''
          ? List<ModelSanPhamMain>.from(
              jsonDecode(jsonString).map((x) => ModelSanPhamMain.fromJson(x)))
          : [];

      List<int> idList = [];
      for (var item in objects) {
        idList.add(item.id??0);
      }
      for (var i = 0; i < objects.length; i++) {
        if (objects[i].id == (event.modelSanPhamMain.id)) {
          objects[i].amount=objects[i].amount!-1;
          if(objects[i].amount! <1){
            objects.removeAt(i);
          }
        }
      }
      jsonString = jsonEncode(objects);
      prefs.setString('cart', jsonString);
      yield LoadSuccess(
        data: objects,
      );
    }
    if (event is ClearAll) {
      String jsonString = await prefs.getString('cart') ?? '';
      print(jsonString);
      List<ModelSanPhamMain> objects = jsonString != "[]"
          ? List<ModelSanPhamMain>.from(
              jsonDecode(jsonString).map((x) => ModelSanPhamMain.fromJson(x)))
          : [];
      objects.clear();
      jsonString = jsonEncode(objects);
      prefs.setString('cart', jsonString);
    }
  }
}
