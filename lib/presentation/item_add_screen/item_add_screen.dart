import 'package:flutter/material.dart';
import 'package:useless_items/core/app_export.dart';
import 'package:useless_items/data/data_manager.dart';
import 'package:useless_items/data/models/item_model/item_model.dart';

import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class ItemAddScreen extends StatefulWidget {
  final ItemModel? itemModel;

  const ItemAddScreen({
    super.key,
    this.itemModel,
  });

  static Widget builder(BuildContext context, ItemModel? itemModel) {
    return ItemAddScreen(
      itemModel: itemModel ?? null,
    );
  }

  @override
  State<ItemAddScreen> createState() => _ItemAddScreenState();
}

class _ItemAddScreenState extends State<ItemAddScreen> {
  int screenState = 1;
  TextEditingController nameOfItemController = TextEditingController();
  TextEditingController itemCategoryController = TextEditingController();
  TextEditingController uselessReasonController = TextEditingController();
  CustomTextEditingController boughtPriceController =
      CustomTextEditingController();
  CustomTextEditingController sellPriceController =
      CustomTextEditingController();

  FocusNode nameOfItemNode = FocusNode();
  FocusNode itemCategoryNode = FocusNode();
  FocusNode uselessReasonNode = FocusNode();
  FocusNode boughtPriceNode = FocusNode();
  FocusNode sellPriceNode = FocusNode();

  bool allFieldFills = false;
  bool isOptionChoose = false;
  String chooseOption = '';
  List options = [
    {
      'title': 'Good',
      'isActive': false,
      'imagePath': ImageConstant.imgFrame41192
    },
    {
      'title': 'Not bad',
      'isActive': false,
      'imagePath': ImageConstant.imgFrame41193
    },
    {
      'title': 'Not good',
      'isActive': false,
      'imagePath': ImageConstant.imgFrame41191
    },
    {
      'title': 'Bad',
      'isActive': false,
      'imagePath': ImageConstant.imgFrame41193Red800
    },
  ];

  bool isFirstFieldsFill = false;
  bool isSecondFieldsFill = false;

  void firstTextFieldFills() {
    isFirstFieldsFill = nameOfItemController.text.isNotEmpty &&
        itemCategoryController.text.isNotEmpty &&
        uselessReasonController.text.isNotEmpty;
    isSecondFieldsFill = boughtPriceController.text.isNotEmpty &&
        sellPriceController.text.isNotEmpty;
  }

