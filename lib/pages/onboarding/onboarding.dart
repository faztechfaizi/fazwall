import 'package:fazwalls/constants/textstring.dart';
import 'package:fazwalls/pages/onboarding/onboarding_page.dart';
import 'package:fazwalls/pages/welcome_page/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  void onPageChangeCallback(int activePageIndex) {
    setState(() {
      currentpage = activePageIndex;
    });
  }

  final controller = LiquidController();
  int currentpage = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const OnboardingPage(
        color: Color.fromARGB(255, 76, 175, 80),
        image: AssetImage('assets/images/ob1.png'),
        text: tOnBoardingTitle1,
        subtitle: tOnBoardingSubTitle1,
      ),
      const OnboardingPage(
        color: Color.fromARGB(255, 97, 178, 236),
        image: AssetImage('assets/images/ob2.png'),
        text: tOnBoardingTitle2,
        subtitle: tOnBoardingSubTitle2,
      ),
      OnboardingPage(
        color: const Color.fromARGB(255, 160, 119, 226),
        image: const AssetImage('assets/images/ob3.png'),
        text: tOnBoardingTitle3,
        subtitle: tOnBoardingSubTitle3,
        button: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelcomeScreen()));
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),),
            child: Text(
              'Get Started',
              style: Theme.of(context).textTheme.titleSmall,
            )),
      ),
    ];

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: pages,
            fullTransitionValue: 300,
            onPageChangeCallback: onPageChangeCallback,
            positionSlideIcon: 0.9,
            liquidController: controller,
            enableSideReveal: true,
            slideIconWidget:
                currentpage == 2 ? null : const Icon(Icons.arrow_back_ios),
            enableLoop: false,
          ),
          Positioned(
            bottom: 10,
            child: AnimatedSmoothIndicator(
              activeIndex: controller.currentPage,
              count: 3,
              effect: const ExpandingDotsEffect(
                activeDotColor: Color(0xff272727),
                dotHeight: 8,
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 25,
            child: TextButton(
              onPressed: () {
                controller.jumpToPage(page: 2);
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                    color: Colors.black26, fontSize: 15, fontFamily: 'Poppins'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
