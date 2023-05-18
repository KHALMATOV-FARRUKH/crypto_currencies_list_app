import 'package:crypto_currencies_list_app/crypto_coins_list_app.dart';
import 'package:crypto_currencies_list_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(() => CryptoCoinsRepository(dio: Dio()));
  runApp(const CryptoCoinsListApp());
}

