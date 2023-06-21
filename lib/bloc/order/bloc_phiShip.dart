import 'package:cs_global/model/model_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_huyen.dart';
import '../../model/model_login.dart';

import '../../model/model_ship.dart';
import '../../model/model_tinh.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocPhiShip extends Bloc<EventBloc, StateBloc> {
  BlocPhiShip() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      yield Loading();
      try {

        var res = await Api.getAsync(
          endPoint:
              '${ApiPath.phiVanCHuyen}${event.huyen}&regionId=${event.tinh}',
        );

        if (res['status'] == 'success') {
          ModelShip modelShip=ModelShip.fromJson(res['data']);
          yield LoadSuccess(
           data:modelShip
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