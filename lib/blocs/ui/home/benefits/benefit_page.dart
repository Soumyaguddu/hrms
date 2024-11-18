import 'package:flutter/material.dart';

import '../../../../constants/ColorConstant.dart';
import '../../../routes/Routes.dart';

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

  // The currently selected year
  String selectedYear = '';

  @override
  void initState() {
    super.initState();
    // Set the current year by default
    selectedYear = getCurrentYear();
  }

  // Function to get the current year
  String getCurrentYear() {
    final currentYear = DateTime.now().year;
    return '$currentYear-${currentYear + 1}';
  }

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
                  },
                  itemBuilder: (BuildContext context) {
                    return years.map((String year) {
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
          ],
        ),
      ),
      body: SingleChildScrollView(  // Add this to make the content scrollable
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // EPF Overview Section
              _buildEPFOverview(),
              // Month-wise EPF Details
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child:
                  ListView.builder(
                    shrinkWrap: true, // This prevents the ListView from taking all space
                    itemCount: epfData.length,
                    itemBuilder: (context, index) {
                      final data = epfData[index];
                      return ExpansionTile(
                        title: Text(data['month'],
                            style: const TextStyle(fontWeight: FontWeight.normal)),
                        leading: const Icon(Icons.calendar_month),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                salaryItem('PF Wages:', '₹${data['amount']}',
                                    isBold: true),
                                const Divider(),
                                const SizedBox(
                                  height: 10,
                                ),
                                salaryItem('Employee Contribution:', '',
                                    isBold: true),
                                salaryItem('EPF Contribution: ',
                                    '₹${data['contribution']}'),
                                const Divider(),
                                const SizedBox(
                                  height: 10,
                                ),
                                salaryItem('Employer Contribution:', '',
                                    isBold: true),
                                salaryItem('EPF Contribution:',
                                    '₹${data['contribution']}'),
                                salaryItem('EPS Contribution:',
                                    '₹${data['contribution']}'),
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
          ),
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
  Widget _buildEPFOverview() {
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
                 
                  _buildLoanDetailRow('Employee Name', 'Soumyajit Sen',),
                  _buildLoanDetailRow('Employee ID', 'EMP12345',),
                  _buildLoanDetailRow('PF Number:', "WB/HLO/14778114/000/14785",),
                  _buildLoanDetailRow('Total EPF Amount:', '₹21475'),
                  _buildLoanDetailRow('Employee Share:', '₹10742'),
                  _buildLoanDetailRow('Employer Share:', '₹10742'),
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
}
