// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../core/utils/constants/app_router.dart';
// import '../../../core/utils/constants/app_strings.dart';
// import '../../../core/utils/constants/color_manager.dart';
// import '../../../shared/shared_preference_helper.dart';
// import '../../../core/utils/constants/app_constant.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   String _userRole = '5'; // Default as normal user
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _getUserRole();
//   }

//   Future<void> _getUserRole() async {
//     final roleId = await CacheNetwork.getStringFromCache(key: AppConstants.roleIdKey) ?? '5';
//     setState(() {
//       _userRole = roleId;
//       _isLoading = false;
//     });
//     print('👤 Current user role: $_userRole');
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }

//     return Scaffold(
//       body: _getScreenForIndex(_currentIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) => _onTabTapped(index),
//         selectedItemColor: ColorManager.primary,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'الرئيسية',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.medical_services),
//             label: 'الطبيب',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.agriculture),
//             label: 'المزارع',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'الحساب',
//           ),
//         ],
//       ),
//     );
//   }

//   void _onTabTapped(int index) {
//     // إذا كان المستخدم يحاول الوصول إلى صفحة المزارع وهو ليس مزارع
//     if (index == 2 && _userRole != '6') {
//       _showRestrictedAccessDialog('لا يمكنك الوصول إلى هذه الصفحة، هذه الميزة متاحة فقط للمزارعين.');
//       return;
//     }

//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   void _showRestrictedAccessDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('غير مصرح'),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('حسناً'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _getScreenForIndex(int index) {
//     switch (index) {
//       case 0:
//         return const UserHomeContent(); // صفحة الرئيسية للمستخدم العادي
//       case 1:
//         return const DoctorFeatureContent(); // صفحة ميزات الطبيب
//       case 2:
//         // لا يجب أن نصل إلى هنا إلا إذا كان المستخدم مزارع، لأننا نتحقق في _onTabTapped
//         return const FarmerFeatureContent(); // صفحة ميزات المزارع
//       case 3:
//         return const ProfileScreen(); // صفحة الملف الشخصي
//       default:
//         return const UserHomeContent();
//     }
//   }
// }

// class UserHomeContent extends StatelessWidget {
//   const UserHomeContent({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.home, size: 100, color: ColorManager.primary),
//           const SizedBox(height: 20),
//           Text(
//             'الصفحة الرئيسية',
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'مرحباً بك في تطبيقنا',
//             style: Theme.of(context).textTheme.bodyLarge,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DoctorFeatureContent extends StatelessWidget {
//   const DoctorFeatureContent({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//            Icon(Icons.medical_services, size: 100, color: ColorManager.primary),
//           const SizedBox(height: 20),
//           Text(
//             'خدمات الطبيب',
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'يمكنك الوصول إلى جميع خدمات الطبيب هنا',
//             style: Theme.of(context).textTheme.bodyLarge,
//           ),
//           const SizedBox(height: 30),
//           ElevatedButton(
//             onPressed: () {
//               // أي إجراء تريد تنفيذه
//             },
//             child: const Text('عرض المزارع'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FarmerFeatureContent extends StatelessWidget {
//   const FarmerFeatureContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//            Icon(Icons.agriculture, size: 100, color: ColorManager.primary),
//           const SizedBox(height: 20),
//           Text(
//             'خدمات المزارع',
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'يمكنك الوصول إلى جميع خدمات المزارع هنا',
//             style: Theme.of(context).textTheme.bodyLarge,
//           ),
//           const SizedBox(height: 30),
//           ElevatedButton(
//             onPressed: () {
//               // أي إجراء تريد تنفيذه
//             },
//             child: const Text('إدارة المزرعة'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import '../../../core/utils/constants/assets_manager.dart';
// import '../../../core/utils/constants/color_manager.dart';
// import '../../profile/views/profile_view.dart';
// import '../view_model/cubit/home_cubit.dart';
// import '../view_model/cubit/home_state.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeCubit()..getUserRole(),
//       child: BlocConsumer<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is HomeErrorState) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text(state.error)));
//           }
//         },
//         builder: (context, state) {
//           final homeCubit = context.read<HomeCubit>();

