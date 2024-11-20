import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/blocs/ui/home/pay_slip/data/pay_slip_list_data.dart';
import 'package:hrms/core/helper/month_name_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/ColorConstant.dart';
import '../../../routes/Routes.dart';
import '../logic/home_cubit.dart';

class EPFPage extends StatefulWidget {
  @override
  State<EPFPage> createState() => _EPFPageState();
}

class _EPFPageState extends State<EPFPage> {
  // List of months for the EPF data
  final List<Map<String, dynamic>> epfData = [
    {'month': 'April 2024', 'amount': 14000, 'contribution': 4500},
    {'month': 'May 2024', 'amount': 15000, 'contribution': 5000},
    {'month': 'June 2024', 'amount': 17000, 'contribution': 6000},
    {'month': 'July 2024', 'amount': 18000, 'contribution': 6000},
    {'month': 'August 2024', 'amount': 18000, 'contribution': 6000},
    {'month': 'September 2024', 'amount': 18000, 'contribution': 6000},
    // Add more data for months
  ];

  final List<String> years = ['2024-2025', '2023-2024'];
  String selectedYear = '';

  String establishmentType = '';

  String doj='';

  late List<String> yearsData=[];
  List<int> getYearsList(int startYear) {
    int currentYear = DateTime.now().year;
    return List<int>.generate(currentYear - startYear + 1, (index) => currentYear - index);
  }
  Future<void> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String doj = prefs.getString("doj") ?? '';
    String establishmentName = prefs.getString("establishmentName") ?? '';
    String establishmentTypeData = prefs.getString("establishmentType") ?? '';
    print('doj===$doj');
    print('establishmentName===$establishmentName');
    print('establishmentType===$establishmentTypeData');
    DateTime targetDate = DateTime.parse(doj);
    setState(() {
      establishmentType=establishmentTypeData.toString();
      yearsData = getYearsList(targetDate.year).map((year) => year.toString()).toList();

    });
    context.read<HomeSalaryCubit>().fetchPaySlip(selectedYear,establishmentType);
    print("YearData==$yearsData");
  }
  @override
  void initState() {
    super.initState();
    // Set the current year by default
  
    selectedYear = getCurrentYear();
    getLoginData();
  }

  // Function to get the current year
  String getCurrentYear() {
    final currentYear = DateTime.now().year;
    return '$currentYear';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.themeColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstant.green_chart_color,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.home);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            const Text(
              'Benefits',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const Spacer(), // This will push the dropdown to the right
            Row(
              children: [
                Text(
                  selectedYear,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                PopupMenuButton<String>(
                  onSelected: (String year) {
                    setState(() {
                      selectedYear = year; // Update the selected year
                    });
                    context.read<HomeSalaryCubit>().fetchPaySlip(selectedYear,establishmentType);
                  },
                  itemBuilder: (BuildContext context) {
                    return yearsData.map((String year) {
                      return PopupMenuItem<String>(
                        value: year,
                        child: Text(year),
                      );
                    }).toList();
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            // This will push the dropdown to the right
          ],
        ),
      ),
      body: 
      
      SingleChildScrollView(  // Add this to make the content scrollable
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:

          BlocConsumer<HomeSalaryCubit, SalaryAndPaySlipState>(
            listener: (context, state) {
              if (state is SalaryAndPaySlipErrorState) {
                SnackBar snackBar = SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              if (state is SalaryAndPaySlipLoadingState) {
                return Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is SalaryAndPaySlipLoadedState) {
                List<double> totalEarnings = [];
                List<String> monthName = [];

                state.paySlipData?.forEach((paySlip) {
                  double grossSalary = double.parse(paySlip.gross_salary) ?? 0.0;
                  double allowancesTotal = paySlip.allowanceDetails.fold(
                      0.0, (sum, allowance) => sum + (allowance.allowanceamount ?? 0.0));
                  double totalAmount = grossSalary + allowancesTotal;

                  totalEarnings.add(totalAmount);
                  totalEarnings.sort(); // Sorts in ascending order

           
                 
                });


                print(totalEarnings);
                return
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // EPF Overview Section
                      _buildEPFOverview(state.paySlipData![0]),
                      // Month-wise EPF Details
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          child:
                          ListView.builder(
                            shrinkWrap: true, // This prevents the ListView from taking all space
                            itemCount: state.paySlipData?.length,
                            itemBuilder: (context, index) {
                              final data = state.paySlipData?[index];
                              return ExpansionTile(
                                title: Text(MonthNameHelper.getIdWiseMonthName((int.parse( state.paySlipData![index].monthName)+1).toString()),
                                    style: const TextStyle(fontWeight: FontWeight.normal)),
                                leading: const Icon(Icons.calendar_month),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        salaryItem('PF Wages:', '₹${(int.parse(data!.payable_salary)+int.parse(data.payable_salary)).toString()}',
                                            isBold: true),
                                        const Divider(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        salaryItem('Employee Contribution:', '',
                                            isBold: true),
                                        salaryItem('EPF Contribution: ',
                                            '₹${int.parse(state.paySlipData![index].payable_salary).toString()}'),
                                        const Divider(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        salaryItem('Employer Contribution:', '',
                                            isBold: true),
                                        salaryItem('EPF Contribution:',
                                            '₹${int.parse(state.paySlipData![index].payable_salary).toString()}'),
                                        salaryItem('EPS Contribution:',
                                          '₹${(double.parse(state.paySlipData![index].payable_salary) * 8.33).round()/100}',),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
              }

              return const Center(child: Text("An error occurred!"));
            },
          )
          
          
       
        ),
      ),
    );
  }
  Widget _buildLoanDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
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
                color: Colors.black),
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

  // Helper function to build the detail rows
  Widget _buildEPFOverview(PaySlipListData paySlipData) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  _buildLoanDetailRow('Employee Name', paySlipData.emp_name,),
                  _buildLoanDetailRow('Employee ID', paySlipData.emp_code),
                  _buildLoanDetailRow('PF Number:', "WB/HLO/14778114/000/14785",),
                  _buildLoanDetailRow('Total EPF Amount:', '₹${((int.parse(paySlipData.payable_salary)+int.parse(paySlipData.payable_salary)))}'),
                  _buildLoanDetailRow('Employee Share:', '₹${(int.parse(paySlipData.payable_salary))}'),
                  _buildLoanDetailRow('Employer Share:', '₹${(int.parse(paySlipData.payable_salary))}'),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Divider()
        ],
      ),
    );
  }

  int calculateEarningCTC(PaySlipListData paySlipListData) {
    int totalEarnings = paySlipListData.allowanceDetails.fold(0, (sum, allowance) {
      return sum + (int.tryParse(allowance.allowanceamount.toString()) ?? 0);
    });

    return totalEarnings + int.parse(paySlipListData.gross_salary);
  }
}
