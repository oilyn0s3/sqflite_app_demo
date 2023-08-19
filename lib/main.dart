import 'package:flutter/material.dart';
import 'package:sqflite_app_demo/color_data.dart';
import 'package:sqflite_app_demo/sql_helper.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.purple,
      // ),
      theme: fTheme(context),
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
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _getJournals() async {
    final allItems = await SQLHelper.getAllItems();

    setState(() {
      _journal = allItems;
      _isLoading = false;
    });
  }

  void addItem() {
    SQLHelper.addItem(
      _titleController.text,
      _descriptionController.text,
    );
    _getJournals();
  }

  void updateItem(int id) {
    SQLHelper.updateItem(
      id,
      _titleController.text,
      _descriptionController.text,
    );
    _getJournals();
  }

  void deleteItem(int id) {
    SQLHelper.deleteItem(id);
    _getJournals();
  }

  inputAlert(int? id) {
    if (id != null) {
      final existingItem =
          _journal.firstWhere((element) => element['id'] == id);
      _titleController.text = existingItem['title'];
      _descriptionController.text = existingItem['description'];
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
          height: 250,
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: kTextInputDecoration('Title'),
              ),
              const SizedBox(height: 10),
              TextField(
                scrollPhysics: const BouncingScrollPhysics(),
                maxLines: 4,
                controller: _descriptionController,
                decoration: kTextInputDecoration('Type a description...'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        (id == null) ? addItem() : updateItem(id);
                        _titleController.clear();
                        _descriptionController.clear();
                        Navigator.pop(context);
                      },
                      child: Text(id == null ? 'Add' : 'Update')),
                ],
              )
            ],
          ),
        ),
        // actionsPadding: const EdgeInsets.all(30),
        // actions:
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: dominantColor,
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
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.add_box_outlined,
          size: 30,
        ),
        onPressed: () => inputAlert(null),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: _journal.length,
          itemBuilder: (context, index) {
            var item = _journal[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ListTile(
                // isThreeLine: true,
                title: Text(
                  item['title'],
                  style: TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  item['description'],
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => inputAlert(item['id']),
                        icon: Icon(
                          Icons.edit,
                          color: secondaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () => deleteItem(item['id']),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[800],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}




/// DEAD Dismissible Code
/// 
/// Dismissible(
              
            //   background: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       color: Colors.yellow[200],
            //     ),
            //     child: const Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         SizedBox(width: 20),
            //         Icon(Icons.edit),
            //       ],
            //     ),
            //   ),
            //   secondaryBackground: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       color: Colors.red[200],
            //     ),
            //     child: const Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Icon(Icons.delete),
            //         SizedBox(width: 20),
            //       ],
            //     ),
            //   ),
            //   onDismissed: (direction) =>
            //       direction == DismissDirection.endToStart
            //           ? print('Delete')
            //           : inputAlert(item['id']),
            //   key: ValueKey(item),
            //   child: ListTile(
            //     isThreeLine: true,
            //     title: Text(item['title']),
            //     subtitle: Text(
            //       item['description'],
            //       maxLines: 2,
            //       overflow: TextOverflow.fade,
            //     ),
            //   ),
            // );
///
///
///