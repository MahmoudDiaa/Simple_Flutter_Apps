import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubic = NewsCubit.get(context);

    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) => ScreenTypeLayout(
        mobile: articleBuilder(cubic.business, context),
        desktop: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: articleBuilder(cubic.business, context)),
            if (cubic.selectedItemIndex != null)
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                "${cubic.business[cubic.selectedItemIndex!]['description']}",
                style: TextStyle(fontSize: 20),
              ),
                  ))
          ],
        ),
        breakpoints: ScreenBreakpoints(desktop: 900, tablet: 600, watch: 100),
      ),
    );
  }
}
