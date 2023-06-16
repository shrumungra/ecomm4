import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Paymentpage extends StatefulWidget {
  const Paymentpage({Key? key}) : super(key: key);

  @override
  State<Paymentpage> createState() => _PaymentpageState();
}

class _PaymentpageState extends State<Paymentpage> {


  Razorpay razorpay = Razorpay();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: ElevatedButton(onPressed: () {
        var options = {
          'key': 'rzp_test_JmfqK4gaollz40',
          'amount': 100000,       //paiisa
          'name': 'Myproduct',
          'description': 'Fine T-Shirt',
          'prefill': {
            'contact': '8888888888',
            'email': 'test@razorpay.com'
          }
        };

        razorpay.open(options);
      }, child: Text("PaymentPage")),
    ),);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.toString()}")));
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.toString()}")));
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.toString()}")));

    // Do something when an external wallet was selected
  }
}
