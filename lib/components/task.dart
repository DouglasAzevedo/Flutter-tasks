import 'package:first_app/components/difficulty.dart';
import 'package:first_app/data/task_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Task extends StatefulWidget {
  final String description;
  final String urlImage;
  final int difficulty;

  Function(BuildContext)? deleteFunction;

  Task(
      {super.key,
      required this.description,
      required this.urlImage,
      required this.difficulty,
      required this.nivel,
      this.deleteFunction});

  Task getTask() {
    return Task(
        description: description,
        urlImage: urlImage,
        difficulty: difficulty,
        nivel: nivel);
  }

  int nivel = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.blue),
              height: 140,
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey),
                        width: 72,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            widget.urlImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              widget.description,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Difficulty(dificuldade: widget.difficulty)
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.nivel++;
                            TaskDao().save(widget.getTask());
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade500,
                          padding: const EdgeInsets.all(8),
                        ),
                        child: const Icon(Icons.arrow_drop_up,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          color: Colors.black,
                          value: (widget.difficulty > 0)
                              ? (widget.nivel / widget.difficulty) / 10
                              : 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Nível ${widget.nivel}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
