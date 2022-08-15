import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:netflix_clone/screens/coming_soon/coming_soon.dart';
import 'package:netflix_clone/screens/downloads/downloads.dart';
import 'package:netflix_clone/screens/home/home.dart';
import 'package:netflix_clone/screens/mobile_signup_view/bloc/mobile_signup_bloc.dart';
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

class RootPage extends StatefulWidget {
  const RootPage({
    super.key,
  });
  @override
  State<RootPage> createState() => _MyAppState();
}

class _MyAppState extends State<RootPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomePage(),
      const ComingSoonPage(),
      const Downloads(),
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        selectedItemColor: Colors.white,
        backgroundColor: const Color(0xff121212),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (index) => setState(
          () {
            currentIndex = index;
          },
        ),
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              currentIndex == 0
                  ? const AssetImage("assets/icons/home2.png")
                  : const AssetImage("assets/icons/home1.png"),
              size: 25,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              currentIndex == 1
                  ? const AssetImage("assets/icons/video2.png")
                  : const AssetImage("assets/icons/video1.png"),
              size: 25,
            ),
            label: "Coming soon",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.file_download_outlined,
            ),
            label: "Downloads",
          ),
        ],
      ),
    );
  }
}
