import 'package:checkin/core/utils/constants/assets_manager.dart';


import 'package:checkin/features/auth/views/widgets/custom_snackbar.dart';

import 'package:checkin/features/home/view_model/cubit/home_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';

import '../view_model/cubit/home_state.dart';

class FarmerHomeView extends StatelessWidget {
  const FarmerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is FarmFailureState){
            CustomSnackBar(message: state.errorMessage,isError: true,);
          }
          else if(state is FarmLoadingState){
            Center(child: CircularProgressIndicator(),);
          }else{
          //  Navigator.pushNamed(context, )
          }
        },
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex:
                  BlocProvider.of<HomeCubit>(
                    context,
                  ).currentIndex, // Track the selected item
              onTap: BlocProvider.of<HomeCubit>(context).changeHomeNavBar,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Colors.red,
                  icon: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      color:
                          BlocProvider.of<HomeCubit>(context).currentIndex == 0
                              ? Color(
                                0xffECF9F1,
                              ) // Highlight color for the selected item
                              : const Color.fromRGBO(
                                0,
                                0,
                                0,
                                0,
                              ), // Transparent for unselected items
                    ),
                    padding: EdgeInsets.all(
                      8.0,
                    ), // Adjust padding to make the circle
                    child: Icon(Icons.home),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          BlocProvider.of<HomeCubit>(context).currentIndex == 1
                              ? Color(0xffECF9F1)
                              : Colors.transparent,
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: SvgPicture.asset(ImageAssets.farmerNav),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          BlocProvider.of<HomeCubit>(context).currentIndex == 2
                              ? Color(0xffECF9F1)
                              : Colors.transparent,
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: SvgPicture.asset(ImageAssets.doctorNav),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          BlocProvider.of<HomeCubit>(context).currentIndex == 3
                              ? Color(0xffECF9F1)
                              : Colors.transparent,
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: SvgPicture.asset(ImageAssets.priceNav),
                  ),
                  label: "",
                ),
              ],
            ),

            body:Column(),
          );
        },
      ),
    );
  }
}
