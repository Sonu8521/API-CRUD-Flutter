import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Todos_Provider.dart'; // Import your TodosProvider class
import 'Todos_datamodel.dart'; // Import your Todosdatamodel class

// class JsonTodosView extends StatefulWidget {
//   const JsonTodosView({Key? key}) : super(key: key);
//
//   @override
//   _JsonTodosViewState createState() => _JsonTodosViewState();
// }
//
// class _JsonTodosViewState extends State<JsonTodosView> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<TodosProvider>(context, listen: false).fetchTodos();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Json Todos Apis"),
//       ),
//       body: Consumer<TodosProvider>(
//         builder: (context, todosProvider, _) {
//           todosProvider.fetchTodos();
//           return Column(
//             children: [
//               // Optionally, you can add a section for adding new todos here
//               // Padding(
//               //   padding: const EdgeInsets.all(16.0),
//               //   child: Column(
//               //     crossAxisAlignment: CrossAxisAlignment.start,
//               //     children: [
//               //       Text(
//               //         'Create a new Todo:',
//               //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               //       ),
//               //       TextField(
//               //         controller: titleController,
//               //         decoration: InputDecoration(labelText: 'Title'),
//               //       ),
//               //       SizedBox(height: 16),
//               //       ElevatedButton(
//               //         onPressed: () async {
//               //           final newTodo = Todosdatamodel(
//               //             userId: 1,
//               //             id: 0,
//               //             title: titleController.text,
//               //             completed: false,
//               //           );
//               //           await todosProvider.createTodo(newTodo);
//               //           titleController.clear();
//               //         },
//               //         child: Text('Add Todo'),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               Expanded(
//                 child: todosProvider.isLoading
//                     ? Center(child: CircularProgressIndicator())
//                     : ListView.builder(
//                   itemCount: todosProvider.todos.length,
//                   itemBuilder: (context, index) {
//                     final todo = todosProvider.todos[index];
//                     return ListTile(
//                       title: Text(todo.title),
//                       // Uncomment and complete the ListTile according to your requirements
//                       // subtitle: Text(todo.completed ? 'Completed' : 'Pending'),
//                       // trailing: Row(
//                       //   mainAxisSize: MainAxisSize.min,
//                       //   children: [
//                       //     IconButton(
//                       //       icon: Icon(Icons.delete),
//                       //       onPressed: () {
//                       //         todosProvider.deleteTodo(todo.id);
//                       //       },
//                       //     ),
//                       //     IconButton(
//                       //       icon: Icon(Icons.edit),
//                       //       onPressed: () async {
//                       //         titleController.text = todo.title;
//                       //         await showDialog(
//                       //           context: context,
//                       //           builder: (BuildContext context) {
//                       //             return AlertDialog(
//                       //               title: Text('Update Todo'),
//                       //               content: Column(
//                       //                 mainAxisSize: MainAxisSize.min,
//                       //                 children: [
//                       //                   TextField(
//                       //                     controller: titleController,
//                       //                     decoration: InputDecoration(labelText: 'Title'),
//                       //                   ),
//                       //                   CheckboxListTile(
//                       //                     value: todo.completed,
//                       //                     title: Text('Completed'),
//                       //                     onChanged: (bool? value) {
//                       //                       todo.completed = value ?? false;
//                       //                     },
//                       //                   ),
//                       //                 ],
//                       //               ),
//                       //               actions: [
//                       //                 TextButton(
//                       //                   onPressed: () {
//                       //                     Navigator.pop(context);
//                       //                   },
//                       //                   child: Text('Cancel'),
//                       //                 ),
//                       //                 TextButton(
//                       //                   onPressed: () {
//                       //                     final updatedTodo = Todosdatamodel(
//                       //                       userId: todo.userId,
//                       //                       id: todo.id,
//                       //                       title: titleController.text,
//                       //                       completed: todo.completed,
//                       //                     );
//                       //                     todosProvider.updateTodo(updatedTodo);
//                       //                     Navigator.pop(context);
//                       //                   },
//                       //                   child: Text('Update'),
//                       //                 ),
//                       //               ],
//                       //             );
//                       //           },
//                       //         );
//                       //       },
//                       //     ),
//                       //   ],
//                       // ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }


class JsonTodosView extends StatefulWidget {
  const JsonTodosView({Key? key}) : super(key: key);

  @override
  _JsonTodosViewState createState() => _JsonTodosViewState();
}

class _JsonTodosViewState extends State<JsonTodosView> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodosProvider>(context, listen: false).fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Todos Apis"),
      ),
      body: Consumer<TodosProvider>(
        builder: (context, todosProvider, _) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: todosProvider.todos.length,
                  itemBuilder: (context, index) {
                    final todo = todosProvider.todos[index];
                    return ListTile(
                      title: Text(todo.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User ID: ${todo.userId}'),
                          Text('ID: ${todo.id}'),
                          Text('completed: ${todo.completed}'),

                        ],
                      ),


                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

