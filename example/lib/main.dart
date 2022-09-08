import 'package:flutter/material.dart';
import 'package:flutter_pocket/flutter_pocket.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shuttlers x Pocket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pay with pocket'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? tag;
  String? amount;

  void pay() async {
    TransferRequestBody body = TransferRequestBody(
      amount: int.tryParse(amount!)! * 100,
      description: 'Testing package',
      tag: tag!,
    );
    final payment = FlutterPocket(
        body: body,
        context: context,
        key: 'ENTER_YOUR_KEY_HERE',
        baseUrl:
            'https://rllwjl4z6b.execute-api.eu-central-1.amazonaws.com/api/v1');
    await payment.pay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              onChanged: (String v) {
                tag = v;
                setState(() {});
              },
              autovalidateMode: AutovalidateMode.always,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                label: Text('Pocket tag'),
                suffixIcon: Icon(Icons.tag),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              onChanged: (String v) {
                amount = v;
                setState(() {});
              },
              autovalidateMode: AutovalidateMode.always,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text('Amount'),
                suffixIcon: Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'You are making payment with this detail:\nTag:$tag\nAmount:$amount',
              textAlign: TextAlign.center,
            ),
            TextButton.icon(
              onPressed: tag != null && amount != null ? pay : () {},
              icon: const Icon(Icons.payment),
              label: const Text('Pay with pocket'),
            )
          ],
        ),
      ),
    );
  }
}
