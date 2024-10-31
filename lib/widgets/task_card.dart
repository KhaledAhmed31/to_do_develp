import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/task_model.dart';
import 'package:to_do/providers/task_provider.dart';
import 'package:to_do/themes&colors/my_colors.dart';

class TaskCard extends StatelessWidget {
  final TaskModel taskModel;

  const TaskCard({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Slidable(
        startActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(12)),
            onPressed: (context) async {
              Provider.of<TaskProvider>(context, listen: false)
                  .deleteTask(taskModel.id);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            padding: const EdgeInsets.symmetric(horizontal: 10),
          )
        ]),
        child: SizedBox(
          height: 100,
          child: Center(
            child: ListTile(
              leading: VerticalDivider(
                color: MyColors.lightBlue,
                thickness: 4,
              ),
              title: Text(
                taskModel.title.trim(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                taskModel.description.trim(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: MyColors.lightBlue,
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.done_outline_rounded,
                    color: Colors.white,
                    size: 25,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
