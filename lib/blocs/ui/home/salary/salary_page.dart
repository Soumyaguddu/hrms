import 'package:flutter/material.dart';
import 'package:hrms/constants/ColorConstant.dart';

import '../../../routes/Routes.dart';

class SalaryStructurePage extends StatelessWidget {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Monthly and Yearly options in a two-column row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                salaryOption("Monthly CTC", "₹74,300"),
                salaryOption("Yearly CTC", "₹8,91,000"),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Earnings',
              style:
              TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontSize: 18),
            ),
            const Divider(height: 10, thickness: 2),


            // Salary components in a column format
            Expanded(
              child: ListView(
                children: [
                  salaryItem("Basic Pay", "₹50,000"),
                  salaryItem("House Rent Allowance", "₹10,000"),
                  salaryItem("Conveyance Allowance", "₹12,000"),
                  salaryItem("Medical Allowance", "₹5,000"),
                  salaryItem("Travel Allowance", "₹2,500"),
                  const SizedBox(height: 10),
                  const Text(
                    'Deductions',
                    style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                  const Divider(thickness: 2),
                  salaryItem("Provident Fund", "- ₹3,000"),
                  salaryItem("Professional Tax", "- ₹200"),
                  const Divider(thickness: 2),
                  salaryItem("Monthly CTC", "₹74,300", isBold: true),
                ],
              ),
            ),

            Container(
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
          ],
        ),
      ),
    );
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
    return Padding(
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
