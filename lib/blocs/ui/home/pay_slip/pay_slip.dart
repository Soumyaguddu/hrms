import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hrms/blocs/ui/home/pay_slip/data/pay_slip_list_data.dart';
import 'package:hrms/core/helper/month_name_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/ColorConstant.dart';
import '../../../routes/Routes.dart';
import 'package:intl/intl.dart';
class PayslipPage extends StatefulWidget {
  PaySlipListData payslip;
  PayslipPage(this.payslip);

  @override
  State<PayslipPage> createState() => _PayslipPageState();
}

class _PayslipPageState extends State<PayslipPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginData();
  }
  String doj = '';
  String departmentName = '';
  String designation = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.themeColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.green_chart_color,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.pay_slip_listing);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            const Text(
              'Pay Slip',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt_outlined,color: Colors.white,),
            onPressed: () {
              // Define menu action here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Salary Slip downloaded')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Payslip Header Section
               Text(
                'Payslip for the Month of ${"${MonthNameHelper.getIdWiseMonthName((int.parse(widget.payslip.monthName)+1).toString())} ${widget.payslip.yearName}\nPaid Days: ${widget.payslip.payable_days}\nLOP Days: ${widget.payslip.ncp_days}"}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 2),
              const SizedBox(height: 10),
              // Payslip Details
              payslipItem('Employee Name', widget.payslip.emp_name),
              payslipItem('Employee ID', widget.payslip.emp_code),
              payslipItem('Designation', designation),
              payslipItem('Department', departmentName),
              payslipItem('Date of Joining', doj),
              const Divider(thickness: 2),
              const SizedBox(height: 20),

              // Salary Breakdown Chart
              const Text(
                'Salary Breakdown',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  // Left side: PieChart
                  const SizedBox(width: 20),

                  SizedBox(
                    height: 150,
                    width: 150,
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 40,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),

                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                           Text(
                            'Take Home',
                            style:
                            TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                        Text(
                          "₹${calculateEarningCTC(widget.payslip).toString()}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          Text(
                            'Deductions',
                            style:
                            TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                        Text(
                          "₹${widget.payslip.total_deduction.toString()}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],),
                      // Take Home Section


                      // Deduction Section
                     // salaryItem("Deductions", "₹5,000", isBold: true),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Detailed Salary Items
              const Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Earnings',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "₹${calculateMonthlyCTC(widget.payslip!)}",
                      style: TextStyle(
                        color: Colors.black ,
                        fontWeight: FontWeight.bold,
                        fontSize: 18 ,
                      ),
                    ),
                  ],
                ),
              ),
              salaryItem('Basic Pay',  "₹${widget.payslip.basic_salary.toString()}",),
              ...widget.payslip.allowanceDetails.map((allowance) =>
                  salaryItem(allowance.allowanceName, "₹${allowance.allowanceamount}")
              ).toList(),

              const Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Deductions',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "₹${calculateDeductionCTC(widget.payslip)}",
                      style: TextStyle(
                        color: Colors.black ,
                        fontWeight: FontWeight.bold,
                        fontSize: 18 ,
                      ),
                    ),
                  ],
                ),
              ),
              salaryItem("EPF Contribution", "₹${widget.payslip.epf_amount}"),
              salaryItem("Employee State Insurance", "₹${widget.payslip.esi_amount}"),
              salaryItem("Professional Tax", "₹${widget.payslip.pTaxAmount}"),
              const Divider(thickness: 2),
              salaryItem('Total Net Pay', '₹${calculateEarningCTC(widget.payslip)}', isBold: true),
            ],
          ),
        ),
      ),
    );
  }
  int calculateEarningCTC(PaySlipListData paySlipListData) {
    int totalEarnings = paySlipListData.allowanceDetails.fold(0, (sum, allowance) {
      return sum + (int.tryParse(allowance.allowanceamount.toString()) ?? 0);
    });

    return totalEarnings + int.parse(paySlipListData.basic_salary);
  }
  int calculateDeductionCTC(PaySlipListData paySlipListData) {


    int totalDeductions = int.parse(paySlipListData.esi_amount)+int.parse(paySlipListData.pTaxAmount)+int.parse(paySlipListData.epf_amount);


    return totalDeductions ;
  }
  int calculateMonthlyCTC(PaySlipListData paySlipListData) {
    int totalEarnings = paySlipListData.allowanceDetails.fold(0, (sum, allowance) {
      return sum + (int.tryParse(allowance.allowanceamount.toString()) ?? 0);
    });


    int totalDeductions = int.parse(paySlipListData.esi_amount)+int.parse(paySlipListData.pTaxAmount)+int.parse(paySlipListData.epf_amount);

    return totalEarnings +totalDeductions+ int.parse(paySlipListData.basic_salary);
  }

  Future<void> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dojData = prefs.getString("doj") ?? '';
    String establishmentName = prefs.getString("establishmentName") ?? '';
    String establishmentTypeData = prefs.getString("establishmentType") ?? '';
    String designationData = prefs.getString("designation") ?? '';
    String departmentNameData = prefs.getString("departmentName") ?? '';
    print('doj===$dojData');
    print('establishmentName===$establishmentName');
    print('establishmentType===$establishmentTypeData');
    DateTime dateTime = DateTime.parse(dojData);

    // Format the date
    String formattedDate = DateFormat("d MMMM, yyyy").format(dateTime);
    setState(() {
      doj=formattedDate.toString();
      designation=designationData.toString();
      departmentName=departmentNameData.toString();


    });

  }
  // Helper widget for Payslip Items
  Widget payslipItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Helper widget for Salary Items
  Widget salaryItem(String title, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
                color: Colors.black
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: Colors.black,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18 : 16,
            ),
          ),
        ],
      ),
    );
  }

  // Pie chart sections for salary breakdown
  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: double.parse(widget.payslip.payable_salary),
        title: '',
        radius: 40,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: double.parse(widget.payslip.total_deduction),
        title: '',
        radius: 40,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),

    ];
  }

}
