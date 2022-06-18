import 'dart:ffi';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/config/api.dart';
import 'package:whatsapp/config/constant.dart';
import 'package:whatsapp/http/info.dart';
import 'package:whatsapp/http/names.dart';
import 'package:whatsapp/models/info.dart';

class ApisScreen extends StatefulWidget {
  const ApisScreen({Key? key}) : super(key: key);

  @override
  State<ApisScreen> createState() => _ApisScreenState();
}

class _ApisScreenState extends State<ApisScreen> {
  final double ddFontSize = 18; //dropdownFonstSize
  late Future<List<String>> items;
  String? selectedValue;

  static int page = 0;
  ScrollController _sc = new ScrollController();
  List<Info> info = <Info>[];

  bool dataIsFullyLoaded = false;
  @override
  void initState() {
    super.initState();
    items = fetchNames();
    loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButtonHideUnderline(
            child: FutureBuilder<List<String>>(
              future: items,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButton2(
                    hint: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: ddFontSize,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: snapshot.data!
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  fontSize: ddFontSize,
                                ),
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                    buttonHeight: 60,
                    buttonWidth: 200,
                    itemHeight: 40,
                  );
                }

                // By default, show a loading spinner.
                return const Text("Error occured");
              },
            ),
          ),
        ),
        DataTable(columns: createColumns(), rows: createRows()),
      ],
    );
  }

  DataTable createDataTable() {
    return DataTable(
        columns: createColumns(), rows: createRows(), horizontalMargin: 10);
  }

  List<DataColumn> createColumns() {
    return [
      const DataColumn(label: Text('Name')),
      const DataColumn(label: Text('School')),
      const DataColumn(label: Text('Age')),
      const DataColumn(label: Text('Address'))
    ];
  }

  List<DataRow> createRows() {
    String displayIfNull = Constant.displayIfNull;
    return info.map((e) => DataRow(cells: 
      [
        DataCell(Text(e.name ?? displayIfNull)),
        DataCell(Text(e.school ?? displayIfNull)),
        DataCell(Text(e.age != null ? e.age.toString() : displayIfNull)),
        DataCell(Text(e.address ?? displayIfNull)),
      ]
    )).toList();
    // return [];
  }

  void loadMore() async {
    List<Info>? loadedMore =
        await fetchInfo(selectedValue, page, Api.getStudentLimit);
    setState(() {
      if (loadedMore != null) {
        info = info + loadedMore;
        page++;
        if (loadedMore.length < Api.getStudentLimit) {
          dataIsFullyLoaded = true;
        }
      } else {
        dataIsFullyLoaded = true;
      }
    });
  }
}
