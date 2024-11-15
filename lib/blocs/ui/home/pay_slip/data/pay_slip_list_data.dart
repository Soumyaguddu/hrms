class PaySlipListTopData {
  PaySlipListTopData({
    this.status,
    this.paySlipListData});

  PaySlipListTopData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    paySlipListData= (json['data'] as List)
        .map((item) => PaySlipListData.fromJson(item))
        .toList();

  }
  bool? status;
   List<PaySlipListData>? paySlipListData;


}

class PaySlipListData {
  final String emp_code;
  final String emp_name;
  final String monthName;
  final String yearName;
  final String gross_salary;
  final String total_deduction;
  final String payable_salary;
  final String basic_salary;
  final String epf_amount;
  final String esi_amount;
  final String pTaxAmount;
  final String payable_days;
  final String ncp_days;
  final List<AllowanceDetailData> allowanceDetails;

  PaySlipListData({
    required this.emp_code,
    required this.emp_name,
    required this.monthName,
    required this.yearName,
    required this.gross_salary,
    required this.total_deduction,
    required this.payable_salary,
    required this.basic_salary,
    required this.epf_amount,
    required this.esi_amount,
    required this.pTaxAmount,
    required this.payable_days,
    required this.ncp_days,
    required this.allowanceDetails,

  });

  factory PaySlipListData.fromJson(Map<String, dynamic> json) {
    return PaySlipListData(
      emp_code: json['emp_code'],
      emp_name: json['emp_name'],
      monthName: json['month'],
      yearName: json['year'],
      gross_salary: json['gross_salary'],
      total_deduction: json['total_deduction'],
      payable_salary: json['payable_salary'],
      basic_salary: json['basic_salary'],
      epf_amount: json['epf_amount'],
      esi_amount: json['esi_amount'],
      pTaxAmount: json['pTaxAmount'],
      payable_days: json['payable_days'],
      ncp_days: json['ncp_days'],
      allowanceDetails: (json['allowance'] as List)
          .map((item) => AllowanceDetailData.fromJson(item))
          .toList(),

    );
  }
}
class AllowanceDetailData {
  final String allowanceName;
  final int allowanceamount;

  AllowanceDetailData({
    required this.allowanceName,
    required this.allowanceamount,


  });

  factory AllowanceDetailData.fromJson(Map<String, dynamic> json) {
    return AllowanceDetailData(
      allowanceName: json['allowanceName'],
      allowanceamount: json['allowanceamount'],
    );
  }
}



