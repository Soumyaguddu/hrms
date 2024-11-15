class SalaryResponseData {
  final int ctc;
  final int ctcYearly;
  final int basicSalary;
  final List<AllowanceDetail> allowanceDetails;
  final int epfTotal;
  final int epfTotalWagesDeductions;
  final List<Deduction> deductions;

  SalaryResponseData({
    required this.ctc,
    required this.ctcYearly,
    required this.basicSalary,
    required this.allowanceDetails,
    required this.epfTotal,
    required this.epfTotalWagesDeductions,
    required this.deductions,
  });

  factory SalaryResponseData.fromJson(Map<String, dynamic> json) {
    return SalaryResponseData(
      ctc: json['CTC'],
      ctcYearly: json['CTCYearly'],
      basicSalary: json['BasicSalary'],
      allowanceDetails: (json['allowanceDetails'] as List)
          .map((item) => AllowanceDetail.fromJson(item))
          .toList(),
      epfTotal: json['epfTotal'],
      epfTotalWagesDeductions: json['epfTotalWagesDeductions'],
      deductions: (json['deductions'] as List)
          .map((item) => Deduction.fromJson(item))
          .toList(),
    );
  }
}

class AllowanceDetail {
  final String allowanceName;
  final dynamic amount;
  final bool epfWages;
  final bool esiWages;
  final bool isChecked;
  final String noWorkPay;

  AllowanceDetail({
    required this.allowanceName,
    required this.amount,
    required this.epfWages,
    required this.esiWages,
    required this.isChecked,
    required this.noWorkPay,
  });

  factory AllowanceDetail.fromJson(Map<String, dynamic> json) {
    return AllowanceDetail(
      allowanceName: json['allowanceName'],
      amount: json['amount'],
      epfWages: json['epf_wages'] == "true",
      esiWages: json['esi_wages'] == "true",
      isChecked: json['is_checked'],
      noWorkPay: json['no_work_pay'],
    );
  }
}

class Deduction {
  final String deductionsName;
  final bool isDeductions;
  final int amount;

  Deduction({
    required this.deductionsName,
    required this.isDeductions,
    required this.amount,
  });

  factory Deduction.fromJson(Map<String, dynamic> json) {
    return Deduction(
      deductionsName: json['deductionsName'],
      isDeductions: json['isDeductions'],
      amount: json['amount'],
    );
  }
}
