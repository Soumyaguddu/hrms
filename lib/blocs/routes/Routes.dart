
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/blocs/ui/home/benefits/benefit_page.dart';
import 'package:hrms/blocs/ui/home/documents/document_first.dart';
import 'package:hrms/blocs/ui/home/earnings/earning_page.dart';
import 'package:hrms/blocs/ui/home/loan/loan_page.dart';
import 'package:hrms/blocs/ui/home/loan/loan_request_page.dart';
import 'package:hrms/blocs/ui/home/pay_slip/data/pay_slip_list_data.dart';
import 'package:hrms/blocs/ui/home/salary/salary_page.dart';

import '../ui/auth/login_screen.dart';
import '../ui/auth/otp_screen.dart';
import '../ui/home/documents/document_listing_page.dart';
import '../ui/home/home.dart';
import '../ui/home/loan/loan_listing_page.dart';
import '../ui/home/pay_slip/pay_slip.dart';
import '../ui/home/pay_slip/pay_slip_list_screen.dart';
import '../ui/splash/splash_screen.dart';

class Routes {

  static const String splash = "/splash";
  static const String login = "/login";
  static const String otp = "/otp";
  static const String home = "/home";
  static const String salary = "/salary";
  static const String pay_slip = "/pay_slip";
  static const String pay_slip_listing = "/pay_slip_listing";
  static const String earning = "/earning";
  static const String benefit = "/benefit";
  static const String loan = "/loan";
  static const String loan_details = "/loan_details";
  static const String loan_request = "/loan_request";
  static const String attendance = "/attendance";
  static const String document = "/document";
  static const String document_listing = "/document_listing";

  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {

        case splash:
        return MaterialPageRoute(
            builder: (context) => const SplashScreen());

        case login:
        return MaterialPageRoute(
            builder: (context) => const LoginScreen());
      case otp:
        return MaterialPageRoute(
            builder: (context) => const OTPScreen());
        case home:
        return MaterialPageRoute(
            builder: (context) => const HomePage());
        case salary:
        return MaterialPageRoute(
            builder: (context) =>  SalaryStructurePage());
        case pay_slip:
        return MaterialPageRoute(
            builder: (context) =>  PayslipPage(PaySlipListData(allowanceDetails: List.empty(),gross_salary: '',monthName: '',payable_salary: '',total_deduction: '',yearName: '',emp_code: '',emp_name: '',basic_salary: '',epf_amount: '',pTaxAmount: '',esi_amount: '',payable_days: '',ncp_days: '')));
        case pay_slip_listing:
        return MaterialPageRoute(
            builder: (context) =>  PaySlipListingPage());
        case earning:
        return MaterialPageRoute(
            builder: (context) =>  EarningPage());
        case benefit:
        return MaterialPageRoute(
            builder: (context) =>  EPFPage());
        case loan:
        return MaterialPageRoute(
            builder: (context) =>  LoanListingPage());
        case loan_details:
        return MaterialPageRoute(
            builder: (context) =>  LoanPage());
        case loan_request:
        return MaterialPageRoute(
            builder: (context) =>  LoanRequestPage());
        case attendance:
        return MaterialPageRoute(
            builder: (context) =>  DocumentListPage());
        case document:
        return MaterialPageRoute(
            builder: (context) =>  DocumentListPage());
        case document_listing:
        return MaterialPageRoute(
            builder: (context) =>  DocumentPaySlipWiseListPage());
    }
    return null;
  }
}
