import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/blocs/ui/home/data/user_profile_data.dart';
import 'package:hrms/blocs/ui/home/pay_slip/data/pay_slip_list_data.dart';
import 'package:hrms/blocs/ui/home/repositories/HomeRepositories.dart';
import 'package:hrms/blocs/ui/home/salary/data/SalaryDetailsData.dart';
class HomeSalaryCubit extends Cubit<SalaryAndPaySlipState> {
  HomeSalaryCubit() : super(SalaryAndPaySlipLoadingState());

  HomeRepository homeRepository = HomeRepository();

  Future<void> fetchSalary() async {
    emit(SalaryAndPaySlipLoadingState());

    try {
      SalaryResponseData salaryData = await homeRepository.fetchSalary();
      emit(SalaryAndPaySlipLoadedState(salaryData: salaryData));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(SalaryAndPaySlipErrorState("Can't fetch salary details, please check your internet connection!"));
      } else {
        emit(SalaryAndPaySlipErrorState(ex.type.toString()));
      }
    }
  }

  Future<void> fetchPaySlip(String selectedYear,String establishmentType) async {
    emit(SalaryAndPaySlipLoadingState());

    try {
      List<PaySlipListData>  paySlipData = await homeRepository.fetchPaySlip(selectedYear,establishmentType);
      emit(SalaryAndPaySlipLoadedState(paySlipData: paySlipData));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(SalaryAndPaySlipErrorState("Can't fetch payslip details, please check your internet connection!"));
      } else {
        emit(SalaryAndPaySlipErrorState(ex.type.toString()));
      }
    }
  }
  Future<void> fetchUserInformation() async {
    emit(SalaryAndPaySlipLoadingState());

    try {
      UserProfileData userProfileData = await homeRepository.fetchUserProfile();
      emit(SalaryAndPaySlipLoadedState(userProfileData: userProfileData));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        emit(SalaryAndPaySlipErrorState("Can't fetch salary details, please check your internet connection!"));
      } else {
        emit(SalaryAndPaySlipErrorState(ex.type.toString()));
      }
    }
  }
}

abstract class SalaryAndPaySlipState {}

class SalaryAndPaySlipLoadingState extends SalaryAndPaySlipState {}

class SalaryAndPaySlipLoadedState extends SalaryAndPaySlipState {
  final SalaryResponseData? salaryData;
  final UserProfileData? userProfileData;
  final List<PaySlipListData>? paySlipData;

  SalaryAndPaySlipLoadedState({this.salaryData, this.userProfileData,this.paySlipData});
}

class SalaryAndPaySlipErrorState extends SalaryAndPaySlipState {
  final String error;
  SalaryAndPaySlipErrorState(this.error);
}

