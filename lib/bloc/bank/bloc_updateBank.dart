import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_login.dart';

import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocUpdateBank extends Bloc<EventBloc, StateBloc> {
  BlocUpdateBank() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is UpdateBank) {
      yield Loading();
      try {
        Map<String, dynamic> req = Map();
        req['bank_name'] = event.bankName;
        req['bank_code'] = event.bankCode;
        req['bank_acc'] = event.bankAcc;
        req['acc_name']=event.bankAccName;

        var res = await Api.postAsync(
          endPoint: ApiPath.updateBank,
          req: req,
        );

        // yield LoadSuccess(
        // );
        if (res['status'] == 'success') {


          yield LoadSuccess(

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
