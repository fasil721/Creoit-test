import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/datas/secrets.dart';
import 'package:netflix_clone/screens/coming_soon/bloc/comingsoon_bloc.dart';
import 'package:netflix_clone/theme/theme.dart';
import 'package:netflix_clone/utils/utils.dart';

class ComingSoonPage extends StatefulWidget {
  const ComingSoonPage({super.key});

  @override
  State<ComingSoonPage> createState() => _ComingSoonViewState();
}

class _ComingSoonViewState extends State<ComingSoonPage> {
  final scroll = ScrollController();

  final ValueNotifier<double> notifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    SizedBox(
                      height: 60,
                      child: ListTile(
                        tileColor: Colors.black,
                        title: Text(
                          "Coming Soon",
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: NewTheme.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Wrap(
                          children: [
                            ImageIcon(
                              const AssetImage("assets/icons/search.png"),
                              color: NewTheme.secondaryColor,
                            ),
                            const SizedBox(width: 15),
                            Image.network(
                              "https://ih0.redbubble.net/image.618427277.3222/flat,1000x1000,075,f.u2.jpg",
                              width: 25,
                              height: 25,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: ListTile(
                        tileColor: Colors.black,
                        minLeadingWidth: 20,
                        leading: Icon(
                          Icons.notifications_none_sharp,
                          color: NewTheme.secondaryColor,
                        ),
                        title: Text(
                          "Notifications",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: NewTheme.secondaryColor,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: NewTheme.secondaryColor,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BlocProvider(
              create: (context) =>
                  ComingsoonBloc()..add(LoadUpcomingMoviesEvent()),
              child: BlocBuilder<ComingsoonBloc, ComingsoonState>(
                builder: (context, state) {
                  if (state is UpcomingMoviesLoadedState) {
                    final datas = state.movies;
                    return ListView.builder(
                      itemCount: datas.length,
                      itemBuilder: (context, index) {
                        String date;
                        date = Utils.datePicker(datas[index].releaseDate!);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200,
                              child: Stack(
                                children: [
                                  Image.network(
                                    Secrets.imageUrl +
                                        datas[index].backdropPath!,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(),
                                  ),
                                  Align(
                                    child: Container(
                                      height: 55,
                                      width: 55,
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: NewTheme.secondaryColor,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: NewTheme.secondaryColor,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Coming On $date",
                                style: GoogleFonts.roboto(
                                  fontSize: 13,
                                  color: NewTheme.secondaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                bottom: 10,
                              ),
                              child: Text(
                                datas[index].title!,
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  color: NewTheme.secondaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                datas[index].overview!,
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: NewTheme.secondaryColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: FutureBuilder<List<String>>(
                                future:
                                    Utils.genrePicker(datas[index].genreIds!),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    final genres = snapshot.data!;
                                    return Row(
                                      children: [
                                        ...genres.map(
                                          (element) {
                                            return Row(
                                              children: [
                                                Text(
                                                  element,
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 13,
                                                    color:
                                                        NewTheme.secondaryColor,
                                                  ),
                                                ),
                                                if (genres.last != element)
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 4,
                                                    ),
                                                    child: Icon(
                                                      FontAwesomeIcons.ggCircle,
                                                      color: Colors.blue,
                                                      size: 4,
                                                    ),
                                                  )
                                                else
                                                  const SizedBox(),
                                              ],
                                            );
                                          },
                                        )
                                      ],
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
