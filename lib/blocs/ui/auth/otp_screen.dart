import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrms/blocs/ui/auth/cubit/auth_cubit.dart';
import 'package:hrms/constants/ColorConstant.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../constants/ImageConstant.dart';
import '../../routes/Routes.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  bool isPasswordVisible = false;
  TextEditingController otpNewController=TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(

        children: [
          // Background image
          Container(
            height: 450,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstant.background), // Replace with your background image
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstant.box_fill_color, // Background color of the circular container
                      ),
                      padding: EdgeInsets.all(12), // Adjust padding for size of the circle
                      child: Image(image: AssetImage(ImageConstant.otp_mobile_banking),),
                    ),



                    const SizedBox(height: 16),
                    const Text(
                      "OTP Verification",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),

                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 20,
                        ),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          obscureText: false,

                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 40,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                            inactiveFillColor:Colors.white,
                            selectedColor:Colors.grey,
                            activeColor:Colors.grey,
                            inactiveColor:Colors.grey,
                            selectedFillColor:Colors.white,

                          ),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: otpNewController,
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            debugPrint("Completed");
                          },

                          onChanged: (value) {
                            debugPrint(value);
                            setState(() {
                              otpNewController.text = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              hasError = false;
                            });
                            Navigator.pushReplacementNamed(context, Routes.home);

                          } else {
                            setState(() {
                              hasError = true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.themeColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Text(
                          "Verify",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don’t receive code? ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black, // Set this color to match your theme
                            ),
                          ),
                          TextSpan(
                            text: "Request again",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.themeColor, // Blue color for "Request again"
                            ),
                          ),
                        ],
                      ),
                    )
                    ,
                  ],
                ),
              ),
            ),
          ),
          // Footer branding

        ],
      ),
    );
  }

}
