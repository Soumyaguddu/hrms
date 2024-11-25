import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/constants/ColorConstant.dart';
import 'package:hrms/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/Routes.dart';
import 'logic/home_cubit.dart';

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
  String empName='';

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeSalaryCubit>().fetchUserInformation();
    getLoginData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.themeColor,
      appBar:
      AppBar(
        backgroundColor: ColorConstant.green_chart_color,
        elevation: 0,
        title:  Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                  'https://avatar.iran.liara.run/public/boy?username=Ash'), // Replace with a real image URL or AssetImage
            ),
            SizedBox(width: 15),
            Text(
              'Hello, $empName', // Replace with actual user name
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),

      ),
      body:

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
              padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
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
                      onTap: () async {



                        if (index == 0) {
                          Navigator.pushReplacementNamed(context, Routes.salary);
                        } else if (index == 1) {
                          Navigator.pushReplacementNamed(context, Routes.pay_slip_listing);
                        } else if (index == 2) {
                          Navigator.pushReplacementNamed(context, Routes.earning);
                        }else if (index == 3) {
                          Navigator.pushReplacementNamed(context, Routes.benefit);
                        }
                        else if (index == 4) {
                          Navigator.pushReplacementNamed(context, Routes.loan);
                        }
                        else if (index == 5) {
                          Navigator.pushReplacementNamed(context, Routes.document);
                        } else if (index == 7) {
                          Navigator.pushReplacementNamed(context, Routes.attendance);
                        }
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
                            Icon(cardItems[index]['icon'],
                                size: 40, color: ColorConstant.green_chart_color),
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
            );
          }

          if (state is SalaryAndPaySlipLoadedState) {
            return
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
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
                        onTap: () async {

                          SharedPreferences prefs = await SharedPreferences.getInstance();

                          // Example of storing a string or other data
                          await prefs.setString('pf_no', state.userProfileData!.employee.kycinfo.pf_no.toString());
                          await prefs.setString('esi_no', state.userProfileData!.employee.kycinfo.esi_no.toString());
                          if (index == 0) {
                            Navigator.pushReplacementNamed(context, Routes.salary);
                          } else if (index == 1) {
                            Navigator.pushReplacementNamed(context, Routes.pay_slip_listing);
                          } else if (index == 2) {
                            Navigator.pushReplacementNamed(context, Routes.earning);
                          }else if (index == 3) {
                            Navigator.pushReplacementNamed(context, Routes.benefit);
                          }
                          else if (index == 4) {
                            Navigator.pushReplacementNamed(context, Routes.loan);
                          }
                          else if (index == 5) {
                            Navigator.pushReplacementNamed(context, Routes.document);
                          } else if (index == 7) {
                            Navigator.pushReplacementNamed(context, Routes.attendance);
                          }
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
                              Icon(cardItems[index]['icon'],
                                  size: 40, color: ColorConstant.green_chart_color),
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
              );
          }

          return const Center(child: Text("An error occurred!"));
        },
      ),

    );
  }

  Future<void> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String doj = prefs.getString("doj") ?? '';
    String establishmentName = prefs.getString("establishmentName") ?? '';
    String establishmentTypeData = prefs.getString("establishmentType") ?? '';


    print('doj===$doj');
    print('establishmentName===$establishmentName');
    print('establishmentType===$establishmentTypeData');
    setState(() {

      empName = prefs.getString("empName") ?? '';
    });

  }
}
