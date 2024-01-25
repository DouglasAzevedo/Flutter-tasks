import 'package:first_app/components/task.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text(
          "Tarefas",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: const [
          Task(
            description: "Aprender Flutter",
            urlImage:
                "https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large",
            dificuldade: 4,
          ),
          Task(
            description: "Refatorar código do aplicativo",
            urlImage:
                "https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large",
            dificuldade: 2,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
