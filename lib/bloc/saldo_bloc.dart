import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/saldo.dart';

class SaldoBloc {
  static Future<List<Saldo>> getSaldos() async {
    String apiUrl = ApiUrl.listSaldo;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listSaldo = (jsonObj as Map<String, dynamic>)['data'];
    List<Saldo> saldos = [];
    for (int i = 0; i < listSaldo.length; i++) {
      saldos.add(Saldo.fromJson(listSaldo[i]));
    }
    return saldos;
  }

  static Future addSaldo({Saldo? saldo}) async {
    String apiUrl = ApiUrl.createSaldo;
    var body = {
      "account_saldo": saldo!.accountSaldo,
      "balance_saldo": saldo.balanceSaldo,
      "status": saldo.statusSaldo.toString()
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateSaldo({required Saldo saldo}) async {
    String apiUrl = ApiUrl.updateSaldo(saldo.id!);
    print(apiUrl);
    var body = {
      "account_saldo": saldo!.accountSaldo,
      "balance_saldo": saldo.balanceSaldo,
      "status": saldo.statusSaldo
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteSaldo({int? id}) async {
    String apiUrl = ApiUrl.deleteSaldo(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
