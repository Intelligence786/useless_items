import 'package:flutter/material.dart';
import 'package:useless_items/core/app_export.dart';
import 'package:useless_items/data/models/item_model/item_model.dart';

import '../../data/data_manager.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';

class ItemInfoScreen extends StatelessWidget {
  final ItemModel itemModel;

  const ItemInfoScreen({super.key, required this.itemModel});

  static Widget builder(BuildContext context, ItemModel itemModel) {
    return ItemInfoScreen(
      itemModel: itemModel,
    );
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
                Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
                SizedBox(width: 4.h),
                Text(
                  'Back',
                  style: CustomTextStyles.bodyMediumPrimary,
                ),
              ],
            ),
            onPressed: () {
              NavigatorService.goBack();
            },
          ),
        ),
        actions: [
          Container(
            width: 85.h,
            child: TextButton(
              child: Text(
                'Edit',
                style: CustomTextStyles.bodyMediumPrimary,
              ),
              onPressed: () {
                NavigatorService.popAndPushNamed(AppRoutes.itemAddScreen,
                    arguments: itemModel);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 25.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(12.h),
                decoration: AppDecoration.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    itemStateToCondition(itemModel.itemState),
                    SizedBox(height: 12.v),
                    Text(
                      itemModel.nameOfItem,
                      style: theme.textTheme.headlineLarge,
                    ),
                    SizedBox(height: 12.v),
                    Text(
                      itemModel.itemCategory,
                      style: CustomTextStyles.bodyMediumErrorContainer,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.v),
              Text(
                'The reason why the item is useless',
                style: CustomTextStyles.bodyLargePrimaryContainer_1,
              ),
              SizedBox(height: 12.v),
              Container(
                height: 130.v,
                padding: EdgeInsets.all(12.h),
                decoration: AppDecoration.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      itemModel.itemCategory,
                      style: CustomTextStyles.titleMediumSemiBold,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.v),
              Text(
                'Price information',
                style: CustomTextStyles.bodyLargePrimaryContainer_1,
              ),
              SizedBox(height: 12.v),
              Container(
                padding: EdgeInsets.all(16.h),
                decoration: AppDecoration.surface,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      itemModel.itemCategory,
                      style: CustomTextStyles.titleMediumSemiBold,
                    ),
                    Text(
                      itemModel.broughtPrice.toStringAsFixed(0) + '\$',
                      style: CustomTextStyles.titleMediumPrimary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.v),
              Container(
                padding: EdgeInsets.all(16.h),
                decoration: AppDecoration.outlineGray,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      itemModel.itemCategory,
                      style: CustomTextStyles.titleMediumSemiBold,
                    ),
                    Text(
                      itemModel.sellPrice.toStringAsFixed(0) + '\$',
                      style: CustomTextStyles.titleMediumPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.h),
        child: CustomElevatedButton(
          text: 'Delete transport',
          onPressed: () async {
            await DataManager.removeItemFromList(itemModel);
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.mainScreen);
          },
          buttonTextStyle: CustomTextStyles.titleMediumSemiBold,
          buttonStyle: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(side: BorderSide(color: theme.colorScheme.primary), borderRadius: BorderRadiusStyle.roundedBorder8),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.black,
            disabledBackgroundColor: theme.colorScheme.primary.withOpacity(.3),
            // Background Color
            disabledForegroundColor: theme.colorScheme.onPrimaryContainer
                .withOpacity(.3), //Text Color
          ),
        ),
      ),
    );
  }

  Widget itemStateToCondition(ItemState itemState) {
    switch (itemState) {
      case ItemState.Good:
        return Row(
          children: [
            Text(
              'Good condition',
              style:
                  theme.textTheme.titleMedium?.copyWith(color: appTheme.green),
            ),
            SizedBox(
              width: 5.h,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgFrame41192,
            ),
          ],
        );
      case ItemState.NotBad:
        return Row(
          children: [
            Text(
              'Not bad condition',
              style:
                  theme.textTheme.titleMedium?.copyWith(color: appTheme.yellow),
            ),
            SizedBox(
              width: 5.h,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgFrame41191,
            ),
          ],
        );
      case ItemState.NotGood:
        return Row(
          children: [
            Text(
              'Not good condition',
              style:
                  theme.textTheme.titleMedium?.copyWith(color: appTheme.orange),
            ),
            SizedBox(
              width: 5.h,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgFrame41193,
            ),
          ],
        );
      case ItemState.Bad:
        return Row(
          children: [
            Text(
              'Bad condition',
              style: theme.textTheme.titleMedium?.copyWith(color: appTheme.red),
            ),
            SizedBox(
              width: 5.h,
            ),
            CustomImageView(
              imagePath: ImageConstant.imgFrame41193Red800,
            ),
          ],
        );
    }
  }
}
