import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStateInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void getChange({bool? formShared}) {
    if (formShared != null) {
      isDark = formShared;
    } else {
      isDark = !isDark;
    }

    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeModeState());
    });
  }
}
