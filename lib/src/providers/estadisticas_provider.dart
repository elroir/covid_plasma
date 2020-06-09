import 'dart:convert';

import 'package:covidplasma/src/models/estadisticas_model.dart';
import 'package:http/http.dart' as http;

class EstadisticasProvider {



  Future<Global> getDatosMundial() async {
    final url = 'https://api.covid19api.com/summary';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final casos = new EstadisticasModel.fromJson(decodedData);
    print(casos.global);
    return casos.global;
  }

  Future <List<Country>> getDatosPais() async {
    final url = 'https://api.covid19api.com/summary';
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    
    final casos = EstadisticasModel.fromJson(decodedData);

    return casos.countries;
  }


}