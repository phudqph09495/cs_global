
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_detailOrder.dart';
import '../../model/model_listCate.dart';
import '../../model/model_listDonHang.dart';
import '../../model/model_listSug.dart';
import '../../model/model_login.dart';

import '../event_bloc.dart';
import '../state_bloc.dart';
import 'model_ctgt.dart';
import 'model_dsGTtoken.dart';

class BlocChiTietGT extends Bloc<EventBloc, StateBloc> {
  BlocChiTietGT() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      yield Loading();
      try {



        var res = await Api.getAsync(endPoint: ApiPath.chiTietGT+event.param);

        // yield LoadSuccess(
        // );
        print(res);
        if (res['status'] == 'success'){

          ModelChiTietGT model=ModelChiTietGT.fromJson(res['data']);


          yield LoadSuccess(
              data: model
          );
        } else if (res['status'] == 'error') {

          yield LoadFail(error: res['message'] ?? "Lỗi kết nối");
        }
      } on DioError catch (e) {
        yield LoadFail(error: e.error.error);
      } catch (e) {
        print(e);
        yield LoadFail(error: e.toString());
      }
    }
  }
}
