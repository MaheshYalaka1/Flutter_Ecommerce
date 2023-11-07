import 'package:database_flutter/OnlinePayment.dart';
import 'package:flutter/material.dart';
import 'bottomnavigation.dart';

class PaymentPage extends StatefulWidget {
  final GlobalKey<MyBottomNavigationBarState> bottomNavigationKey;

  PaymentPage({required this.bottomNavigationKey});
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedPaymentOption =
      0; // 0 for Cash on Delivery, 1 for Online Payment

  BoxDecoration _getDecoration(int option) {
    return BoxDecoration(
      color: _selectedPaymentOption == option
          ? Colors.pink[100]
          : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.pink,
        width: 2,
      ),
    );
  }

  void _navigateToNextScreen() {
    if (_selectedPaymentOption == 0) {
      // Cash on Delivery
      // Navigate to the "Continue" screen
    } else {
      // Online Payment
      // Navigate to the "Proceed to Pay" screen
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => UPIPaymentScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous page
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPaymentOption = 0;
              });
            },
            child: Container(
              decoration: _getDecoration(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: _selectedPaymentOption,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedPaymentOption = value!;
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Cash on Delivery',
                      style: TextStyle(fontSize: 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPaymentOption = 1;
              });
            },
            child: Container(
              decoration: _getDecoration(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: _selectedPaymentOption,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedPaymentOption = value!;
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Online Payment',
                      style: TextStyle(fontSize: 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60, // Set the desired button height
                child: InkWell(
                  onTap: _navigateToNextScreen,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        _selectedPaymentOption == 0
                            ? 'Continue'
                            : 'Proceed to Pay',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
