import 'package:flutter/material.dart';

class DataKelompok extends StatelessWidget {
  const DataKelompok({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Kelompok")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text("Rafa Putra Witata"),
              subtitle: Text("NIM: 123230141"),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text("Muhammad Aditya Nurdiansyah"),
              subtitle: Text("NIM: 123230146"),
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text("Dicky Mahendra Putra"),
              subtitle: Text("NIM: 123230211"),
            ),
          ),
        ],
      ),
    );
  }
}