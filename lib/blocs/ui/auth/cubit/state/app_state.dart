class AppState {}

class AppInitialState extends AppState {}

class AppLoadingState extends AppState {}

class AppSuccessState extends AppState {
  final bool isDialogShown;
  AppSuccessState({this.isDialogShown = false});

  AppSuccessState copyWith({bool? isDialogShown}) {
    return AppSuccessState(
      isDialogShown: isDialogShown ?? this.isDialogShown,
    );
  }
}
class AppErrorState extends AppState {
  final String errorMessage;
  AppErrorState(this.errorMessage);
}
class AppDeleteInitialState extends AppState {}