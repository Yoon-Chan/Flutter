import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_example/addTodo.dart';
import 'package:sql_example/clearList.dart';
import 'package:sql_example/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DatabaseApp(db: database),
        '/add': (context) => AddTodoApp(db: database),
        '/clear' : (context) => ClearListApp(database),
      },
    );
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "title TEXT, content TEXT, active INTEGER)",
        );
      },
      version: 1,
    );
  }
}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;

  DatabaseApp({required this.db});

  @override
  State<StatefulWidget> createState() => _DatabaseApp();
}

class _DatabaseApp extends State<DatabaseApp> {
  Future<List<Todo>>? todoList;

  @override
  void initState() {
    super.initState();
    todoList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Example'),
        actions: [
          TextButton(
              onPressed: ()  async {
                await Navigator.of(context).pushNamed('/clear');
                setState(() {
                  todoList = getTodos();
                });
              },
              child: Text(
                '완료한 일',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return CircularProgressIndicator();
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                case ConnectionState.active:
                  return CircularProgressIndicator();
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Todo todo = (snapshot.data as List<Todo>)[index];
                        return ListTile(
                          onLongPress: () async {
                            Todo result = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('${todo.id} : ${todo.title}'),
                                  content: Text('${todo.content}를 삭제 하겠습니까?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(todo);
                                        },
                                        child: Text('예')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('아니요'))
                                  ],
                                );
                              },
                            );
                            _deleteTodo(result);
                          },
                          onTap: () async {
                            TextEditingController controller =
                                TextEditingController();

                            Todo result = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('${todo.id} : ${todo.title}'),
                                  content: TextField(
                                    controller: controller,
                                    keyboardType: TextInputType.text,
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            todo.active == 1
                                                ? todo.active = 0
                                                : todo.active = 1;

                                            todo.content =
                                                controller.value.text;
                                          });
                                          Navigator.of(context).pop(todo);
                                        },
                                        child: Text('예')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('아니요')),
                                  ],
                                );
                              },
                            );

                            _updateTodo(result);
                          },
                          title: Text(
                            todo.title!,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Container(
                            child: Column(
                              children: [
                                Text(todo.content!),
                                Text('체크 : ' +
                                    (todo.active == 1 ? 'true' : 'false')),
                                Container(
                                  height: 1,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: (snapshot.data as List<Todo>).length,
                    );
                  } else {
                    return Text('No data');
                  }
              }
            },
            future: todoList,
          ),
        ),
      ),
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
            onPressed: () async {
              final todo = await Navigator.of(context).pushNamed('/add');
              if (todo != null) {
                _insertTodo(todo as Todo);
              }
            },
            heroTag: null,
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10,),
          FloatingActionButton(
              onPressed: () async {
                _allUpdate();
              },
            heroTag: null,
            child: Icon(Icons.update),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }

  void _insertTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    setState(() {
      todoList = getTodos();
    });
  }

  Future<List<Todo>> getTodos() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('todos');

    return List.generate(maps.length, (index) {
      int active = maps[index]['active'] == 1 ? 1 : 0;
      return Todo(
        title: maps[index]['title'].toString(),
        content: maps[index]['content'].toString(),
        active: active,
        id: maps[index]['id'],
      );
    });
  }

  void _updateTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );

    setState(() {
      todoList = getTodos();
    });
  }

  void _deleteTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.delete('todos', where: 'id=?', whereArgs: [todo.id]);
    setState(() {
      todoList = getTodos();
    });
  }


  void _allUpdate() async {
    final Database database = await widget.db;
    await database.rawUpdate('update todos set active=1 where active=0');
    setState(() {
      todoList = getTodos();
    });
  }
}
