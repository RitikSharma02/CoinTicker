import 'dart:convert';

import 'package:http/http.dart' as http;

/// temp mail
const apiKey = "";

class CoinData {
  double? exchangeRate;
  double? cryptoCurrency;
  Future<double?> getCoinData(
      String cryptoCurrency, String selectedCurrency) async {
    String url =
        "https://rest.coinapi.io/v1/exchangerate/$cryptoCurrency/$selectedCurrency?apikey=$apiKey";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var coinData = jsonDecode(response.body);
      //parsing the data
      exchangeRate = coinData['rate'].toDouble();
      return exchangeRate;
    } else {
      print(response.statusCode);
      return null;
    }
  }
}

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'BNB',
];
