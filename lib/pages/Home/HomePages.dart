import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_app/pages/Home/height_widget.dart';
import 'package:new_app/pages/Home/spo2.dart';
import 'package:new_app/pages/Home/weight.dart';
import 'Age.dart';
import 'BMICalculator.dart.dart';
import 'heart_widget.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double height = 170.0;
  int weight = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8FAFF),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hi, Steven",
                style: TextStyle(color: Colors.black45, fontSize: 18),
              ),
              Text(
                "Smart Mood",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 24,
                    fontWeight: FontWeight.w800),
              ),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Get Start",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 18),
                    ),
                  ),
                  Image(
                    image: AssetImage(
                      'assets/images/sticker 1.png',
                    ),
                    height: 190,
                    width: 210,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Activity Status",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              const HeartRateWidget(),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                        width: 200,
                          child: Spo2(),
                        ),
                        SizedBox(height: 5),
                        SizedBox(
                          width: 200,
                          child: BMICala(weight, height),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: HeightWidget(
                      onHeightChanged: (newHeight) {
                        setState(() {
                          height = newHeight;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      //width: 200,
                      child: WeightWidget(
                        onWeightChanged: (newWeight) {
                          setState(() {
                            weight = newWeight;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5),

                      child: AgeWidget(),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

