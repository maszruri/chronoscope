import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/models/stories_model.dart';
import 'package:chronoscope/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          color: primaryColor,
          child: Builder(
            builder: (context) {
              StoriesModel? stories =
                  context.watch<HomeProvider>().storiesModel;
              if (stories == null) {
                return Container(
                  color: primaryColor,
                );
              } else {
                return RefreshIndicator(
                  color: secondaryColor,
                  onRefresh: () =>
                      context.read<HomeProvider>().refreshStories(),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: secondaryColor,
                      thickness: 0.1,
                    ),
                    itemCount: stories.listStory.length,
                    itemBuilder: (context, index) {
                      var story = stories.listStory[index];
                      double size = MediaQuery.of(context).size.width;

                      return SizedBox(
                        height: size,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              width: size,
                              height: size * 0.5 / 4,
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                story.name,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                // final SharedPreferences prefs =
                                //     await SharedPreferences.getInstance();
                                // print(story.id);
                                // print(prefs.get('token'));
                                String id = story.id;
                                context.push('/detail/$id');
                              },
                              child: Container(
                                height: size * 3.3 / 4,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(story.photoUrl),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
        if (context.watch<HomeProvider>().isLoading)
          const Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (context.watch<HomeProvider>().isLoading)
          const Center(
            child: CircularProgressIndicator(
              color: secondaryColor,
            ),
          ),
      ],
    );
  }
}
