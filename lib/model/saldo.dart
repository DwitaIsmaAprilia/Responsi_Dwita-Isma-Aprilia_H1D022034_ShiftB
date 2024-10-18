class Saldo {
  int? id;
  String? accountSaldo;
  int? balanceSaldo;
  String? statusSaldo;
  Saldo({this.id, this.accountSaldo, this.balanceSaldo, this.statusSaldo});
  factory Saldo.fromJson(Map<String, dynamic> obj) {
    return Saldo(
        id: obj['id'],
        accountSaldo: obj['account_saldo'],
        balanceSaldo: obj['balance_saldo'],
        statusSaldo: obj['status']);
  }
}
