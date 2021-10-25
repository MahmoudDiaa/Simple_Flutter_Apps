import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
 final  searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).searchResult;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFormField(
                    controller: searchController,
                    textInputType: TextInputType.text,
                    onChanged: (value) {
                      NewsCubit.get(context).getSearchResult(value);
                    },
                    validate: (value) {
                      if (value.isEmpty) {
                        return 'search must not be empty';
                      } else {
                        return null;
                      }
                    },
                    label: 'Search',
                    prefix: Icons.search),
              ),
              Expanded(

                child: articleBuilder(list, context,isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
