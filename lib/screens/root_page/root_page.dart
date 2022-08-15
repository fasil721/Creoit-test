import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/screens/root_page/bloc/root_page_bloc.dart';

class RootPage extends StatefulWidget {
  const RootPage({
    super.key,
  });
  @override
  State<RootPage> createState() => _MyAppState();
}

class _MyAppState extends State<RootPage> {
  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => RootPageBloc(),
        child: BlocBuilder<RootPageBloc, RootPageState>(
          builder: (context, state) {
            final bloc = context.read<RootPageBloc>();
            if (state is RootPageInitial) {
              final currentIndex = state.currentIndex;
              return Scaffold(
                body: IndexedStack(
                  index: currentIndex,
                  children: state.screens,
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
                  onTap: (index) => bloc.add(RootPageIndexChangeEvent(index)),
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
            return const SizedBox();
          },
        ),
      );
}
