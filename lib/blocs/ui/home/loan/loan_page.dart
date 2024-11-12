import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../constants/ColorConstant.dart';
import '../../../routes/Routes.dart';

class LoanPage extends StatelessWidget {
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
                Navigator.pushReplacementNamed(context, Routes.loan);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            const Text(
              'Family Problem',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
             // This will push the dropdown to the right

          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Loan Summary',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 5),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    _buildLoanDetailRow('Approved Amount:', '₹50000'),
                    _buildLoanDetailRow('Current Balance:', '₹20000'),
                    _buildLoanDetailRow('Interest Rate:', '5%'),
                    _buildLoanDetailRow('Monthly Installment:', '₹2000'),
                    _buildLoanDetailRow('Loan Tenure:', '1 Years'),
                    _buildLoanDetailRow('Loan Closing Date:', '30/12/2025'),
                    _buildLoanDetailRow('Next Installment Date:', '11/12/2024'),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),



            const Text(
              'Loan History',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5, // Example count
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text('Installment #${index + 1}'),
                  subtitle: const Text('Paid: ₹2000'),
                  trailing: Text('Date: 2023-09-${index + 10}'),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Request Loan Button

          ],
        ),
      ),
    );
  }
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
}
