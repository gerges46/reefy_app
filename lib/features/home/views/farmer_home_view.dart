import 'package:checkin/core/utils/constants/assets_manager.dart';


import 'package:checkin/features/auth/views/widgets/custom_snackbar.dart';
import 'package:checkin/features/home/farm/repo/farm_setup_repo.dart';
import 'package:checkin/features/home/farm/services/farm_setup_services.dart';

import 'package:checkin/features/home/view_model/cubit/home_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';

import '../view_model/cubit/home_state.dart';

class FarmerHomeView extends StatelessWidget {
  const FarmerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
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
          
          body:Column(
            children: [
              Text('farmer home view')
            ],
          ),
        );
      },
    );
  }
}
