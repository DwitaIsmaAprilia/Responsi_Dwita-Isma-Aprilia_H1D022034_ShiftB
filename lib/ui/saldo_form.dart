import 'package:flutter/material.dart';
import 'package:keuangan/bloc/saldo_bloc.dart';
import 'package:keuangan/model/saldo.dart';
import 'package:keuangan/ui/saldo_page.dart';
import 'package:keuangan/widget/warning_dialog.dart';

// ignore: must_be_immutable
class SaldoForm extends StatefulWidget {
  Saldo? saldo;
  SaldoForm({Key? key, this.saldo}) : super(key: key);
  @override
  _SaldoFormState createState() => _SaldoFormState();
}

class _SaldoFormState extends State<SaldoForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH SALDO";
  String tombolSubmit = "SIMPAN";
  final _accountSaldoTextboxController = TextEditingController();
  final _balanceSaldoTextboxController = TextEditingController();
  final _statusSaldoTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.saldo != null) {
      setState(() {
        judul = "UBAH SALDO";
        tombolSubmit = "UBAH";
        _accountSaldoTextboxController.text = widget.saldo!.accountSaldo!;
        _balanceSaldoTextboxController.text = widget.saldo!.balanceSaldo.toString();
        _statusSaldoTextboxController.text = widget.saldo!.statusSaldo.toString();
      });
    } else {
      judul = "TAMBAH SALDO";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _accountSaldoTextField(),
                _balanceSaldoTextField(),
                _statusSaldoTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

//Membuat Textbox Kode Saldo
  Widget _accountSaldoTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Account Saldo"),
      keyboardType: TextInputType.text,
      controller: _accountSaldoTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Account Saldo harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox Balance Saldo
  Widget _balanceSaldoTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Balance Saldo"),
      keyboardType: TextInputType.text,
      controller: _balanceSaldoTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Balance Saldo harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Textbox Status Saldo
  Widget _statusSaldoTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Status"),
      keyboardType: TextInputType.number,
      controller: _statusSaldoTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Status harus diisi";
        }
        return null;
      },
    );
  }

//Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.saldo != null) {
//kondisi update saldo
                ubah();
              } else {
//kondisi tambah saldo
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Saldo createSaldo = Saldo(id: null);
    createSaldo.accountSaldo = _accountSaldoTextboxController.text;
    createSaldo.balanceSaldo = int.parse(_balanceSaldoTextboxController.text);
    createSaldo.statusSaldo = _statusSaldoTextboxController.text;
    SaldoBloc.addSaldo(saldo: createSaldo).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const SaldoPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Saldo updateSaldo= Saldo(id: widget.saldo!.id!);
    updateSaldo.accountSaldo = _accountSaldoTextboxController.text;
    updateSaldo.balanceSaldo = int.tryParse(_balanceSaldoTextboxController.text) ?? 0;
    updateSaldo.statusSaldo = _statusSaldoTextboxController.text;
    SaldoBloc.updateSaldo(saldo: updateSaldo).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const SaldoPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
