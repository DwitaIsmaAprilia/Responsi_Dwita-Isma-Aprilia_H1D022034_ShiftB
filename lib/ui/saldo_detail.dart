import 'package:flutter/material.dart';
import 'package:keuangan/bloc/saldo_bloc.dart';
import 'package:keuangan/model/saldo.dart';
import 'package:keuangan/ui/saldo_form.dart';
import 'package:keuangan/ui/saldo_page.dart';
import 'package:keuangan/widget/warning_dialog.dart';

// ignore: must_be_immutable
class SaldoDetail extends StatefulWidget {
  Saldo? saldo;

 SaldoDetail({Key? key, this.saldo}) : super(key: key);

  @override
  _SaldoDetailState createState() => _SaldoDetailState();
}

class _SaldoDetailState extends State<SaldoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Saldo'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Account : ${widget.saldo!.accountSaldo}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Balance : ${widget.saldo!.balanceSaldo}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Status : ${widget.saldo!.statusSaldo}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
// Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SaldoForm(
                  saldo: widget.saldo!,
                ),
              ),
            );
          },
        ),
// Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
//tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            SaldoBloc.deleteSaldo(id: widget.saldo!.id!).then(
                    (value) => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SaldoPage()))
                }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ));
            });
          },
        ),
//tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
