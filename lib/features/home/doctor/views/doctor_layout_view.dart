// import 'package:checkin/features/home/doctor/view_model/cubit/doctor_cubit.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../../core/utils/constants/assets_manager.dart';

// // class DoctorLayoutView extends StatelessWidget {
// //   const DoctorLayoutView({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocProvider(create: (context) => DoctorCubit(Dio()), child: 
    
// //     BlocConsumer(
// //       listener: (context, state) {
        
// //       },
// //       builder: (context,state){
// //         var cubit=BlocProvider.of<DoctorCubit>(context);
// //       return Scaffold(
       
// //         body: cubit.pages[cubit.currentNavBarIndex],



// //       );
// //     },)
// //     );
// //   }
// // }
import 'package:checkin/shared/server_locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/constants/assets_manager.dart';
import '../view_model/cubit/doctor_cubit.dart';
import '../view_model/cubit/doctor_state.dart';

// class DoctorLayoutView extends StatelessWidget {
//   const DoctorLayoutView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DoctorCubit(Dio()),
//       child: Scaffold(
//         body: BlocBuilder<DoctorCubit, DoctorState>(
//           builder: (context, state) {
//             final cubit = BlocProvider.of<DoctorCubit>(context);
//             return cubit.pages[cubit.currentNavBarIndex];
//           },
//         ),
//         bottomNavigationBar: BlocBuilder<DoctorCubit, DoctorState>(
//           builder: (context, state) {
//             final cubit = BlocProvider.of<DoctorCubit>(context);

//             return  BottomNavigationBar(
//   items: const [
//     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//   ],
// );
//           },
//         ),
//       ),
//     );
//   }
// }
class DoctorLayoutView extends StatelessWidget {
  const DoctorLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    
      create: (context) => DoctorCubit(sl()), // استخدم Dio من الـ provider
      child: Scaffold(
        body: BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, state) {
            final cubit = context.read<DoctorCubit>();
            return cubit.pages[cubit.currentNavBarIndex];
          },
        ),
        bottomNavigationBar: _buildBottomNavBar(context),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        final cubit = context.read<DoctorCubit>();
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: cubit.currentNavBarIndex,
          onTap: cubit.changeNavBar,
items: [
  BottomNavigationBarItem(
    icon: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: cubit.currentNavBarIndex == 0 
            ? Color(0xffECF9F1) 
            : Colors.transparent,
      ),
      padding: EdgeInsets.all(8.0),
      child: Icon(Icons.home),
    ),
    label: "الرئيسية",
  ),
  BottomNavigationBarItem(
    icon: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: cubit.currentNavBarIndex == 1
            ? Color(0xffECF9F1)
            : Colors.transparent,
      ),
      padding: EdgeInsets.all(8.0),
      child: Icon(Icons.monetization_on), // أيقونة الأسعار
    ),
    label: "الأسعار",
  ),
  BottomNavigationBarItem(
    icon: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: cubit.currentNavBarIndex == 2
            ? Color(0xffECF9F1)
            : Colors.transparent,
      ),
      padding: EdgeInsets.all(8.0),
      child: Icon(Icons.person),
    ),
    label: "البروفايل",
  ),
],
        );
      },
    );
  }
}