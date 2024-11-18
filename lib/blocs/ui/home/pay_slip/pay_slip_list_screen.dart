import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/blocs/ui/home/pay_slip/pay_slip.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/ColorConstant.dart';
import '../../../../core/helper/month_name_helper.dart';
import '../../../internet_cubit/internet_cubit.dart';
import '../../../routes/Routes.dart';
import '../logic/home_cubit.dart';

class PaySlipListingPage extends StatefulWidget {
  @override
  State<PaySlipListingPage> createState() => _PaySlipListingPageState();
}

class _PaySlipListingPageState extends State<PaySlipListingPage> {
  // Example payslip data

String doj='';
  late List<String> yearsData=[];
  String selectedYear = '';
  String establishmentType = '';
  @override
  void initState() {
    super.initState();
    selectedYear = getCurrentYear();
    getLoginData();



  }
  List<int> getYearsList(int startYear) {
    int currentYear = DateTime.now().year;
    return List<int>.generate(currentYear - startYear + 1, (index) => currentYear - index);
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
              'Payslips',
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
            return Center(child: CircularProgressIndicator());
          }

          if (state is SalaryAndPaySlipLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Table header row

                  // List of payslip items
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.paySlipData!.length,
                      itemBuilder: (context, index) {
                        final payslip = state.paySlipData![index];
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(

                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Month: ${"${MonthNameHelper.getIdWiseMonthName((int.parse(payslip.monthName) + 1).toString())} ${payslip.yearName}"}',
                                  style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.normal,fontSize: 16),
                                ),
                                Text('Gross Pay: ₹${payslip.gross_salary}', style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,fontSize: 16),),
                                Text('Deductions: ₹${payslip.total_deduction}', style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,fontSize: 16),),
                                Text('Take Home: ₹${payslip.payable_salary}', style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,fontSize: 16),),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_red_eye,
                                  size: 25, color: Colors.blueAccent),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                          create: (context) => InternetCubit(),
                                          child: PayslipPage(payslip))),
                                );

                              },
                            ),
                            onTap: () {
                              // Optionally, open the PDF when tapped
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text("An error occurred!"));
        },
      ),
    );
  }
  String getCurrentYear() {
    final currentYear = DateTime.now().year;
    return '$currentYear';
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
}
