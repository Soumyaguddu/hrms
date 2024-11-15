
import 'package:dio/dio.dart';
import 'package:hrms/data/api/hrms_api.dart';

import '../../../../core/network/endpoints.dart';
import '../pay_slip/data/pay_slip_list_data.dart';
import '../salary/data/SalaryDetailsData.dart';

class HomeRepository{


  HrmsApi api = HrmsApi();
  Future<SalaryResponseData> fetchSalary() async {
    try {
      // Send the request and get the response
      Response response = await api.sendRequest.get("${Endpoints.salaryDetails}");
      Map<String, dynamic> responseData = response.data['data'];

      // Parse the JSON to a SalaryResponseData object
      return SalaryResponseData.fromJson(responseData);
    } catch (ex) {
      throw ex;
    }
  }
  Future<List<PaySlipListData>> fetchPaySlip(String selectedYear,String establishmentType) async {
    try {


      Response response =  await api.sendRequest.get("${Endpoints.paySlipList}year=$selectedYear&leave_type=$establishmentType");
      Map<String, dynamic> responseData = response.data;
      List<dynamic> postMaps = responseData['data'];
      return postMaps.map((postMap) => PaySlipListData.fromJson(postMap)).toList();


    } catch (ex) {
      throw ex;
    }
  }



}