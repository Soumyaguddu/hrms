import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrms/constants/ColorConstant.dart';
import 'package:hrms/constants/ImageConstant.dart';
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
      appBar:
      AppBar(
        backgroundColor: ColorConstant.green_chart_color,
        elevation: 0,
        title:  Row(
          children: [

            Text(
              'Hello, $empName', // Replace with actual user name
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),

      ),
      drawer: CustomDrawer(),
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



class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [



          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorConstant.header_fill_color, // Background color for the header
            ),
            child:  Row(
              children: [

                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular Progress Indicator
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                      child: SizedBox(
                        width: 90,
                        height: 90,
                        child: CircularProgressIndicator(
                          value: 0.7, // Progress value (e.g., 0.6 for 60%)
                          strokeWidth: 6,
                          valueColor: AlwaysStoppedAnimation<Color>(ColorConstant.themeColor), // Progress bar color
                          backgroundColor: ColorConstant.box_fill_color, // Background color
                        ),
                      ),
                    ),
                    // Circle Avatar
                    CircleAvatar(
                      radius: 38,
                      backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4YreOWfDX3kK-QLAbAL4ufCPc84ol2MA8Xg&s'), // Profile image
                    ),
                    // Percentage Text
                    Positioned(
                      bottom: -0,
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 2.0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: ColorConstant.box_fill_color),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                              child: Text(
                                '${(0.7 * 100).toInt()}%', // Convert progress to percentage
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.themeColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


                SizedBox(width: 15),
                // User Details

                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                   
                   
                       Text(
                         'Pankaj Saha',
                         style: TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.bold,
                           color: ColorConstant.themeColor,
                         ),
                       ),
                       Text(
                         'TSPL001',
                         style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),
                       ),
                       Text(
                         'Developer',
                         style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal),
                       ),
                       SizedBox(height: 8),
                       // Progress Bar
                   
                     ],
                   ),
                 ),

                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child:SvgPicture.asset(ImageConstant.cross_icon,height: 36,),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(
                  icon: ImageConstant.user_drawer_icon,
                  title: 'My Profile',
                  onTap: () {
                    // Handle navigation
                  },
                ),
                _buildDrawerItem(
                  icon: ImageConstant.salary_structure_drawer_icon,
                  title: 'Salary Structure',
                  onTap: () {
                    // Handle navigation
                  },
                ),
                _buildDrawerItem(
                  icon: ImageConstant.payslip_drawer_icon,
                  title: 'Payslips',
                  onTap: () {
                    // Handle navigation
                  },
                ),
                _buildDrawerItem(
                  icon: ImageConstant.attendance_drawer_icon,
                  title: 'Attendance',
                  onTap: () {
                    // Handle navigation
                  },
                ),
                _buildDrawerItem(
                  icon: ImageConstant.leave_drawer_icon,
                  title: 'Leave',
                  onTap: () {
                    // Handle navigation
                  },
                ),
                _buildDrawerItem(
                  icon: ImageConstant.holiday_drawer_icon,
                  title: 'Holiday',
                  onTap: () {
                    // Handle navigation
                  },
                ),
                _buildDrawerItem(
                  icon: ImageConstant.apply_loan_drawer_icon,
                  title: 'Apply Loan',
                  onTap: () {
                    // Handle navigation
                  },
                ),
                _buildDrawerItem(
                  icon: ImageConstant.reimburshment_drawer_icon,
                  title: 'Reimbursement',
                  onTap: () {
                    // Handle navigation
                  },
                ),
                _buildDrawerItem(
                  icon: ImageConstant.kyc_drawer_icon,
                  title: 'KYC',
                  onTap: () {
                    // Handle navigation
                  },
                ),
                _buildDrawerItem(
                  icon: ImageConstant.esi_drawer_icon,
                  title: 'ESI & EPF',
                  onTap: () {
                    // Handle navigation
                  },
                ),
                _buildDrawerItem(
                  icon: ImageConstant.tax_saving_drawer_icon,
                  title: 'Tax Saving',
                  onTap: () {
                    // Handle navigation
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Drawer Item Widget
  Widget _buildDrawerItem({
    required dynamic icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: SvgPicture.asset(icon,color: Colors.black,),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }
}
