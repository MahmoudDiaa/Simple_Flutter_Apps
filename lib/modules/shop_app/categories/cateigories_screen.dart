import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter/models/shop_app/categories_model.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) =>
                buildCatItem(cubit.categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => divider(),
            itemCount: cubit.categoriesModel!.data!.data!.length);
      },
    );
  }

  Widget buildCatItem(Categories data) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(data.image!),
              width: 120.0,
              height: 120.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              data.name!.trim(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Spacer(),
                 Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                )
          ],
        ),
      );
}
