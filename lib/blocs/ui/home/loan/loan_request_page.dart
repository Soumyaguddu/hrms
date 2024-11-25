import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/ColorConstant.dart';
import '../../../routes/Routes.dart';

class LoanRequestPage extends StatefulWidget {
  @override
  _LoanRequestPageState createState() => _LoanRequestPageState();
}

class _LoanRequestPageState extends State<LoanRequestPage> {
  final _formKey = GlobalKey<FormState>();
  String _loanType = 'Fixed';
  String _loanTenure = '3 Months';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nameCodeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _repaymentPeriodController = TextEditingController();
  final TextEditingController _deductionTypeController = TextEditingController();
String empName='';
String empCode='';
  @override
  void dispose() {
    _amountController.dispose();
    _purposeController.dispose();
    _repaymentPeriodController.dispose();
    super.dispose();
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      // Perform loan request submission
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Loan request submitted')));
      // Add submission logic here (e.g., send data to an API)
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoginData();
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
              'Request Loan',
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
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Employee Name', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5,),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Enter emp Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Employee name is required';
                    return null;
                  },
                ),
                SizedBox(height: 5,),
                Text('Employee Code', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5,),
                TextFormField(
                  controller: _nameCodeController,
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Enter emp code',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Employee code is required';
                    return null;
                  },
                ),
                SizedBox(height: 5,),
                Text('Loan Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5,),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter amount',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter an amount';
                    return null;
                  },
                ),
                SizedBox(height: 5,),
                Text('Loan Type', style: TextStyle(fontWeight: FontWeight.bold)),
               SizedBox(height: 5,),
                DropdownButtonFormField<String>(
                  value: _loanType,
                  items: ['Fixed', 'Flexible']
                      .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) => setState(() => {_loanType = value!}),
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 5,),
                Text('Select Tenure', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5,),

                _loanType=='Fixed'?
                DropdownButtonFormField<String>(
                  value: _loanTenure,
                  items: {
                    '3 Months': '3',
                    '6 Months': '6',
                    '9 Months': '9',
                    '12 Months': '12',
                    '18 Months': '18',
                    '24 Months': '24',
                    '36 Months': '36'
                  }
                      .entries
                      .map((entry) => DropdownMenuItem(
                    value: entry.key,
                    child: Text(entry.key),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _loanTenure = value!;
                      if (_amountController.text.isNotEmpty) {
                        _repaymentPeriodController.text =
                            (double.parse(_amountController.text) / double.parse({
                              '3 Months': '3',
                              '6 Months': '6',
                              '9 Months': '9',
                              '12 Months': '12',
                              '18 Months': '18',
                              '24 Months': '24',
                              '36 Months': '36'
                            }[_loanTenure]!))
                                .toStringAsFixed(2);
                      }
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
            :  TextFormField(
                  controller: _deductionTypeController,
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: '',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),

                ),


                SizedBox(height: 5),
        
                // Loan Amount


        
                // Repayment Period
                Text('Monthly Deductions', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5,),
                TextFormField(
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  controller: _repaymentPeriodController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter monthly deductions',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter the monthly deductions';
                    else if (_amountController.text.isEmpty) return 'Please enter loan amount';
                    return null;
                  },
                ),

                SizedBox(height: 24),
        
                // Submit Button
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade300,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 80,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed:_submitRequest,
                      child: Text(
                        "Submit Request",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
      _nameController.text = prefs.getString("empName") ?? '';
      _nameCodeController.text = prefs.getString("empCode") ?? '';

    });

  }
}
