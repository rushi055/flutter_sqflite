import 'package:flutter/material.dart';
import 'DB/dbhelper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// Insert function example
  void _insertData() async {
    int i = await DatabaseHelper.instance.insertFunction({
      DatabaseHelper.colName: 'Rushikesh',
    });
    print('Inserted ID is: $i');
  }

// Query function example
  void _queryData() async {
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAllFunction();
    print(queryRows);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQFLITE Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _insertData,
              child: Text('Insert'),
            ),
            ElevatedButton(
              onPressed: _queryData,
              child: Text('Query'),
            ),
          ],
        ),
      ),
    );
  }
}
