
import 'package:cs_global/bloc/bank/model_profileWallet.dart';
import 'package:cs_global/model/model_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_LSrutTien.dart';
import '../../model/model_login.dart';

import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocLSGD extends Bloc<EventBloc, StateBloc> {
  BlocLSGD() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      yield Loading();
      try {



        var res = await Api.getAsync(endPoint: ApiPath.lsGD, );
        // yield LoadSuccess(
        // );
        if (res['status'] == 'success'){

          ModelLichSuGD model = ModelLichSuGD.fromJson(res['data']);


          yield LoadSuccess(
            data: model,
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