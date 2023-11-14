import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class UPIPaymentScreen extends StatefulWidget {
  @override
  _UPIPaymentScreenState createState() => _UPIPaymentScreenState();
}

class _UPIPaymentScreenState extends State<UPIPaymentScreen> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.upi;

  Future<void> _openAppOrBrowser(String packageName, String upiURL) async {
    final bool isAppInstalled = await canLaunch(packageName);
    if (isAppInstalled) {
      await launch(packageName);
    } else {
      await launch(upiURL);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPI Payment'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20), // Add spacing
          Text('Select Payment Method:'),
          RadioListTile<PaymentMethod>(
            title: Text('UPI'),
            value: PaymentMethod.upi,
            groupValue: _selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod = value!;
              });
            },
          ),
          RadioListTile<PaymentMethod>(
            title: Text('Credit/Debit Card'),
            value: PaymentMethod.CreditCardScreen,
            groupValue: _selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod = value!;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedPaymentMethod == PaymentMethod.upi) {
                final String upiURL =
                    'upi://pay?pa=9347697023@apl=Recipient&tn=Payment%20for%20Something&am=100&cu=INR';
                _openAppOrBrowser('com.phonepe.app',
                    upiURL); // You can add more UPI app package names if needed
              } else if (_selectedPaymentMethod ==
                  PaymentMethod.CreditCardScreen) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreditCardScreen()));
              }
            },
            child: Text('Proceed'),
          ),
        ],
      ),
    );
  }
}

enum PaymentMethod {
  upi,
  CreditCardScreen,
}

class CreditCardScreen extends StatefulWidget {
  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text("Credit Card Details"),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: (CreditCardBrand brand) {},
              obscureCardNumber: true,
              obscureCardCvv: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Card Number',
                          hintText: 'xxxx xxxx xxxx xxxx',
                        ),
                        onChanged: (value) {
                          setState(() {
                            cardNumber = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Expiry Date',
                          hintText: 'MM/YY',
                        ),
                        onChanged: (value) {
                          setState(() {
                            expiryDate = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Cardholder Name',
                        ),
                        onChanged: (value) {
                          setState(() {
                            cardHolderName = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'CVV',
                        ),
                        onChanged: (value) {
                          setState(() {
                            cvvCode = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UPI extends StatefulWidget {
  @override
  _UPI createState() => _UPI();
}

class _UPI extends State<UPI> {
  Future<void> _openAppOrBrowser(String packageName, String upiURL) async {
    final bool isAppInstalled = await canLaunch(packageName);
    if (isAppInstalled) {
      await launch(packageName);
    } else {
      await launch(upiURL);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String phonePePackageName = 'com.phonepe.app';
    final String paytmPackageName = 'net.one97.paytm';
    final String googlePayPackageName =
        'com.google.android.apps.nbu.paisa.user';
    final String amazonPayPackageName = 'in.amazon.mShop.android.shopping';

    final String upiURL =
        'upi://pay?pa=9347697023@apl=Recipient&tn=Payment%20for%20Something&am=100&cu=INR';

    return Scaffold(
      appBar: AppBar(
        title: Text('UPI Payment'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20), // Add spacing at the top
          _buildPaymentButton(
            image: Image.asset('assets/phonepay.png'), // Add your image asset
            text: 'Open PhonePe',
            onPressed: () => _openAppOrBrowser(phonePePackageName, upiURL),
          ),
          _buildPaymentButton(
            image: Image.asset('assets/paytm.png'), // Add your image asset
            text: 'Open Paytm',
            onPressed: () => _openAppOrBrowser(paytmPackageName, upiURL),
          ),
          _buildPaymentButton(
            image: Image.asset('assets/googlepay.png'), // Add your image asset
            text: 'Open Google Pay',
            onPressed: () => _openAppOrBrowser(googlePayPackageName, upiURL),
          ),
          _buildPaymentButton(
            image: Image.asset('assets/amazonpay.png'), // Add your image asset
            text: 'Open Amazon Pay',
            onPressed: () => _openAppOrBrowser(amazonPayPackageName, upiURL),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton({
    required Image image,
    required String text,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(child: image),
          ),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
