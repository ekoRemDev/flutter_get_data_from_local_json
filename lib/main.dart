import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(LocalJsonKullanimi());

class LocalJsonKullanimi extends StatefulWidget {
  @override
  _LocalJsonKullanimiState createState() => _LocalJsonKullanimiState();
}

class _LocalJsonKullanimiState extends State<LocalJsonKullanimi> {
  List tumArabalar;

  @override
  void initState() {
    super.initState();
    debugPrint("init state calisti");
    veriKaynaginiOku().then((gelenArabaListesi) {
      setState(() {
        tumArabalar = gelenArabaListesi;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build calisti");
    return MaterialApp(
      title: 'title',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Local Json Kullanimi'),
        ),
        body: Container(
          child: Center(
            child: ListView.builder(
              itemCount: tumArabalar.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tumArabalar[index]["araba_adi"]),
                  subtitle: Text(tumArabalar[index]["ulke"]),
                  trailing: Icon(Icons.ac_unit),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<List> veriKaynaginiOku() async {
//    Future<String> jsonoku =
//        DefaultAssetBundle.of(context).loadString('assets/data/araba.json');
//
//    jsonoku.then((okunanjson) {
//      debugPrint('gelen json : ' + okunanjson);
//      return okunanjson;
//    });

    var gelenjson = await DefaultAssetBundle.of(context)
        .loadString('assets/data/araba.json');
    debugPrint(gelenjson);

    List arabaListesi = jsonDecode(gelenjson.toString());
    debugPrint("toplam araba sayisi : " + arabaListesi.length.toString());

    for (int i = 0; i < arabaListesi.length; i++) {
      debugPrint("Araba markasi : " + arabaListesi[i]["araba_adi"].toString());
      debugPrint("Ulkesi : " + arabaListesi[i]["ulke"].toString());
    }

    return arabaListesi;
  }
}
