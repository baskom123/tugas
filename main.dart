import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/m02/latihan1.dart';
import 'package:flutter_application_1/m02/provider.dart';
import 'package:flutter_application_1/mo1/contoh2.dart';

import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (context) => MyBioModel(), child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Contoh02(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _data = [];
  String desc = "";
  Future<List<String>> getUserData() async {
    _data = ["Bunny", "Funny", "Miles"];
    await Future.delayed(const Duration(seconds: 3), () {
      print("Downloaded ${_data.length} data");
    });
    return _data;
  }

  List<Map> _userData = [];
  Future<List<Map>> getUserInfo() async {
    _userData = [
      {"name": "yanti", "contact": "25634"},
      {"name": "yanto", "contact": "26547"},
      {"name": "acep", "contact": "26432"}
    ];
    await Future.delayed(const Duration(seconds: 4), () {
      desc = "Downloaded ${_userData.length} data from userData..";
    });
    return _userData;
  }

  void getData() async {
    var result = await getUserData();
    setState(() {
      _data = result;
    });
  }

  void getUserInfoData() async {
    var res = await getUserInfo();
    setState(() {
      desc = "Downloaded ${_userData.length} data from userData..";
      _userData = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Flutter Demo Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  getData();
                },
                child: Text('Set User')),
            ElevatedButton(
                onPressed: () {
                  getUserInfoData();
                  print(desc);
                },
                child: Text("Latihan")),
            _userData.isEmpty ? Text(desc) : Container(),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (context) => const Contoh2()));
            //     },
            //     child: Text("Stream")),
            Text("Daftar Pengguna"),
            Text(
              '$_data',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            _userData.isEmpty
                ? Container()
                : Expanded(
                    child: ListView.builder(
                      itemCount: _userData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Text(
                              "${_userData[index]["name"]} ${_userData[index]["contact"]}"),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
