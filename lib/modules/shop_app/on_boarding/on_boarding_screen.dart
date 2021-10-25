import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

class BoardingModel {
  final String image;

  final String title;

  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboard.jpg',
        title: 'On Board 1 Title',
        body: 'on Board 1 Body'),
    BoardingModel(
        image: 'assets/images/onboard.jpg',
        title: 'On Board 2 Title',
        body: 'on Board 2 Body'),
    BoardingModel(
        image: 'assets/images/onboard.jpg',
        title: 'On Board 3 Title',
        body: 'on Board 3 Body')
  ];
  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [TextButton(onPressed: submit, child: Text('SKIP'))],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index >= boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  itemBuilder: (context, index) =>
                      buildOnBoardItems(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10.0,
                        activeDotColor: defaultColor,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5.0),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildOnBoardItems(BoardingModel boarding) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(boarding.image))),
          Text(
            boarding.title,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            boarding.body,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
