import 'package:flutter/material.dart';
import 'package:keuangan/bloc/logout_bloc.dart';
import 'package:keuangan/bloc/saldo_bloc.dart';
import 'package:keuangan/model/saldo.dart';
import 'package:keuangan/ui/login_page.dart';
import 'package:keuangan/ui/saldo_detail.dart';
import 'package:keuangan/ui/saldo_form.dart';

class SaldoPage extends StatefulWidget {
  const SaldoPage({Key? key}) : super(key: key);
  @override
  _SaldoPageState createState() => _SaldoPageState();
}

class _SaldoPageState extends State<SaldoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Saldo'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SaldoForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: SaldoBloc.getSaldos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListSaldo(
            list: snapshot.data,
          )
              : const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ListSaldo extends StatelessWidget {
  final List? list;
  const ListSaldo({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemSaldo(
            saldo: list![i],
          );
        });
  }
}

class ItemSaldo extends StatelessWidget {
  final Saldo saldo;
  const ItemSaldo({Key? key, required this.saldo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SaldoDetail(
                  saldo: saldo,
                )));
      },
      child: Card(
        child: ListTile(
          title: Text(saldo.accountSaldo!),
          subtitle: Text(saldo.statusSaldo.toString()),
        ),
      ),
    );
  }
}
