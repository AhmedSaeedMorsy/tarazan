import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sodany/app/common/widget.dart';
import 'package:sodany/app/constant/enums_extentions.dart';
import 'package:sodany/presentation/profile/controller/bloc.dart';
import 'package:sodany/presentation/profile/controller/states.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/services/shared_prefrences/cache_helper.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc()..editProfile({}),
        child: BlocBuilder<ProfileBloc, ProfileStates>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: ColorManager.darkBlue,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: ColorManager.darkBlue,
                  statusBarIconBrightness: Brightness.light,
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorManager.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                centerTitle: true,
                title: Text(
                  AppStrings.profile.tr(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                elevation: AppSize.s0,
               
              ),
              body: state is EditProfileLoadingState
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width / AppSize.s50,
                        vertical:
                            MediaQuery.of(context).size.height / AppSize.s80,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  CircleAvatar(
                                    radius: AppSize.s60.w,
                                    backgroundImage: ProfileBloc.get(context)
                                        .profileCoverImage(),
                                    backgroundColor: ColorManager.darkBlue,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      ProfileBloc.get(context)
                                          .getProfileImage()
                                          .then((value) {
                                        ProfileBloc.get(context)
                                            .editProfileImage(
                                                profileNewImage:
                                                    ProfileBloc.get(context)
                                                        .profileImage!);
                                      });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: ColorManager.white,
                                      radius: AppSize.s20.w,
                                      child: const Icon(
                                        Icons.edit_outlined,
                                        color: ColorManager.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s20,
                              ),
                              profileItem(
                                context: context,
                                label: ProfileBloc.get(context)
                                    .editProfileModel
                                    .data
                                    .name
                                    .toString()
                                    .toCapitalized(),
                                onPressed: () {
                                  ProfileBloc.get(context).showNameField();
                                },
                              ),
                              ProfileBloc.get(context).isShowName
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                AppSize.s30,
                                      ),
                                      child: SharedWidget.defaultTextFormField(
                                        context: context,
                                        controller: nameController,
                                        textInputType: TextInputType.text,
                                        hint: AppStrings.name.tr(),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            ProfileBloc.get(context)
                                                .editProfile({
                                              "name": nameController.text,
                                            });
                                          },
                                          icon: Text(
                                            AppStrings.edit.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              profileItem(
                                context: context,
                                label: ProfileBloc.get(context)
                                    .editProfileModel
                                    .data
                                    .email
                                    .toString(),
                                onPressed: () {
                                  ProfileBloc.get(context).showEmailField();
                                },
                              ),
                              ProfileBloc.get(context).isShowEmail
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                AppSize.s30,
                                      ),
                                      child: SharedWidget.defaultTextFormField(
                                        context: context,
                                        controller: emailController,
                                        textInputType: TextInputType.text,
                                        hint: AppStrings.email.tr(),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            ProfileBloc.get(context)
                                                .editProfile({
                                              "email": emailController.text
                                            });
                                          },
                                          icon: Text(
                                            AppStrings.edit.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              profileItem(
                                context: context,
                                label: ProfileBloc.get(context)
                                    .editProfileModel
                                    .data
                                    .phone
                                    .toString(),
                                onPressed: () {
                                  ProfileBloc.get(context).showPhoneField();
                                },
                              ),
                              ProfileBloc.get(context).isShowPhone
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width /
                                                AppSize.s30,
                                      ),
                                      child: SharedWidget.defaultTextFormField(
                                        context: context,
                                        textInputType: TextInputType.text,
                                        hint: AppStrings.phoneNumber.tr(),
                                        controller: phoneController,
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            ProfileBloc.get(context)
                                                .editProfile(
                                              {"phone": phoneController.text},
                                            );
                                          },
                                          icon: Text(
                                            AppStrings.edit.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s20,
                              ),
                              SharedWidget.defaultButton(
                                context: context,
                                function: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.paymentMethodRoute,
                                  );
                                },
                                text: AppStrings.paymentMethod.tr(),
                                backgroundColor: ColorManager.darkBlue,
                                style:
                                    Theme.of(context).textTheme.headlineSmall!,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height /
                                    AppSize.s50,
                              ),
                              SharedWidget.defaultButton(
                                context: context,
                                function: () {
                                  CacheHelper.removeData(key: SharedKey.token);
                                  CacheHelper.removeData(key: SharedKey.id);
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.loginRoute,
                                  );
                                },
                                text: AppStrings.logOut.tr(),
                                backgroundColor: ColorManager.darkBlue,
                                style:
                                    Theme.of(context).textTheme.headlineSmall!,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            );
          },
        ));
  }

  Widget profileItem({
    required BuildContext context,
    required String label,
    required Function() onPressed,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / AppSize.s30,
          vertical: MediaQuery.of(context).size.height / AppSize.s40,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                InkWell(
                  onTap: onPressed,
                  child: const Icon(
                    Icons.edit_outlined,
                    color: ColorManager.primaryColor,
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / AppSize.s80,
            ),
            Container(
              color: ColorManager.darkBlue,
              width: double.infinity,
              height: AppSize.s1,
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / AppSize.s20,
            // ),
          ],
        ),
      );
}
