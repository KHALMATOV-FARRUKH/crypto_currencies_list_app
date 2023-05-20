import 'package:auto_route/auto_route.dart';
import 'package:crypto_currencies_list_app/features/crypto_coin/crypto_coin.dart';
import 'package:crypto_currencies_list_app/features/crypto_list/crypto_list.dart';
import 'package:crypto_currencies_list_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: CryptoListRoute.page, path: '/'),
    AutoRoute(page: CryptoCoinRoute.page),
  ];
}