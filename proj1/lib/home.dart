import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proj1/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final _DBbox = Hive.box('DBbox');
  
  @override
  Widget build(BuildContext context) {
    var keys = _DBbox.keys.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text("stored data"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage()
                  ),
                );
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Email', style: TextStyle(fontSize: 18)),
              ),
              DataColumn(
                label: Text('Password', style: TextStyle(fontSize: 18)),
              ),
            ],
            rows: List<DataRow>.generate(
              keys.length,
              (index) {
                var key = keys[index];
                var user = _DBbox.get(key);

               
                print('User data at index $index: $user');

                // Ensure user has at least 3 elements
                if (user.length < 2) {
                  return DataRow(
                    cells: <DataCell>[
                      DataCell(Text('invalid user', style: TextStyle(fontSize: 18))),
                      DataCell(Text('invalid user', style: TextStyle(fontSize: 18))),
                    ],
                  );
                }

                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text(user[0], style: TextStyle(fontSize: 18))),
                    DataCell(Text(user[1], style: TextStyle(fontSize: 18))),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
