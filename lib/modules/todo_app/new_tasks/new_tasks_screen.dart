import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
     listener: (context,state){},
      builder: (context,state){
       var tasks = AppCubit.get(context).newTasks;
       return ListView.separated(
           itemBuilder: (context, index) => buildTaskItem(model: tasks[index],context: context),
           separatorBuilder: (context, index) => Container(
             width: double.infinity,
             height: 1,
             color: Colors.grey[300],
           ),
           itemCount: tasks.length);

      },
    );
  }
}
