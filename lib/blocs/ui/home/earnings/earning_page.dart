import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/constants/ColorConstant.dart';
import 'package:hrms/core/helper/month_name_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/Routes.dart';
import '../logic/home_cubit.dart';
import '../pay_slip/data/pay_slip_list_data.dart';

class EarningPage extends StatefulWidget {
  @override
  State<EarningPage> createState() => _EarningPageState();
}

class _EarningPageState extends State<EarningPage> {
  final List<double> monthlyEarnings = [
    65020, 60000, 65070, 68090, 59000, 65700, 50000, 65070, 60500, 60570, 65200, 65070
  ];

  final List<String> months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  String selectedYear = '';

  String establishmentType = '';

  String doj='';

  late List<String> yearsData=[];

  final List<Map<String, dynamic>> epfData = [
    {'month': 'April 2024', 'amount': 14000, 'contribution': 4500},
    {'month': 'May 2024', 'amount': 15000, 'contribution': 5000},
    {'month': 'June 2024', 'amount': 17000, 'contribution': 6000},
    {'month': 'July 2024', 'amount': 18000, 'contribution': 6000},
    {'month': 'August 2024', 'amount': 18000, 'contribution': 6000},
    {'month': 'September 2024', 'amount': 18000, 'contribution': 6000},
    // Add more data for months
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedYear = getCurrentYear();
    getLoginData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.themeColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                    context.read<HomeSalaryCubit>().fetchPaySlip(selectedYear,establishmentType);
                  },
                  itemBuilder: (BuildContext context) {
                    return yearsData.map((String year) {
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
            // This will push the dropdown to the right
          ],
        ),
      ),

      body: SingleChildScrollView(  // Wrap the body in a SingleChildScrollView to make it scrollable
        child: Padding(
          padding: const EdgeInsets.all(2.0),
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
                return Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is SalaryAndPaySlipLoadedState) {
                return
                  Column(
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

                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true, // This prevents the ListView from taking all space
                                    itemCount: state.paySlipData?.length,
                                    itemBuilder: (context, index) {
                                      final data = state.paySlipData?[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: ExpansionTile(
                                          title: Text(MonthNameHelper.getIdWiseMonthName((int.parse(state.paySlipData![index].monthName)+1).toString()),
                                              style: const TextStyle(fontWeight: FontWeight.normal)),
                                          leading: const Icon(Icons.calendar_month),
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Divider(thickness: 2),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    'Total Earnings',
                                                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
                                                  ),
                                                  Text(
                                                    "₹${calculateMonthlyCTC(state.paySlipData![index])}",
                                                    style: TextStyle(
                                                      color: Colors.black ,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18 ,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            salaryItem('Gross',  "₹${state.paySlipData?[index].gross_salary.toString()}",),
                                            ...?state.paySlipData?[index].allowanceDetails.map((allowance) =>
                                                salaryItem(allowance.allowanceName, "₹${allowance.allowanceamount}")
                                            ).toList(),

                                            const Divider(thickness: 2),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text(
                                                    'Total Deductions',
                                                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
                                                  ),
                                                  Text(
                                                    "₹${calculateDeductionCTC(state.paySlipData![index])}",
                                                    style: TextStyle(
                                                      color: Colors.black ,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18 ,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            salaryItem("EPF Contribution", "₹${state.paySlipData?[index].epf_amount}"),
                                            salaryItem("Employee State Insurance", "₹${state.paySlipData?[index].esi_amount}"),
                                            salaryItem("Professional Tax", "₹${state.paySlipData?[index].pTaxAmount}"),
                                            const Divider(thickness: 2),
                                            salaryItem('Total Net Pay', '₹${calculateEarningCTC(state.paySlipData![index])}', isBold: true),




                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  // Wrap the ListView with Expanded to prevent overflow error
                                  /*Padding(
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
                                      ),*/
                                ],
                              ),
                            )),
                      ),

                    ],
                  );
              }

              return const Center(child: Text("An error occurred!"));
            },
          )


        ),
      ),
    );
  }
  int calculateEarningCTC(PaySlipListData paySlipListData) {
    int totalEarnings = paySlipListData.allowanceDetails.fold(0, (sum, allowance) {
      return sum + (int.tryParse(allowance.allowanceamount.toString()) ?? 0);
    });

    return totalEarnings + int.parse(paySlipListData.gross_salary);
  }
  int calculateDeductionCTC(PaySlipListData paySlipListData) {


    int totalDeductions = int.parse(paySlipListData.esi_amount)+int.parse(paySlipListData.pTaxAmount)+int.parse(paySlipListData.epf_amount);


    return totalDeductions ;
  }
  int calculateMonthlyCTC(PaySlipListData paySlipListData) {
    int totalEarnings = paySlipListData.allowanceDetails.fold(0, (sum, allowance) {
      return sum + (int.tryParse(allowance.allowanceamount.toString()) ?? 0);
    });


    int totalDeductions = int.parse(paySlipListData.esi_amount)+int.parse(paySlipListData.pTaxAmount)+int.parse(paySlipListData.epf_amount);

    return totalEarnings +totalDeductions+ int.parse(paySlipListData.basic_salary);
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
  List<int> getYearsList(int startYear) {
    int currentYear = DateTime.now().year;
    return List<int>.generate(currentYear - startYear + 1, (index) => currentYear - index);
  }
  String getCurrentYear() {
    final currentYear = DateTime.now().year;
    return '$currentYear';
  }
  Future<void> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String doj = prefs.getString("doj") ?? '';
    String establishmentName = prefs.getString("establishmentName") ?? '';
    String establishmentTypeData = prefs.getString("establishmentType") ?? '';
    print('doj===$doj');
    print('establishmentName===$establishmentName');
    print('establishmentType===$establishmentTypeData');
    DateTime targetDate = DateTime.parse(doj);
    setState(() {
      establishmentType=establishmentTypeData.toString();
      yearsData = getYearsList(targetDate.year).map((year) => year.toString()).toList();

    });
    context.read<HomeSalaryCubit>().fetchPaySlip(selectedYear,establishmentType);
    print("YearData==$yearsData");
  }
}
