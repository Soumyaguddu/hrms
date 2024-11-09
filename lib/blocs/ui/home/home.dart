import 'package:flutter/material.dart';
import 'package:hrms/constants/ColorConstant.dart';
import 'package:hrms/main.dart';

import '../../routes/Routes.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> cardItems = [
    {'title': 'Salary', 'icon': Icons.attach_money},
    {'title': 'Payslip', 'icon': Icons.description},
    {'title': 'Earning', 'icon': Icons.trending_up},
    {'title': 'Benefits', 'icon': Icons.card_giftcard},
    {'title': 'Loan', 'icon': Icons.account_balance_wallet},
    {'title': 'Documents', 'icon': Icons.folder},
    {'title': 'Leave Details', 'icon': Icons.calendar_today},
    {'title': 'Attendance', 'icon': Icons.location_on},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: ColorConstant.themeColor,
      appBar: AppBar(
        backgroundColor: ColorConstant.green_chart_color,
        elevation: 0,
        title:
        Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://avatar.iran.liara.run/public/boy?username=Ash'), // Replace with a real image URL or AssetImage
            ),
            const SizedBox(width: 15),
            const Text(
              'Hello, Soumyajit', // Replace with actual user name
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
            icon: const Icon(Icons.menu,color: Colors.white,),
            onPressed: () {
              // Define menu action here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Menu clicked')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 50.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Two cards per row
            childAspectRatio: 1.3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: cardItems.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 10,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Routes.salary);
                  // Define actions for each card here, if needed
                /*  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${cardItems[index]['title']} clicked')),
                  );*/
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(cardItems[index]['icon'], size: 40, color: ColorConstant.green_chart_color),
                      const SizedBox(height: 5),
                      Text(
                        cardItems[index]['title'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
