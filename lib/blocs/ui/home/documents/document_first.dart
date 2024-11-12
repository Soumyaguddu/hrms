import 'package:flutter/material.dart';

import '../../../../constants/ColorConstant.dart';
import '../../../routes/Routes.dart';

class DocumentListPage extends StatelessWidget {
  // Example document data
  final List<Map<String, String>> documents = [
    {
      'title': 'Payslip',
      'description': 'View or download your monthly payslip.',
      'icon': Icons.description.toString(),
    },
    {
      'title': 'Form 16',
      'description': 'View or download your Form 16.',
      'icon': Icons.assignment.toString(),
    },
    // Add more documents if needed
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
              'Documents',
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
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final document = documents[index];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: const Icon(Icons.description,color: Colors.blue,size: 40,),
                title: Text(document['title'] ?? ''),
                subtitle: Text(document['description'] ?? ''),
                trailing:
                const Icon(Icons.arrow_forward,color: Colors.green,size: 25,),
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.document_listing);
              },
              ),
            );
          },
        ),
      ),
    );
  }
}
