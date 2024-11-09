
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/blocs/ui/home/salary/salary_page.dart';

import '../ui/auth/login_screen.dart';
import '../ui/home/home.dart';
import '../ui/home/pay_slip/pay_slip.dart';
import '../ui/splash/splash_screen.dart';

class Routes {

  static const String splash = "/splash";
  static const String login = "/login";
  static const String home = "/home";
  static const String salary = "/salary";
  static const String pay_slip = "/pay_slip";

  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {

        case splash:
        return MaterialPageRoute(
            builder: (context) => const SplashScreen());

        case login:
        return MaterialPageRoute(
            builder: (context) => const LoginScreen());
        case home:
        return MaterialPageRoute(
            builder: (context) => const HomePage());
        case salary:
        return MaterialPageRoute(
            builder: (context) =>  SalaryStructurePage());
        case pay_slip:
        return MaterialPageRoute(
            builder: (context) =>  PayslipPage());
    }
    return null;
  }
}
