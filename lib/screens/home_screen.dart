import 'package:first_app/components/task.dart';
import 'package:first_app/data/task_dao.dart';
import 'package:first_app/screens/form_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void deleteTask(String taskName) {
    setState(() {
      TaskDao().delete(taskName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.refresh))
        ],
        title: const Text(
          "Tarefas",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<Task>? items = snapshot.data;
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Carregando'),
                      ],
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Task tarefa = items[index];

                            return Task(
                                description: tarefa.description,
                                difficulty: tarefa.difficulty,
                                urlImage: tarefa.urlImage,
                                nivel: tarefa.nivel,
                                deleteFunction: (context) =>
                                    deleteTask(tarefa.description));
                          });
                    }
                    return const Center(
                      child: Column(children: [
                        Icon(Icons.error_outline, size: 128),
                        Text(
                          'Não há nenhuma Tarefa',
                          style: TextStyle(fontSize: 32),
                        ),
                      ]),
                    );
                  }
                  return const Text(' Erro ao carregar Tarefas ');
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (newContext) => FormScreen(taskContext: context)),
          ).then((value) => setState(() {}));
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
