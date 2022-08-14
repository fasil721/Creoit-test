import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/datas/constants.dart';
import 'package:netflix_clone/datas/secrets.dart';
import 'package:netflix_clone/models/movie_models.dart';
import 'package:netflix_clone/screens/home/bloc/home_bloc.dart';
import 'package:netflix_clone/utils/utils.dart';
import 'package:netflix_clone/widget/home_appbar.dart';
import 'package:netflix_clone/widget/item_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scroll = ScrollController();
  double offset = 1;
  double yOffset = 0;
  bool reverse = false;
  final ValueNotifier<double> notifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, value, _) => BlocProvider(
          create: (context) => HomeBloc()..add(LoadMoviesEvent()),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.black,
            appBar: _buildNetflixAppbar(),
            body: NotificationListener(
              onNotification: _onScrollChange,
              child: ListView(
                padding: EdgeInsets.zero,
                controller: scroll,
                physics: const ScrollPhysics(),
                children: [
                  _buildHomeMainPoster(),
                  const SizedBox(height: 10),
                  headings("Popular On Netflix"),
                  _buildHomeListview(type: MovieUrlType.trending),
                  headings("Trending Now"),
                  _buildHomeListview(type: MovieUrlType.discover),
                  headings("Top 10 Rated in India"),
                  _buildstackListView(),
                ],
              ),
            ),
          ),
        ),
      );

  bool _onScrollChange(Object? noti) {
    notifier.value = scroll.position.pixels;
    if (scroll.position.pixels < 100) {
      offset = (100 - scroll.position.pixels) / 100;
      yOffset = -notifier.value * .7;
    }
    return false;
  }

  AppBar _buildNetflixAppbar() => AppBar(
        toolbarOpacity: 0,
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(
          notifier.value < 100 ? (1.00 - offset) * 0.8 : 0.8,
        ),
        bottom: PreferredSize(
          preferredSize:
              notifier.value < 100 ? Size(0, 42 * offset) : Size.zero,
          child: HomeAppBar(
            notifier: notifier,
            offset: offset,
            yOffset: yOffset,
          ),
        ),
      );

  Widget _buildHomeListview({required MovieUrlType type}) =>
      BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeDataLoadingState) {
            return _buildListLoading();
          }
          if (state is HomeDataLoadedState) {
            List<Result> datas;
            if (type == MovieUrlType.trending) {
              datas = state.trendingMovies;
            } else {
              datas = state.discoverMovies;
            }
            return Container(
              margin: const EdgeInsets.all(10),
              height: 160,
              width: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemView(movie: datas[index]),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        Secrets.imageUrl + datas[index].posterPath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 10),
              ),
            );
          }
          return Container();
        },
      );

  Widget _buildHomeMainPoster() => Stack(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeDataLoadingState) {
                return _buildPosterLoader(context);
              }
              if (state is HomeDataLoadedState) {
                final datas = state.trendingMovies;
                return _buildPoster(context, datas);
              }
              return Container();
            },
          ),
          _buildPosterShade(),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 80,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textGenre("Adrenailine Rush"),
                  dotIcon(),
                  textGenre("Inspiring"),
                  dotIcon(),
                  textGenre("Exciting"),
                  dotIcon(),
                  textGenre("Extreme Sports"),
                ],
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
                    ),
                    Text(
                      "My List",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 35,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.play_arrow,
                          size: 25,
                          color: Colors.black,
                        ),
                        Text(
                          "Play",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.white),
                    Text(
                      "Info",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );

  SizedBox _buildPosterLoader(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .65,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 1,
          ),
        ),
      );

  SizedBox _buildPoster(BuildContext context, List<Result> datas) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .65,
        child: Image.network(
          Secrets.imageUrl + datas.last.posterPath!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(),
        ),
      );

  Positioned _buildPosterShade() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .65,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  Widget _buildstackListView() => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 160,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeDataLoadingState) {
              return _buildListLoading();
            }
            if (state is HomeDataLoadedState) {
              final datas = state.upcomingMovies;
              return ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Stack(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    children: [
                      Container(
                        color: Colors.black,
                        width: index == 9 ? 185 : 140,
                        height: 120,
                      ),
                      Positioned(
                        right: -10,
                        bottom: 0,
                        child: SizedBox(
                          height: 160,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              Secrets.imageUrl + datas[index].posterPath!,
                              width: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: index == 0 ? 0 : -6,
                        bottom: -20,
                        child: BorderedText(
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                          child: Text(
                            (index + 1).toString(),
                            style: GoogleFonts.roboto(
                              fontSize: 90,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      if (index != 0)
                        Container(
                          width: 25,
                          height: 160,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                Colors.transparent,
                                Colors.black,
                              ],
                            ),
                          ),
                        )
                      else
                        Container()
                    ],
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      );
  Widget _buildListLoading() => Container(
        margin: const EdgeInsets.all(10),
        height: 160,
        width: 120,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) => const SizedBox(
            width: 120,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1,
              ),
            ),
          ),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(width: 10),
        ),
      );
}
