import 'package:flutter/material.dart';

import '../../../../constants/ColorConstant.dart';
import '../../../routes/Routes.dart';

class LoanListingPage extends StatelessWidget {
  // Example loan data
  final List<Map<String, String>> loans = [
    {
      'loanId': 'LN12345',
      'loan_reason': 'Advance Salary',
      'amount': '₹50000',
      'repaidAmount': '₹50000',
      'status': 'Approved',
      'date': '2023-09-10',
      'type': 'Personal',
    },
    {
      'loanId': 'LN67890',
      'loan_reason': 'Family Problem',
      'amount': '₹10000',
      'repaidAmount': '₹10000',
      'status': 'Pending',
      'date': '2023-10-05',
      'type': 'Education',
    },
    {
      'loanId': 'LN11223',
      'loan_reason': 'Tour',
      'amount': '₹25000',
      'repaidAmount': '₹0',
      'status': 'Rejected',
      'date': '2023-08-15',
      'type': 'Car Loan',
    },
    // Add more sample loans here
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
              'Loan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            // This will push the dropdown to the right

          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.app_registration,color: Colors.white,),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.loan_request);

            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView.builder(
          itemCount: loans.length,
          itemBuilder: (context, index) {
            final loan = loans[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: Text('Loan ID: ${loan['loanId']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 5),
                    Text('Loan Purpose: ${loan['loan_reason']}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16),),
                    Text('Amount: ${loan['amount']}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16),),
                    Text('Repaid Amount: ${loan['repaidAmount']}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16)),
                    Text('Status: ${loan['status']}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16)),
                    Text('Date: ${loan['date']}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16)),
                    Text('Type: ${loan['type']}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16)),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.loan_details);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
