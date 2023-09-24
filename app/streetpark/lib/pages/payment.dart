import 'package:flutter/material.dart';
import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:streetpark/pages/payment.dart';
class PayScreen extends StatefulWidget {
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final TextEditingController _payeeNameController = TextEditingController();
  final TextEditingController _payeeUpiIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Now'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _payeeNameController,
                decoration: InputDecoration(
                  labelText: 'Payee Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _payeeUpiIdController,
                decoration: InputDecoration(
                  labelText: 'Payee UPI ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  final payeeName = _payeeNameController.text;
                  final payeeUpiId = _payeeUpiIdController.text;
                  final amount = double.tryParse(_amountController.text) ?? 0.0;

                  try {
                    final res = await EasyUpiPaymentPlatform.instance.startPayment(
                      EasyUpiPaymentModel(
                          payeeVpa: payeeUpiId,
                          payeeName: payeeName,
                          amount: amount,
                          description: 'Testing payment'
                      ),
                    );
                    // TODO: add your success logic here
                    print(res);
                  } on EasyUpiPaymentException catch (e) {
                    // TODO: add your exception logic here
                    print('Payment Failed: ${e.message}');
                  }
                },
                child: Text('Pay Now Securely'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _payeeNameController.dispose();
    _payeeUpiIdController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
