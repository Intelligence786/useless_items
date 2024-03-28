import 'package:flutter/material.dart';
import 'package:useless_items/core/app_export.dart';
import 'package:useless_items/data/models/item_model/item_model.dart';
import 'package:useless_items/presentation/main_screen/main_bloc/main_bloc.dart';
import 'package:useless_items/widgets/app_bar/custom_app_bar.dart';

import '../../widgets/custom_elevated_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (context) => MainBloc()..add(MainGetEvent()),
      child: MainScreen(),
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
            child: Text(
              'Settings',
              style: CustomTextStyles.bodyMediumPrimary,
            ),
            onPressed: () {
              NavigatorService.pushNamed(AppRoutes.settingsScreen);
            },
          ),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state is MainLoadedEmptyState) {
                return _emptyScreenBuild(context);
              } else if (state is MainLoadedFullState) {
                return Expanded(child: _fullScreenBuild(context, state));
              } else {
                return Expanded(
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(12.0),
        child: CustomElevatedButton(
          text: 'Add a new useless item',
          onPressed: () => NavigatorService.pushNamed(AppRoutes.itemAddScreen, arguments: null),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget _emptyScreenBuild(BuildContext context) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50.v,
          ),
          Padding(
            padding: EdgeInsets.all(4.h),
            child: CustomImageView(
              fit: BoxFit.contain,
              imagePath: ImageConstant.imgGroupSecondarycontainer,
            ),
          ),
          SizedBox(
            height: 40.v,
          ),
          Padding(
            padding: EdgeInsets.all(4.h),
            child: Column(
              children: [
                Text(
                  'There\'s no info',
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(
                  height: 8.v,
                ),
                Text(
                  'Add the first useless item',
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyLargePrimaryContainer_1,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _fullScreenBuild(BuildContext context, MainLoadedFullState state) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 12.v),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Your items',
          style: theme.textTheme.headlineLarge,
        ),
        SizedBox(
          height: 12.v,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.itemModelList.length,
                itemBuilder: (context, index) {
                  return _itemWidget(
                    context,
                    state.itemModelList[index],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _itemWidget(BuildContext context, ItemModel itemModel) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.h),
    decoration: AppDecoration.surface.copyWith(
      borderRadius: BorderRadiusStyle.roundedBorder8,
    ),
    child: Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadiusStyle.roundedBorder8,
        onTap: () {
          NavigatorService.pushNamed(AppRoutes.itemInfoScreen,
              arguments: itemModel);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 15.v,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomImageView(
                    imagePath: _itemStateToImage(itemModel.itemState),
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.h),
                    child: Text(
                      itemModel.nameOfItem,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color:
                            theme.colorScheme.primaryContainer.withOpacity(1),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.v),
              Text(
                itemModel.itemCategory,
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.errorContainer.withOpacity(1),
                ),
              ),
              SizedBox(height: 19.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: 0.7,
                        child: Text(
                          'Potential sale price',
                          style: CustomTextStyles.bodyMediumErrorContainer
                              .copyWith(
                            color: theme.colorScheme.errorContainer,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.v),
                      Text(
                        '${itemModel.sellPrice.toString()}\$',
                        style: CustomTextStyles.titleMediumPrimary.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgArrowRight,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    margin: EdgeInsets.only(top: 17.v),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

String _itemStateToImage(ItemState itemState) {
  switch (itemState) {
    case ItemState.Good:
      return ImageConstant.imgFrame41192;
    case ItemState.NotBad:
      return ImageConstant.imgFrame41191;
    case ItemState.NotGood:
      return ImageConstant.imgFrame41193;
    case ItemState.Bad:
      return ImageConstant.imgFrame41193Red800;
  }
}

String _itemStateToString(ItemState itemState) {
  switch (itemState) {
    case ItemState.Good:
      return 'Good';
    case ItemState.NotBad:
      return 'Not bad';
    case ItemState.NotGood:
      return 'Not good';
    case ItemState.Bad:
      return 'Bad';
  }
}
