

import 'package:e_commerce_app/components/components.dart';
import 'package:e_commerce_app/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:e_commerce_app/modules/shop_app/login/shop_login_screen.dart';



class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();

  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(image: 'images/first.jpg', title: 'title 1', body: 'body 1'),
    BoardingModel(image: 'images/second.jpg', title: 'title 2', body: 'body 2'),
    BoardingModel(image: 'images/third.png', title: 'title 3', body: 'body 3')
  ];
   void submit({isLast}){
     CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
       if(value  ||  isLast){

         navigateToAndFinish(context, ShopLoginScreen());
       }
     });
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[800],
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: submit
                , child: Text('Skip',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0
            ),))
          ],
          backgroundColor: Colors.yellow[800],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                       print(CacheHelper.getData('onBoarding'));

                        print(boarding.length.toString());
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: boardingController,
                  itemBuilder: (context, index) =>
                      builtBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardingController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.yellow,
                      activeDotColor: Colors.deepOrange,
                      spacing: 10.0,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {

                      isLast ? submit(isLast: isLast) : boardingController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget builtBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              model.image,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(model.body),
        ],
      );
}
