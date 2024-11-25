import 'package:flutter/cupertino.dart';
import 'package:hrms/data/api/hrms_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/helper/SnackbarHelper.dart';
import '../../../../core/network/endpoints.dart';
import '../../../routes/Routes.dart';

class Authrepository{
  final HrmsApi api = HrmsApi();

  Future<void> login({
    required BuildContext context, // Add context to show SnackBar
    required String mobile,
    required String password,
    required Function onSuccess,
    required Function onError,
  })
  async {
    try {
      // Print the data you're about to send (for debugging)
      print('Sending data:');
      print('email: $mobile');

      final response = await api.sendRequest.post(
        Endpoints.login,
        data: {
          'phone': mobile,
          'password': password,
          'establishmentId': "05087ec1-11c3-42dc-8b6e-1e3c128079e2",
        },
      );

      // Print the full response for debugging
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
      if(response.statusCode==200)
      {
        if (response.data['statusCode']==200)
        {
          onSuccess();
          SharedPreferences prefs = await SharedPreferences.getInstance();

          // Example of storing a string or other data
          await prefs.setString('user_token', response.data['data']['token'] ?? '');
          await prefs.setString('doj', response.data['data']['user']['doj'] ?? '');
          await prefs.setString('empCode', response.data['data']['user']['EmpCode'] ?? '');
          await prefs.setString('empName', response.data['data']['user']['name'] ?? '');
          await prefs.setString('establishmentName', response.data['data']['user']['establishmentName'] ?? '');
          await prefs.setString('establishmentType', response.data['data']['user']['establishmentType'] ?? '');
          await prefs.setString('departmentName', response.data['data']['user']['Department']['departmentName'] ?? '');
          await prefs.setString('designation', response.data['data']['user']['Designation']['designation'] ?? '');
          String token = prefs.getString("user_token") ?? '';
          print('authToken===$token');
           Navigator.pushReplacementNamed(context, Routes.home);
          SnackbarHelper.showSnackBar(context,response.data['message']);
        }
        else
        {
          SnackbarHelper.showSnackBar(context,response.data['message']);
          onError();
        }



      }
      else
      {
        SnackbarHelper.showSnackBar(context,response.data['message']);
        onError();
      }
    } catch (e) {
      SnackbarHelper.showSnackBar(context,'Login Failed');
      print('Error: $e');
      onError();

    }
  }
}