import 'package:database_flutter/OnlinePayment.dart';
import 'package:database_flutter/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'signOut.dart';

class PaymentPage extends StatefulWidget {
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
              margin:
                  EdgeInsets.all(10), // Add margin (distance) around the button
              decoration: BoxDecoration(
                border: Border.all(
                  color: _selectedPaymentOption == 0
                      ? Colors.pink
                      : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
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
                  SizedBox(
                    height: 13,
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
              margin:
                  EdgeInsets.all(10), // Add margin (distance) around the button
              decoration: BoxDecoration(
                border: Border.all(
                  color: _selectedPaymentOption == 1
                      ? Colors.pink
                      : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
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
                  SizedBox(
                    height: 13,
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
              alignment: Alignment.center,
              child: Container(
                // Set the desired button height
                child: InkWell(
                  onTap: _navigateToNextScreen,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    width: 120,
                    height: 60,
                    padding: EdgeInsets.all(4),
                    child: Center(
                      child: Text(
                        _selectedPaymentOption == 0 ? 'Continue' : ' Pay',
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

  void _onTap(int index) {
    if (index == 0) {
      // Navigate to MyHomePage when "Home" is tapped
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else if (index == 1) {
      // Navigate to CartPage when "Cart" is tapped
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartPage(),
        ),
      );
    } else if (index == 2) {
      // Navigate to PaymentPage when "Payment" is tapped
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(// Pass the key here
              ),
        ),
      );
    } else if (index == 3) {
      // Navigate to ProfilePage when "Profile" is tapped
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
    }
  }
}
