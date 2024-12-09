import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hrms/blocs/ui/auth/cubit/auth_cubit.dart';
import 'package:hrms/constants/ColorConstant.dart';

import '../../../constants/ImageConstant.dart';
import '../../routes/Routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  bool isPasswordVisible = false;
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
          Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageConstant.hrms_logo,height: 80,),

                      const SizedBox(height: 16),
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style: TextStyle(color: Colors.black87, fontSize: 18.0),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "",
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),

                          ),

                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null) {
                            return "Please enter an email id.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      const Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 5.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(color: Colors.black87, fontSize: 18.0),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "",
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white,

                        ),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                              ),
                              const Text("Remember me"),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to OTP login
                            },
                            child: const Text(
                              "Login with OTP",
                              style: TextStyle(
                                color: ColorConstant.themeColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                hasError = false;
                              });
                              context.read<AuthCubit>().login(
                                context: context,
                                mobileNumber: emailController.text.toString(),
                                password: passwordController.text.toString(),
                              );

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
                            "Log In",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
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
