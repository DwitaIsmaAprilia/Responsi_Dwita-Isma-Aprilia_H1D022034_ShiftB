class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/api/keuangan';
  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';
  static const String listSaldo = '$baseUrl/keuangan/saldo';
  static const String createSaldo = '$baseUrl/keuangan/saldo';

  static String updateSaldo(int id) {
    return '$baseUrl/saldo/$id/update';
  }

  static String showSaldo(int id) {
    return '$baseUrl/saldo/$id';
  }

  static String deleteSaldo(int id) {
    return '$baseUrl/saldo/$id/delete';
  }
}
