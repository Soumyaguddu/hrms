import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../constants/ColorConstant.dart';
import '../../../routes/Routes.dart';

class PayslipPage extends StatefulWidget {
  @override
  State<PayslipPage> createState() => _PayslipPageState();
}

class _PayslipPageState extends State<PayslipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.themeColor,
      appBar: AppBar(
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
              const Text(
                'Payslip for the Month of October 2024',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 2),
              const SizedBox(height: 10),
              // Payslip Details
              payslipItem('Employee Name', 'Soumyajit Sen'),
              payslipItem('Employee ID', 'EMP12345'),
              payslipItem('Designation', 'Software Engineer'),
              payslipItem('Department', 'Development'),
              payslipItem('Date of Joining', '02 Jan 2024'),
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

                  const Column(
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
                          "₹50,000",
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
                          "₹2,000",
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
              salaryItem('Basic Pay', '₹50,000'),
              salaryItem('House Rent Allowance', '₹10,000'),
              salaryItem('Conveyance Allowance', '₹12,000'),
              salaryItem('Medical Allowance', '₹5,000'),
              salaryItem('Travel Allowance', '₹2,500'),
              const Divider(thickness: 2),
              salaryItem("Provident Fund", "- ₹3,000"),
              salaryItem("Professional Tax", "- ₹200"),
              const Divider(thickness: 2),
              salaryItem('Total Net Pay', '₹74,300', isBold: true),
            ],
          ),
        ),
      ),
    );
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
        value: 80,
        title: '',
        radius: 40,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 20,
        title: '',
        radius: 40,
        titleStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),

    ];
  }
}
