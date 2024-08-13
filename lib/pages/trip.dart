import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:my_first_project/config/config.dart';
import 'package:my_first_project/models/response/TripbyIDGetRepones.dart';

class TripPage extends StatefulWidget {
  int idx = 0;

  TripPage({super.key, required this.idx});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  String url = "";
  late TripbyIdGetRepones data;
  late Future<void> loadData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData = loadDataAsync();

    // ไปดู attribute ที่ class แม่
    log(widget.idx.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: loadData,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(child: Text(data.name));
          }),
    );
  }

  Future<void> loadDataAsync() async {
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    var res = await http.get(Uri.parse('$url/trips/${widget.idx.toString()}'));
    data = tripbyIdGetReponesFromJson(res.body);
  }
}
