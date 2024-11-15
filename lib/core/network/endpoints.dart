class Endpoints {

  static bool isStaging = false;

  static const String _apiProdBaseUrl = "https://api-hrms.techwens.com/v1/api/";


  static String get apiBaseUrl => _apiProdBaseUrl;


  static const String login = 'payroll/signin';
  static const String salaryDetails = 'payroll/salaryDetails';
  static const String paySlipList = 'payroll/salaryDetailsPayshipYearly?';



  //STATUS CODES
  static const int codeSuccess = 200;
  static const int codeCreated = 201;
  static const int codeUnauthorized = 401;
}
