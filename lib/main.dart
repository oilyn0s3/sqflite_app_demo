import 'package:flutter/material.dart';
import 'package:sqflite_app_demo/sql_helper.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   primarySwatch: Colors.purple,
      // ),
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.purple,
      )),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _journal = [];
  bool _isLoading = true;

  void _getJournals() async {
    final allItems = await SQLHelper.getAllItems();
    setState(() {
      _journal = allItems;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        elevation: 0,
        title: const Text("SQLite Demo"),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Hello World!'),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.add_box_outlined,
          size: 30,
        ),
        onPressed: () {},
      ),
    );
  }
}
