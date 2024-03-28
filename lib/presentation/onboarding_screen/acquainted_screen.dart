import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class AcquaintedScreen extends StatefulWidget {
  const AcquaintedScreen({super.key});

  static Widget builder(BuildContext context) {
    return AcquaintedScreen();
  }

  @override
  State<AcquaintedScreen> createState() => _AcquaintedScreenState();
}

class _AcquaintedScreenState extends State<AcquaintedScreen> {
  bool isOptionChoose = false;

  TextEditingController _textFieldController = TextEditingController();

  bool isTextFieldFilled() {
    setState(() {});
    return _textFieldController.text.isNotEmpty;
  }

  String _textFieldValue = '';

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(_updateTextFieldValue);
  }

  void _updateTextFieldValue() {
    setState(() {
      _textFieldValue = _textFieldController.text;
    });
  }

  List options = [
    {'title': '1-5', 'isActive': false},
    {'title': '6-10', 'isActive': false},
    {'title': 'More than 10', 'isActive': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 80.v,
              ),
              Text(
                'Let’s get acquainted',
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(
                height: 25.v,
              ),
              Text('What\'s your name?',
                  style: CustomTextStyles.bodyMediumErrorContainer),
              SizedBox(
                height: 4.v,
              ),
              CustomTextFormField(
                controller: _textFieldController,
                textStyle: CustomTextStyles.bodyLargePrimaryContainer,
              ),
              SizedBox(
                height: 16.v,
              ),
              _buildChooser(context),
              SizedBox(
                height: 16.v,
              ),
              CustomElevatedButton(
                isDisabled: !isTextFieldFilled() || !isOptionChoose,
                text: 'Continue',
                onPressed: () {
                  NavigatorService.popAndPushNamed(AppRoutes.mainScreen);
                },
                buttonStyle: ElevatedButton.styleFrom(
                  disabledBackgroundColor: theme.colorScheme.primary
                      .withOpacity(.3), // Background Color
                  disabledForegroundColor: theme.colorScheme.onPrimaryContainer
                      .withOpacity(.3), //Text Color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChooser(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'How much unnecessary stuff do you have?',
            style: CustomTextStyles.bodyLargePrimaryContainer_1,
          ),
        ),
        SizedBox(
          height: 4.v,
        ),
        Column(
          children: options
              .map(
                (option) => Container(
                  margin: EdgeInsets.symmetric(vertical: 8.v),
                  height: 52.v,
                  //width: double.infinity,
                  decoration: customBoxDecoration(option['isActive']),
                  child: InkWell(
                    onTap: () {
                      changeState(option);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${option['title']}',
                          textAlign: TextAlign.start,
                          style: option['isActive']
                              ? CustomTextStyles.titleMediumPrimary
                              : CustomTextStyles.titleMediumSemiBold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  changeState(option) {
    setState(() {
      for (var item in options) {
        if (item == option) {
          isOptionChoose = true;
          item['isActive'] = true;
        } else {
          item['isActive'] = false;
        }
      }
    });
  }

  customBoxDecoration(isActive) {
    return BoxDecoration(
      color: isActive ? appTheme.gray300 : appTheme.gray300,
      border: isActive
          ? Border.all(color: theme.colorScheme.primary)
          : Border.all(color: appTheme.gray300),
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
    );
  }
}
