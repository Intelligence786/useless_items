import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static Widget builder(BuildContext context) {
    return OnboardingScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(1.h),
            child: CustomImageView(
              fit: BoxFit.fitHeight,
              imagePath: ImageConstant.imgGroup,
            ),
          ),
          SizedBox(
            height: 30.v,
          ),
          Column(
            children: [
              Text(
                'Get rid of\nunnecessary items',
                style: theme.textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16.v,
              ),
              Text(
                'Make a list of items you don\'t need, write\ndown the purchase price and record the\npotential sale price',
                style: CustomTextStyles.bodyLargePrimaryContainer_1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(
            height: 30.v,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: CustomElevatedButton(
              text: 'Continue',
              onPressed: () {
                NavigatorService.pushNamedAndRemoveUntil(AppRoutes.acquaintedScreen);
              },
            ),
          ),
        ],
      ),

    );
  }
}
