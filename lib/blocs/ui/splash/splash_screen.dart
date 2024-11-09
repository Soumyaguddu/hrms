import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/ColorConstant.dart';
import '../../../constants/ImageConstant.dart';
import '../../routes/Routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate after 3 seconds delay
    Future.delayed(const Duration(seconds: 3), () async {
     // String token = await getToken();
     // print('token====$token');

      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.themeColor,
      body: Container(
        padding: const EdgeInsets.all(16),
        child:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SvgPicture.asset(
                  ImageConstant.hrms_icon,
                  height: 200,
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Welcome to HRMS System',
                  style: TextStyle(color: Colors.black, fontSize: 24,fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
             
            ],
          ),
        ),
      ),
    );
  }
}