//           if (state is HomeLoadingState) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }

//           return Scaffold(
//             body: _getScreenForIndex(homeCubit.currentIndex),
//             bottomNavigationBar: BottomNavigationBar(
//               currentIndex: homeCubit.currentIndex,
//               onTap: (index) => _onTabTapped(context, index),
//               selectedItemColor: ColorManager.primary,
//               unselectedItemColor: Colors.grey,
//               type: BottomNavigationBarType.fixed,
//               items: [
//                 BottomNavigationBarItem(
//                   backgroundColor: Colors.white,
//                   icon: Icon(Icons.home),
//                   label: 'الرئيسية',
//                 ),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.medical_services),

//                   label: 'الطبيب',
//                 ),
//                 BottomNavigationBarItem(
//                icon: Icon(Icons.agriculture),

//                   label: 'المزارع',
//                 ),

//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.person),
//                   label: 'الحساب',
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _onTabTapped(BuildContext context, int index) {
//     final homeCubit = context.read<HomeCubit>();

//     // إذا كان المستخدم يحاول الوصول إلى صفحة المزارع وهو ليس مزارع
//     if (index == 2 && homeCubit.userRole != '6') {
//       _showRestrictedAccessDialog(
//         context,
//         'لا يمكنك الوصول إلى هذه الصفحة، هذه الميزة متاحة فقط للمزارعين.',
//       );
//       return;
//     }

//     homeCubit.changeTab(index);
//   }

//   void _showRestrictedAccessDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('غير مصرح'),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('حسناً'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _getScreenForIndex(int index) {
//     switch (index) {
//       case 0:
//         return const UserHomeContent();
//       case 1:
//         return const DoctorFeatureContent();
//       case 2:
//         return const FarmerFeatureContent();
//       case 3:
//         return const ProfileScreen();
//       default:
//         return const UserHomeContent();
//     }
//   }
// }

// class UserHomeContent extends StatelessWidget {
//   const UserHomeContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.home, size: 100, color: ColorManager.primary),
//           const SizedBox(height: 20),
//           Text(
//             'الصفحة الرئيسية',
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'مرحباً بك في تطبيقنا',
//             style: Theme.of(context).textTheme.bodyLarge,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DoctorFeatureContent extends StatelessWidget {
//   const DoctorFeatureContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.medical_services, size: 100, color: ColorManager.primary),
//           const SizedBox(height: 20),
//           Text(
//             'خدمات الطبيب',
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'يمكنك الوصول إلى جميع خدمات الطبيب هنا',
//             style: Theme.of(context).textTheme.bodyLarge,
//           ),
//           const SizedBox(height: 30),
//           ElevatedButton(
//             onPressed: () {
//               // أي إجراء تريد تنفيذه
//             },
//             child: const Text('عرض المزارع'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FarmerFeatureContent extends StatelessWidget {
//   const FarmerFeatureContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.agriculture, size: 100, color: ColorManager.primary),
//           const SizedBox(height: 20),
//           Text(
//             'خدمات المزارع',
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//           const SizedBox(height: 20),
//           Text(
//             'يمكنك الوصول إلى جميع خدمات المزارع هنا',
//             style: Theme.of(context).textTheme.bodyLarge,
//           ),
//           const SizedBox(height: 30),
//           ElevatedButton(
//             onPressed: () {
//               // أي إجراء تريد تنفيذه
//             },
//             child: const Text('إدارة المزرعة'),
//           ),
//         ],
//       ),
//     );
//   }
// // }
import 'package:checkin/features/home/farm/repo/farm_setup_repo.dart';
import 'package:checkin/features/home/farm/services/farm_setup_services.dart';
import 'package:checkin/features/home/user/views/user_home_view.dart';
import 'package:checkin/features/home/views/farmer_home_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



import '../../profile/views/profile_view.dart';
import '../doctor/views/doctor_home_view.dart';
import '../view_model/cubit/home_cubit.dart';
import '../view_model/cubit/home_state.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeCubit()..getUserRole(),
//       child: BlocConsumer<HomeCubit, HomeState>(
//         listener: (context, state) {
//           if (state is HomeErrorState) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.error)),
//             );
//           }
//         },
//         builder: (context, state) {
//           final homeCubit = context.read<HomeCubit>();

//           if (state is HomeLoadingState) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }

//           // هنا هتكتب كل الشاشات اللي عندك بالترتيب اللي انت عايزه
//           final List<Widget> screens = [
//             const FarmerHomeView(),     // index 0
//             const UserHomeView(),          // index 1
//             const DoctorHomeView(),     // index 2
//             const PriceView(),             // index 3
//             const ProfileScreen(),            // index 4
//           ];

//           // هنا كل العناصر بتاعة البوتوم ناف بار
//           final List<_NavItem> navItems = [
//             _NavItem(svgPath: ImageAssets.farmerNav),
//             _NavItem(icon: Icons.home),
//             _NavItem(svgPath: ImageAssets.doctorNav),
//             _NavItem(svgPath: ImageAssets.priceNav),
//             _NavItem(icon: Icons.person),
//           ];

//           return Scaffold(
//             body: screens[homeCubit.currentIndex],
//             bottomNavigationBar: BottomNavigationBar(
//               currentIndex: homeCubit.currentIndex,
//               onTap: (index) => _onTabTapped(context, index),
//               type: BottomNavigationBarType.fixed,
//               selectedItemColor: ColorManager.primary,
//               unselectedItemColor: Colors.grey,
//               showSelectedLabels: false,
//               showUnselectedLabels: false,
//               items: List.generate(navItems.length, (index) {
//                 final item = navItems[index];
//                 final isSelected = homeCubit.currentIndex == index;
//                 return BottomNavigationBarItem(
//                   icon: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: isSelected ? const Color(0xffECF9F1) : Colors.transparent,
//                     ),
//                     child: item.svgPath != null
//                         ? SvgPicture.asset(item.svgPath!)
//                         : Icon(item.icon),
//                   ),
//                   label: "",
//                 );
//               }),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _onTabTapped(BuildContext context, int index) {
//     final homeCubit = context.read<HomeCubit>();

//     // لو المستخدم مش مزارع وعايز يدخل على شاشة المزارع
//     if (index == 0 && homeCubit.userRole != '6') {
//       _showRestrictedAccessDialog(
//         context,
//         'لا يمكنك الوصول إلى هذه الصفحة، هذه الميزة متاحة فقط للمزارعين.',
//       );
//       return;
//     }

//     homeCubit.changeTab(index);
//   }

//   void _showRestrictedAccessDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('غير مصرح'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             child: const Text('حسناً'),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _NavItem {
//   final IconData? icon;
//   final String? svgPath;

//   _NavItem({this.icon, this.svgPath});
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {
//         if (state is HomeErrorState) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text(state.error)));
//         }
//       },
//       builder: (context, state) {
//         final homeCubit = context.read<HomeCubit>();
    
//         if (state is HomeLoadingState) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//          if (!homeCubit.roleLoaded || state is HomeLoadingState) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//         return Scaffold(
//           body: _getScreenForIndex(homeCubit.currentIndex),
//           bottomNavigationBar: BottomNavigationBar(
//             backgroundColor: Colors.white,
//             currentIndex: homeCubit.currentIndex,
//             onTap: (index) => _onTabTapped(context, index),
//             selectedItemColor: ColorManager.primary,
//             unselectedItemColor: Colors.grey,
//             type: BottomNavigationBarType.fixed,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'الرئيسية',
//               ),
//               BottomNavigationBarItem(
//                 // icon: Icon(Icons.medical_services),
//                 icon:Icon(FontAwesomeIcons.userDoctor),
//                 label: 'الطبيب',
//               ),
//               BottomNavigationBarItem(
//                 // icon: Icon(Icons.agriculture),
//                 icon: Icon(FontAwesomeIcons.personDigging),
//                 label: 'المزارع',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'الحساب',
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _onTabTapped(BuildContext context, int index) {
//     final homeCubit = context.read<HomeCubit>();

//     // إذا المستخدم حاول يفتح المزارع وهو مش مزارع
//     if (index == 2 && homeCubit.userRole != '6') {
//       _showRestrictedAccessDialog(
//         context,
//         'لا يمكنك الوصول إلى هذه الصفحة، هذه الميزة متاحة فقط للمزارعين.',
//       );
//       return;
//     }

//     homeCubit.changeTab(index);
//   }

//   void _showRestrictedAccessDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('غير مصرح'),
//             content: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text('حسناً'),
//               ),
//             ],
//           ),
//     );
//   }

//   Widget _getScreenForIndex(int index) {
//     switch (index) {
//       case 0:
//         return const UserHomeView();
//       case 1:
//         return const DoctorHomeView();
//       case 2:
//         return const FarmerHomeView();
//       case 3:
//         return const ProfileScreen();
//       default
// :
//         return const UserHomeView();
//     }
//   }
// // }
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//     context.read<HomeCubit>().reloadUserRole();
//   });
//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {
//         if (state is HomeErrorState) {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text(state.error)));
//         }
//       },
//       builder: (context, state) {
//         final homeCubit = context.read<HomeCubit>();

//         // لا تبني أي شيء قبل تحميل الدور
//         if (!homeCubit.roleLoaded || state is HomeLoadingState) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         // الشاشات حسب الدور
//         final roleId = homeCubit.userRole;
//         List<Widget> roleScreens;

//         if (roleId == '6') {
//           // مزارع
//           roleScreens = [
//             const FarmerHomeView(),
//             const DoctorHomeView(),
//             const FarmerHomeView(),
//             const ProfileScreen(),
//           ];
//         } else if (roleId == '7') {
//           // طبيب
//           roleScreens = [
//             const DoctorHomeView(),
//             const DoctorHomeView(),
//             const FarmerHomeView(),
//             const ProfileScreen(),
//           ];
//         } else {
//           // مستخدم عادي
//           roleScreens = [
//             const UserHomeView(),
//             const DoctorHomeView(),
//             const FarmerHomeView(),
//             const ProfileScreen(),
//           ];
//         }

//         return Scaffold(
//           body: roleScreens[homeCubit.currentIndex],
//           bottomNavigationBar: BottomNavigationBar(
//             backgroundColor: Colors.white,
//             currentIndex: homeCubit.currentIndex,
//             onTap: (index) => _onTabTapped(context, index),
//             selectedItemColor: ColorManager.primary,
//             unselectedItemColor: Colors.grey,
//             type: BottomNavigationBarType.fixed,
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'الرئيسية',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(FontAwesomeIcons.userDoctor),
//                 label: 'الطبيب',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(FontAwesomeIcons.personDigging),
//                 label: 'المزارع',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'الحساب',
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _onTabTapped(BuildContext context, int index) {
//     final homeCubit = context.read<HomeCubit>();

//     // إذا المستخدم مش مزارع
//     if (index == 2 && homeCubit.userRole != '6') {
//       _showRestrictedAccessDialog(
//         context,
//         'لا يمكنك الوصول إلى هذه الصفحة، هذه الميزة متاحة فقط للمزارعين.',
//       );
//       return;
//     }

//     homeCubit.changeTab(index);
//   }

//   void _showRestrictedAccessDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('غير مصرح'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('حسناً'),
//           ),
//         ],
//       ),
//     );
//   }
// // }
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         final homeCubit = context.read<HomeCubit>();

//         if (!homeCubit.roleLoaded || state is HomeLoadingState) {
//           // هنا هيستنى فعلاً تحميل الدور
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         final roleId = homeCubit.userRole;

//         print("🔁 UI بناء ب roleId = $roleId");

//         List<Widget> roleScreens;

//         if (roleId == '6') {
//           roleScreens = [
//             const FarmerHomeView(),
//             const DoctorHomeView(),
//             const FarmerHomeView(),
//             const ProfileScreen(),
//           ];
//         } else if (roleId == '7') {
//           roleScreens = [
//             const DoctorHomeView(),
//             const DoctorHomeView(),
//             const FarmerHomeView(),
//             const ProfileScreen(),
//           ];
//         } else {
//           roleScreens = [
//             const UserHomeView(),
//             const DoctorHomeView(),
//             const FarmerHomeView(),
//             const ProfileScreen(),
//           ];
//         }

//         return Scaffold(
//           body: roleScreens[homeCubit.currentIndex],
//           bottomNavigationBar: BottomNavigationBar(
//             currentIndex: homeCubit.currentIndex,
//             onTap: (index) => _onTabTapped(context, index),
//             selectedItemColor: Colors.green,
//             unselectedItemColor: Colors.grey,
//             items: const [
//               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
//               BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'الطبيب'),
//               BottomNavigationBarItem(icon: Icon(Icons.agriculture), label: 'المزارع'),
//               BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الحساب'),
//             ],
//           ),
//         );
//       },
//     );
//   }
  
//   void _onTabTapped(BuildContext context, int index) {
//     final homeCubit = context.read<HomeCubit>();

//     // إذا المستخدم مش مزارع
//     if (index == 2 && homeCubit.userRole != '6') {
//       _showRestrictedAccessDialog(
//         context,
//         'لا يمكنك الوصول إلى هذه الصفحة، هذه الميزة متاحة فقط للمزارعين.',
//       );
//       return;
//     }

//     homeCubit.changeTab(index);
//   }

//   void _showRestrictedAccessDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('غير مصرح'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('حسناً'),
//           ),
//         ],
//       ),
//     );
//   }
// }
 // وتأكد من مسار حالة الـ HomeCubit
// ... باقي الـ imports بتاعتك

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // استدعاء إعادة تحميل الدور عند بدء الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().ensureRoleLoaded();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final homeCubit = context.read<HomeCubit>();
        print('🏠 Building HomeScreen with roleId: ${homeCubit.userRole}, roleLoaded: ${homeCubit.roleLoaded}');
        if (!homeCubit.roleLoaded || state is HomeLoadingState) {
          // هنا هيستنى فعلاً تحميل الدور
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final roleId = homeCubit.userRole;

        print("🔁 UI بناء ب roleId = $roleId");

        List<Widget> roleScreens;

        if (roleId == '6') {
          roleScreens = [
            const FarmerHomeView(),
            const DoctorHomeView(),
            const FarmerHomeView(),
            const ProfileScreen(),
          ];
        } else if (roleId == '7') {
          roleScreens = [
            const DoctorHomeView(),
            const DoctorHomeView(),
            const FarmerHomeView(),
            const ProfileScreen(),
          ];
        } else {
          roleScreens = [
            const UserHomeView(),
            const DoctorHomeView(),
            const FarmerHomeView(),
            const ProfileScreen(),
          ];
        }

        return Scaffold(
          body: roleScreens[homeCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: homeCubit.currentIndex,
            onTap: (index) => _onTabTapped(context, index),
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
              BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'الطبيب'),
              BottomNavigationBarItem(icon: Icon(Icons.agriculture), label: 'المزارع'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الحساب'),
            ],
          ),
        );
      },
    );
  }

  void _onTabTapped(BuildContext context, int index) {
    final homeCubit = context.read<HomeCubit>();

    // إذا المستخدم مش مزارع
    if (index == 2 && homeCubit.userRole != '6') {
      _showRestrictedAccessDialog(
        context,
        'لا يمكنك الوصول إلى هذه الصفحة، هذه الميزة متاحة فقط للمزارعين.',
      );
      return;
    }

    homeCubit.changeTab(index);
  }

  void _showRestrictedAccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('غير مصرح'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}