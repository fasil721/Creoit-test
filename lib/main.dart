import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:netflix_clone/screens/mobile_signup_view/bloc/mobile_signup_bloc.dart';
import 'package:netflix_clone/screens/root_page/root_page.dart';
import 'package:netflix_clone/screens/verify_otp_view/bloc/verify_otp_bloc.dart';
import 'package:netflix_clone/theme/theme.dart';
import 'package:netflix_clone/utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<VerifyOtpBloc>(
            create: (context) => VerifyOtpBloc(),
            lazy: false,
          ),
          BlocProvider<MobileSignupBloc>(
            create: (context) =>
                MobileSignupBloc(BlocProvider.of<VerifyOtpBloc>(context)),
            lazy: false,
          ),
        ],
        child: GetMaterialApp(
          theme: themeData,
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: Utils.snackbarKey,
          // home: StreamBuilder(
          //   stream: FirebaseAuth.instance.authStateChanges(),
          //   builder: (context, snapshot) =>
          //       snapshot.hasData ? const RootPage() : const MobileSignUpView(),
          // ),
          home: const RootPage(),
        ),
      );
}
