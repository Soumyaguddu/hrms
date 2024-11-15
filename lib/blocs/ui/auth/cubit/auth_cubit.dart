import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/blocs/ui/auth/cubit/state/app_state.dart';
import 'package:hrms/blocs/ui/auth/repositiries/AuthRepository.dart';

class AuthCubit  extends Cubit<AppState> {
  AuthCubit() : super(AppInitialState());

  void setDialogShown() {
    if (state is AppSuccessState) {
      emit((state as AppSuccessState).copyWith(isDialogShown: true));
    }
  }

  void resetState() {
    emit(AppInitialState());
  }
  void resetDeleteState() {
    emit(AppDeleteInitialState());
  }

  Authrepository alertRepository = Authrepository();



  Future<void> login({
    required BuildContext context,
    required String mobileNumber,
    required String password,

  })
  async {
    emit(AppLoadingState());

    try {
      // Call the save alert API through repository
      await alertRepository.login(
        context: context,
        mobile: mobileNumber,
        password: password,
        onSuccess: () {
          print("Login successfully!");
          emit(AppSuccessState());
        },
        onError: () {
          print("Login Failed");
          emit(AppErrorState("Login Failed"));
        },

      );
      //emit(AlertSuccessState());
    } catch (error) {
      emit(AppErrorState(error.toString()));
    }
  }
}