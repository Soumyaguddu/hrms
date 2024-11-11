import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hrms/constants/ColorConstant.dart';
import '../../../routes/Routes.dart';

class EarningPage extends StatelessWidget {
  final List<double> monthlyEarnings = [
    65020, 60000, 65070, 68090, 59000, 65700, 50000, 65070, 60500, 60570, 65200, 65070
  ];
  final List<String> months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
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
              'Earnings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(  // Wrap the body in a SingleChildScrollView to make it scrollable
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          verticalInterval: 1,
                          horizontalInterval: 1000,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey[300],
                              strokeWidth: 1,
                            );
                          },
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 10000,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                var formattedValue = (value / 1000).toInt().toString() + 'k';
                                return Text(
                                  formattedValue,  // Display the formatted value with 'k'
                                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                int index = value.toInt();
                                return Text(
                                  months[index], // Show month names at the bottom
                                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                                );
                              },
                            ),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false), // Hides the right-side labels
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false), // Hides the top labels
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        minX: 0,
                        maxX: 11,
                        minY: 0,
                        maxY: 70000,
                        lineBarsData: [
                          LineChartBarData(
                            spots: monthlyEarnings.asMap().entries.map((entry) {
                              return FlSpot(entry.key.toDouble(), entry.value);
                            }).toList(),
                            isCurved: true,
                            color: Colors.blueAccent,
                            barWidth: 3,
                            belowBarData: BarAreaData(show: true),
                            dotData: const FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Text(
                  'Earnings',
                  style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(thickness: 2),
              ),
              // Wrap the ListView with Expanded to prevent overflow error
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    salaryItem("Gross", "₹250,000"),
                    salaryItem("House Rent Allowance", "₹60,000"),
                    salaryItem("Conveyance Allowance", "₹52,000"),
                    salaryItem("Allowance", "₹42,000"),
                    salaryItem("Medical Allowance", "₹12,000"),
                    salaryItem("Travel Allowance", "₹45,500"),
                    salaryItem("Total CTC", "₹295,300", isBold: true),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.left,
                          'Contributions',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const Divider(thickness: 2),
                    salaryItem("Provident Fund", "₹3,000"),
                    salaryItem("Total Contributions", "₹20,000", isBold: true),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Taxes',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    const Divider(thickness: 2),
                    salaryItem("Professional Tax", "₹12,000"),
                    salaryItem("Total Taxes", "₹20,000", isBold: true),
                    const Divider(thickness: 2),
                    salaryItem("Total Net Pay", "₹274,300", isBold: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _buildBreakdownItem(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(amount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
