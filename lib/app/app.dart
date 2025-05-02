// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:flutter_localizations/flutter_localizations.dart';

// import '../core/utils/constants/app_router.dart';
// import '../core/utils/constants/font_manager.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: ScreenUtilInit(
//         designSize: const Size(360, 690),
//         minTextAdapt: true,
//         splitScreenMode: true,
//         child: MaterialApp(
//           theme: ThemeData(
//             scaffoldBackgroundColor: Colors.white,
//             fontFamily:FontConstants.fontFamily,
//             textTheme: TextTheme(
//               bodyMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//             ),
//           ),
//           debugShowCheckedModeBanner: false,
//           onGenerateRoute: RouteGenerator.getRoute,
//           initialRoute: Routes.splashRoute,
//           locale: const Locale('ar'), // Force Arabic locale
//           supportedLocales: const [
//             Locale('ar'), // Arabic only
//           ],
//           localizationsDelegates: [
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//             GlobalCupertinoLocalizations.delegate,
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:checkin/features/home/view_model/cubit/home_cubit.dart';
import 'package:checkin/features/layout/view_model/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/utils/constants/app_router.dart';
import '../core/utils/constants/font_manager.dart';
import '../features/auth/view_model/auth_cubit/auth_cubit.dart';
import '../shared/server_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
            BlocProvider<HomeCubit>(create: (context) =>sl<HomeCubit>()),
            BlocProvider<LayoutCubit>(
              // create: (context) => LayoutCubit(AuthCubit()),
              create: (context) => LayoutCubit(context.read<AuthCubit>()),
            ),
            
            // ممكن تضيف Blocs تانية هنا في المستقبل
          ],
          child: MaterialApp(
            theme: ThemeData(
           //   useMaterial3: false,
              scaffoldBackgroundColor: Colors.white,
              fontFamily: FontConstants.fontFamily,
              textTheme: const TextTheme(
                bodyMedium: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashRoute,
            locale: const Locale('ar'), // اللغة الافتراضية عربية
            supportedLocales: const [Locale('ar')],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          ),
        ),
      ),
    );
  }
}
