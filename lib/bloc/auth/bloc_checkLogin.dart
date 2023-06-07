import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/path/share_pref_path.dart';
import '../../config/share_pref.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocCheckLogin extends Bloc<EventBloc, StateBloc> {
  BlocCheckLogin() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      bool check = await SharedPrefs.readBool(SharePrefsKeys.login) ?? false;

      yield LoadSuccess(
        data: check,
      );
    }
  }
}