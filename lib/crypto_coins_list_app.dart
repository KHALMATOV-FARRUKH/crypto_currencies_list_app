import 'package:crypto_currencies_list_app/router/router.dart';
import 'package:crypto_currencies_list_app/theme/theme.dart';
import 'package:flutter/material.dart';

class CryptoCoinsListApp extends StatelessWidget {
  const CryptoCoinsListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CryptoCurrenciesList",
      theme: darkTheme,
      routes: routes,
    );
  }
}
