import 'package:apphacks2021/RandomWords.dart';
import 'package:apphacks2021/Wallet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apphacks2021/contract_linking.dart';

// Execution step in flutter (think of it as the java main )

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinking>(
      create: (_) => ContractLinking(),
      child: MaterialApp(
        title: 'NFTs for sale',
        initialRoute: "/",
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.yellow[700],
            accentColor: Colors.black),
        routes: {
          '/': (context) => RandomWords(),
          '/wallet': (context) => Wallet()
        },
      ),
    );
  }
}
