import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) Navigator.pop(context);
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.title[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                  }
                } else {
                  cubit.changeBottomSheetState(true);
                  scaffoldKey.currentState!
                      .showBottomSheet((context) => Container(
                            padding: EdgeInsetsDirectional.all(20.0),
                            color: Colors.grey[100],
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultTextFormField(
                                      controller: titleController,
                                      textInputType: TextInputType.text,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'title must not be empty';
                                        }
                                        return null;
                                      },
                                      label: 'Task Title',
                                      prefix: Icons.title),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  defaultTextFormField(
                                      controller: timeController,
                                      textInputType: TextInputType.datetime,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'time must not be empty';
                                        }
                                        return null;
                                      },
                                      onTab: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          timeController.text =
                                              value!.format(context).toString();
                                        });
                                      },
                                      label: 'Time',
                                      prefix: Icons.watch_later_outlined),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  defaultTextFormField(
                                      controller: dateController,
                                      textInputType: TextInputType.datetime,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return 'date  must not be empty';
                                        }
                                        return null;
                                      },
                                      onTab: () {
                                        showDatePicker(
                                                context: context,
                                                firstDate: DateTime.now(),
                                                initialDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2023-07-07'))
                                            .then((value) {
                                          print(value);
                                          dateController.text =
                                              DateFormat.yMMMd()
                                                  .format(value!)
                                                  .toString();
                                        });
                                      },
                                      label: 'Date',
                                      prefix: Icons.date_range),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    // setState(() {
                    //   isBottomSheetShown = false;
                    cubit.changeBottomSheetState(false);
                    // });
                  });
                }
              },
              mini: false,
              child:
                  cubit.isBottomSheetShown ? Icon(Icons.add) : Icon(Icons.edit),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 10,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu), label: 'New Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.check), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archive')
              ],
            ),
          );
        },
      ),
    );
  }
}
