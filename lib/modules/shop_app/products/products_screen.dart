import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter/models/shop_app/categories_model.dart';
import 'package:udemy_flutter/models/shop_app/home_model.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) =>
              productsBuilder(cubit.homeModel!, cubit.categoriesModel!, cubit),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
      listener: (BuildContext context, Object? state) {
        if (state is ShopErrorFavoritesDataState)
          showToast(message: state.error, states: ToastStates.ERROR);
      },
    );
  }

  Widget productsBuilder(
          HomeModel model, CategoriesModel categoriesModel, ShopCubit cubit) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CarouselSlider(
              items: model.data!.banners!
                  .map((e) => Image(
                        image: NetworkImage(e.image!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 120.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) =>
                        buildCategoryItem(categoriesModel.data!.data![index]),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      width: 10.0,
                    ),
                    itemCount: categoriesModel.data!.data!.length,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            color: Colors.grey[100],
            child: GridView.count(
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 5.0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.56,
              children: List.generate(
                model.data!.products!.length,
                (index) =>
                    buildGridProduct(model.data!.products![index], cubit),
              ),
            ),
          ),
        ]),
      );

  Widget buildGridProduct(
    ProductsModel model,
    ShopCubit cubit,
  ) =>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.discount != 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    color: Colors.red,
                    child: Text(
                      'discount'.toUpperCase(),
                      style: TextStyle(fontSize: 9.0, color: Colors.white),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Text(
                          model.price!.toString(),
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
                        if (model.discount != 0)
                          Text(
                            model.oldPrice!.toString(),
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
                          backgroundColor: cubit.favorites[model.id]!
                              ? defaultColor
                              : Colors.grey,
                          child: IconButton(
                            onPressed: () {
                              cubit.postFavorites(model.id!);
                            },
                            icon: Icon(
                              Icons.favorite_outline_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget buildCategoryItem(Categories categories) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(categories.image!),
            width: 120.0,
            height: 120.0,
            fit: BoxFit.cover,
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: 120,
              color: Colors.black.withOpacity(0.8),
              child: Text(
                categories.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ))
        ],
      );
}
