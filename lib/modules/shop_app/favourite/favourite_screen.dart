import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter/models/shop_app/favorite_model_entity.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            fallback:(context)=> Center(child: CircularProgressIndicator()),
            condition: state is! ShopLoadingGetFavoritesDataState,
            builder: (context) =>
                ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) =>
                        buildFavoriteItem(
                            cubit.favoriteModel!.data!.data![index].product!,
                            cubit),
                    separatorBuilder: (context, index) => divider(),
                    itemCount: cubit.favoriteModel!.data!.data!.length),
          );
        });
  }

  Widget buildFavoriteItem(FavoriteModelDataDataProduct product,
      ShopCubit cubit) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(product.image!),
              height: 120,
              width: 120,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          product.price!.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              color: defaultColor,
                              fontSize: 14.0,
                              height: 1.3,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (product.discount != 0)
                          Text(
                            product.oldPrice!.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14.0,
                                height: 1.3,
                                fontWeight: FontWeight.bold),
                          ),
                        Spacer(),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor:
                          cubit.favorites[product.id]!
                              ? defaultColor : Colors.grey,
                          child: IconButton(
                            onPressed: () {
                              cubit.postFavorites(product.id!);
                            },
                            icon: Icon(
                              Icons.favorite_outline_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
