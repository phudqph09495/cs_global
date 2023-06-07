class StateBloc {}

class Loading extends StateBloc {}

class LoadSuccess extends StateBloc {
  String? mess;
  dynamic data;
  dynamic data2;
String? token;
  String? code;
  int? page;
  bool hasMore;
  bool cuoi;
  bool checkLength;


  LoadSuccess({
    this.data,
    this.hasMore = false,
    this.token,
    this.code,
    this.mess,
    this.data2,this.page,this.cuoi=false,
    this.checkLength = false,
  });
}

class LoadFail extends StateBloc {
  final String error;
  dynamic data;
  LoadFail({
    this.data,
    required this.error,
  });
}
class LoadFail2 extends StateBloc{
  final String error;

  LoadFail2({
    required this.error,
  });
}
class LoadFail3 extends StateBloc{
  final String error;

  LoadFail3({
    required this.error,
  });
}
class LoadFail4 extends StateBloc{
  final String error;

  LoadFail4({
    required this.error,
  });
}

class LoadMore extends StateBloc {}

class LoadMoreSucces extends StateBloc {}
