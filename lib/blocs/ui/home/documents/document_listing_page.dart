import 'package:flutter/material.dart';

import '../../../../constants/ColorConstant.dart';
import '../../../routes/Routes.dart';

class DocumentPaySlipWiseListPage extends StatelessWidget {
  // Example payslip data
  final List<Map<String, String>> payslips = [
    {'title': 'Payslip - October 2024', 'date': '2024-10-31'},
    {'title': 'Payslip - September 2024', 'date': '2024-09-30'},
    {'title': 'Payslip - August 2024', 'date': '2024-08-31'},
    // Add more payslip entries as needed
  ];

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
                Navigator.pushReplacementNamed(context, Routes.document);
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
            // This will push the dropdown to the right

          ],
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.builder(
          itemCount: payslips.length,
          itemBuilder: (context, index) {
            final payslip = payslips[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: Icon(Icons.picture_as_pdf, color: Colors.red,size: 40,),
                title: Text(payslip['title'] ?? ''),
                subtitle: Text('Date: ${payslip['date']}'),
                trailing: IconButton(
                  icon: Icon(Icons.download,size: 25,),
                  onPressed: () {
                    // Action to download/view the PDF
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Downloading ${payslip['title']}...')),
                    );
                  },
                ),
                onTap: () {
                  // Alternatively, open the PDF when tapped
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
