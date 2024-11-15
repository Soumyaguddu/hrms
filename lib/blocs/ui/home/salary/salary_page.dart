import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/blocs/ui/home/logic/home_cubit.dart';
import 'package:hrms/constants/ColorConstant.dart';

import '../../../routes/Routes.dart';
import 'data/SalaryDetailsData.dart';

class SalaryStructurePage extends StatefulWidget {
  @override
  State<SalaryStructurePage> createState() => _SalaryStructurePageState();
}

class _SalaryStructurePageState extends State<SalaryStructurePage> {

  @override
  void initState() {
    super.initState();
    context.read<HomeSalaryCubit>().fetchSalary();
  }

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
              'Salary Structure',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body:


      Padding(
        padding: const EdgeInsets.all(16.0),
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
              return Center(child: CircularProgressIndicator());
            }

            if (state is SalaryAndPaySlipLoadedState) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      salaryOption("Monthly CTC", "₹${state.salaryData?.ctc}"),
                      salaryOption("Yearly CTC", "₹${state.salaryData?.ctcYearly}"),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Earnings',
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                "₹${calculateEarningCTC(state.salaryData!)}",
                                style: TextStyle(
                                  color: Colors.black ,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18 ,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Divider(height: 10, thickness: 2),
                        salaryItem('Basic', "₹${state.salaryData?.basicSalary}"),
                        // Render Earnings dynamically
                        ...?state.salaryData?.allowanceDetails.map((allowance) =>
                            salaryItem(allowance.allowanceName, "₹${allowance.amount}")
                        ).toList(),

                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Deductions',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                "₹${calculateDeductionCTC(state.salaryData!)}",
                                style: TextStyle(
                                  color: Colors.black ,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18 ,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Divider(thickness: 2),

                        // Render Deductions dynamically
                        ...?state.salaryData?.deductions.map((deduction) =>
                            salaryItem(deduction.deductionsName, "₹${deduction.amount}")
                        ).toList(),

                        const Divider(thickness: 2),
                        salaryItem("Monthly CTC", "₹${calculateMonthlyCTC(state.salaryData!)}", isBold: true),
                      ],
                    ),
                  ),

                  Visibility(
                    visible: false,
                    child: Container(

                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.green_chart_color,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          // Handle button tap
                        },
                        child: const Text(
                          'Download Salary Certificate',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text("An error occurred!"));
          },
        ),

      ),
    );
  }
  int calculateEarningCTC(SalaryResponseData salaryData) {
    int totalEarnings = salaryData.allowanceDetails.fold(0, (sum, allowance) {
      return sum + (int.tryParse(allowance.amount.toString()) ?? 0);
    });

    int totalDeductions = salaryData.deductions.fold(0, (sum, deduction) {
      return sum + deduction.amount;
    });

    return totalEarnings - totalDeductions + salaryData.basicSalary;
  }
  int calculateDeductionCTC(SalaryResponseData salaryData) {


    int totalDeductions = salaryData.deductions.fold(0, (sum, deduction) {
      return sum + deduction.amount;
    });

    return totalDeductions ;
  }
  int calculateMonthlyCTC(SalaryResponseData salaryData) {
    int totalEarnings = salaryData.allowanceDetails.fold(0, (sum, allowance) {
      return sum + (int.tryParse(allowance.amount.toString()) ?? 0);
    });



    return totalEarnings  + salaryData.basicSalary;
  }


  // Helper widget for Monthly and Yearly options
  Widget salaryOption(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            amount,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }

  // Helper widget for salary items
  Widget salaryItem(String title, String amount, {bool isBold = false}) {
    return
      Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isBold ? Colors.black : Colors.black,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18 : 16,
            ),
          ),
        ],
      ),
    );
  }
}
