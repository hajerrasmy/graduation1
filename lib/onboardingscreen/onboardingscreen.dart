
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../auth/SignUp/SignUpScreen.dart';
import 'intro_page.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "onboard";

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/splash Screen.png"),
              fit: BoxFit.fill)),
      child: Scaffold(
        body: Stack(
          children: [
            const Text(
              "skip",
              style: TextStyle(color: Colors.white),
            ),
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              children: [
                IntroOnboarding(
                  img: "assets/images/Onboarding1.gif",
                  title: "Get ready to experience our smart bracelet",
                ),
                IntroOnboarding(
                    img: "assets/images/Onboarding2.gif",
                    title: "Our bracelet detects emotions in real-time "),
                IntroOnboarding(
                  img: "assets/images/Onboarding3.gif",
                  title:
                      "Stay connected with your child's well-being effortlessly",
                )
                // Container(color: Colors.blue),
                //  Container(color: Colors.red),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 200.0,
                ),
                child: SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotColor: Color(0xff5D9CEC),
                      activeDotColor: Color(0xff0076CA),
                    )),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 15),
              padding: const EdgeInsets.only(top: 750.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //Text("Skip" ,),
                  !onLastPage
                      ? ElevatedButton.icon(
                          onPressed: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.elasticIn);
                          },
                          label: const Text(
                            "Next",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff0076CA),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10)),
                                child: const Text(
                                  "Login Now",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      SignUpScreen.routeName);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10)),
                                child: const Text(
                                  "Sign up ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                )),
                            const SizedBox(
                              width: 25
                              ,
                            ),
                          ],
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
