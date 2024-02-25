import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:section14/coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();
  double btcExchangeRate = 0.0;
  double ethExchangeRate = 0.0;
  double bnbExchangeRate = 0.0;

  Future<void> fetchCoinData() async {
    double? btcRate = await coinData.getCoinData('BTC', selectedCurrency);
    double? ethRate = await coinData.getCoinData('ETH', selectedCurrency);
    double? bnbRate = await coinData.getCoinData('BNB', selectedCurrency);

    if (btcRate != null && ethRate != null && bnbRate != null) {
      setState(() {
        btcExchangeRate = btcRate;
        ethExchangeRate = ethRate;
        bnbExchangeRate = bnbRate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCoinData();
  }

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(
          currency,
          style: const TextStyle(
              letterSpacing: 1,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w600),
        ),
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
        });
        fetchCoinData();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(
        currency,
        style: const TextStyle(
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ));
    }

    return CupertinoPicker(
      squeeze: 1,
      // backgroundColor: Color(0xFF2D28D3),
      itemExtent: 32,
      onSelectedItemChanged: (value) async {
        setState(() {
          selectedCurrency = currenciesList[value];
        });
        await fetchCoinData();
      },
      children: pickerItems,
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2D28D3),
        title: const Text(
          'COIN TICKER   🪙',
          style: TextStyle(
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 38.0, 18.0, 0),
                  child: Card(
                    color: Color(0xFF2D28D3),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 28.0),
                      child: Text(
                        /// exchange rate here
                        '1 BTC =  ${btcExchangeRate.toStringAsFixed(2)} $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 38.0, 18.0, 0),
                  child: Card(
                    color: Color(0xFF2D28D3),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 28.0),
                      child: Text(
                        /// exchange rate here
                        '1 ETH =  ${ethExchangeRate.toStringAsFixed(2)} $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 38.0, 18.0, 0),
                  child: Card(
                    color: const Color(0xFF2D28D3),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 28.0),
                      child: Text(
                        /// exchange rate here
                        '1 BNB =  ${bnbExchangeRate.toStringAsFixed(2)} $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: const Color(0xFF2D28D3),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 160.0),
              child: Platform.isAndroid ? androidDropDown() : iOSPicker(),
            ),
          ),
        ],
      ),
    );
  }
}