  @override
  void initState() {
    screenState = 1;
    if (widget.itemModel != null) {
      nameOfItemController.text = widget.itemModel!.nameOfItem;
      itemCategoryController.text = widget.itemModel!.itemCategory;
      uselessReasonController.text = widget.itemModel!.uselessReason;
      boughtPriceController.text =
          widget.itemModel!.broughtPrice.toStringAsFixed(0);
      sellPriceController.text = widget.itemModel!.sellPrice.toStringAsFixed(0);
      dynamic option =
          options[widget.itemModel!.itemState.index]['isActive'] = true;
      isOptionChoose = true;
      chooseOption = options[widget.itemModel!.itemState.index]['title'];
    }
    setState(() {
      firstTextFieldFills();
      //changeState(option);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 52.v,
        leadingWidth: 100.h,
        leading: Container(
          width: 85.h,
          child: TextButton(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios),
                SizedBox(width: 4.h),
                Text(
                  'Back',
                  style: CustomTextStyles.bodyMediumPrimary,
                ),
              ],
            ),
            onPressed: () {
              if (screenState == 2) {
                setState(() {
                  screenState = 1;
                });
              } else {
                NavigatorService.goBack();
              }
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Useless item',
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(
                height: 20.v,
              ),
              screenState == 1
                  ? _firstScreenBuild(context)
                  : _secondScreenBuild(context),
            ],
          ),
        ),
      ),
    );
  }

  _firstScreenBuild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _textField(context,
            name: 'The name of item',
            controller: nameOfItemController,
            node: nameOfItemNode),
        _textField(context,
            name: 'Item category',
            controller: itemCategoryController,
            node: itemCategoryNode),
        _textField(context,
            name: 'Why do you think this thing is useless?',
            controller: uselessReasonController,
            node: uselessReasonNode),
        _buildChooser(context),
        SizedBox(
          height: 20.v,
        ),
        CustomElevatedButton(
          isDisabled: !isFirstFieldsFill || !isOptionChoose,
          text: 'Continue',
          onPressed: () {
            setState(() {
              screenState = 2;
            });
          },
          buttonStyle: ElevatedButton.styleFrom(
            disabledBackgroundColor:
                theme.colorScheme.primary.withOpacity(.3), // Background Color
            disabledForegroundColor: theme.colorScheme.onPrimaryContainer
                .withOpacity(.3), //Text Color
          ),
        ),
      ],
    );
  }

  _secondScreenBuild(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'The price at which you bought and at which\nyou want to sell the item',
          style: CustomTextStyles.bodyLargePrimaryContainer_1,
        ),
        SizedBox(
          height: 20.v,
        ),
        Container(
          decoration: AppDecoration.fillOnPrimaryContainer,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _textField(context,
                  hintText: 'The price you bought',
                  controller: boughtPriceController,
                  node: nameOfItemNode,
                  inputType: TextInputType.number),
              SizedBox(
                height: 16.v,
              ),
              _textField(context,
                  hintText: 'The price you want to sell at',
                  controller: sellPriceController,
                  node: itemCategoryNode,
                  inputType: TextInputType.number),
            ],
          ),
        ),
        SizedBox(
          height: 20.v,
        ),
        CustomElevatedButton(
          isDisabled: !isSecondFieldsFill || !isOptionChoose,
          text: 'Continue',
          onPressed: () async {
            ItemModel newItemModel = ItemModel(
              nameOfItem: nameOfItemController.text,
              itemCategory: itemCategoryController.text,
              uselessReason: uselessReasonController.text,
              itemState: itemStateParser(chooseOption),
              broughtPrice: getValueWithoutDollarSign(boughtPriceController),
              sellPrice: getValueWithoutDollarSign(sellPriceController),
            );

            if (widget.itemModel != null) {
              await DataManager.updateItemInList(
                  newItemModel, widget.itemModel!);
            } else {
              await DataManager.addItemToList(newItemModel);
            }
            NavigatorService.popAndPushNamed(AppRoutes.mainScreen);
          },
          buttonStyle: ElevatedButton.styleFrom(
            disabledBackgroundColor:
                theme.colorScheme.primary.withOpacity(.3), // Background Color
            disabledForegroundColor: theme.colorScheme.onPrimaryContainer
                .withOpacity(.3), //Text Color
          ),
        ),
      ],
    );
  }

  double getValueWithoutDollarSign(TextEditingController controller) {
    final text = controller.text;
    if (text.isNotEmpty && text.endsWith('\$')) {
      return double.parse(
          text.substring(0, text.length - 1)); // Remove the last character ($)
    } else {
      return double.parse(text);
    }
  }

  Widget _textField(
    BuildContext context, {
    String name = '',
    String text = '',
    String hintText = '',
    TextInputType inputType = TextInputType.text,
    required TextEditingController controller,
    required FocusNode node,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (name.isNotEmpty)
          Text(
            name,
            style: CustomTextStyles.bodyMediumErrorContainer,
          ),
        if (name.isNotEmpty)
          SizedBox(
            height: 8.v,
          ),
        CustomTextFormField(
          focusNode: node,
          hintText: hintText,
          hintStyle: CustomTextStyles.bodyMediumErrorContainer,
          textStyle: CustomTextStyles.titleMediumSemiBold,
          textInputType: inputType,
          controller: controller,
          maxLines: 1,
          onChanged: (value) {
            // if (value == '' || value.length == 1)
            setState(
              () {
                node.requestFocus();
                firstTextFieldFills();
              },
            );
          },
        ),
        if (name.isNotEmpty)
          SizedBox(
            height: 16.v,
          ),
      ],
    );
  }

  Widget _buildChooser(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('What is the condition of the item?',
              style: CustomTextStyles.bodyLargePrimaryContainer_1),
        ),
        SizedBox(
          height: 4.v,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: options
              .map(
                (option) => Container(
                  // margin: EdgeInsets.symmetric(horizontal: 4.v),
                  height: 52.v,
                  width: 110.h,
                  decoration: customBoxDecoration(option['isActive']),
                  child: InkWell(
                    onTap: () {
                      changeState(option);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${option['title']}',
                              textAlign: TextAlign.right,
                              style: option['isActive']
                                  ? CustomTextStyles.titleMediumPrimary
                                  : CustomTextStyles.titleMediumSemiBold,
                            ),
                            CustomImageView(
                              imagePath: option['imagePath'],
                            )
                          ],
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
          chooseOption = item['title'];
        } else {
          item['isActive'] = false;
        }
      }
    });
  }

  static ItemState itemStateParser(String title) {
    switch (title.toLowerCase()) {
      case 'good':
        return ItemState.Good;
      case 'not bad':
        return ItemState.NotBad;
      case 'not good':
        return ItemState.NotGood;
      case 'bad':
        return ItemState.Bad;
      default:
        throw ArgumentError('Invalid payment type: $title');
    }
  }

  customBoxDecoration(isActive) {
    return BoxDecoration(
      color: isActive ? appTheme.gray300 : appTheme.gray300,
      border: isActive
          ? Border.all(color: theme.colorScheme.primary)
          : Border.all(color: appTheme.gray200),
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
    );
  }
}

class CustomTextEditingController extends TextEditingController {
  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      bool withComposing = false}) {
    final customText =
        '$text${text.isNotEmpty ? '\$' : ''}'; // Add $ sign at the end
    return TextSpan(text: customText, style: style);
  }
}
