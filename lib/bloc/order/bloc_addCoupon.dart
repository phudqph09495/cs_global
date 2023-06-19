
import 'package:cs_global/bloc/cart/event_bloc2.dart';
import 'package:cs_global/model/model_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_login.dart';

import '../../model/model_tinh.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocAddCoupon extends Bloc<EventBloc, StateBloc> {
  BlocAddCoupon() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      yield Loading();
      try {



        var res = await Api.getAsync(endPoint: ApiPath.testCounpon+event.param+'&totalProductPrice='+event.type, );
        // yield LoadSuccess(
        // );

        if (res['status'] == 'success'){

          Coupon  model = Coupon.fromJson(res['data']['coupon']);


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
