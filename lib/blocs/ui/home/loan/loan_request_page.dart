import 'package:flutter/material.dart';

import '../../../../constants/ColorConstant.dart';
import '../../../routes/Routes.dart';

class LoanRequestPage extends StatefulWidget {
  @override
  _LoanRequestPageState createState() => _LoanRequestPageState();
}

class _LoanRequestPageState extends State<LoanRequestPage> {
  final _formKey = GlobalKey<FormState>();
  String _loanType = 'Personal';
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _repaymentPeriodController = TextEditingController();

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
                // Loan Type Dropdown
                Text('Loan Type', style: TextStyle(fontWeight: FontWeight.bold)),
               SizedBox(height: 5,),
                DropdownButtonFormField<String>(
                  value: _loanType,
                  items: ['Personal', 'Education', 'Home', 'Car', 'Business']
                      .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) => setState(() => _loanType = value!),
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(height: 16),
        
                // Loan Amount
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
                SizedBox(height: 16),
        
                // Repayment Period
                Text('Repayment Period (Months)', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5,),
                TextFormField(
                  controller: _repaymentPeriodController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter repayment period',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter the repayment period';
                    return null;
                  },
                ),
                SizedBox(height: 16),
        
                // Purpose
                Text('Purpose', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5,),
                TextFormField(
                  controller: _purposeController,
                  decoration: InputDecoration(
                    hintText: 'Enter loan purpose',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter the loan purpose';
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
}
