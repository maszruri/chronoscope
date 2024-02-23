import 'package:chronoscope/constants/colors.dart';
import 'package:chronoscope/models/story_model.dart';
import 'package:chronoscope/providers/detail_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({
    super.key,
    required this.id,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    Future.microtask(
        () => context.read<DetailProvider>().fetchDetail(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(
          context.watch<DetailProvider>().storyModel?.story.name ?? "",
          style: const TextStyle(color: accentColor),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
            color: secondaryColor,
          ),
        ),
      ),
      body: Consumer<DetailProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return child!;
          }
        },
        child: DetailWidget(
          storyModel: context.watch<DetailProvider>().storyModel,
        ),
      ),
    );
  }
}

class DetailWidget extends StatelessWidget {
  final StoryModel? storyModel;
  const DetailWidget({
    required this.storyModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final story = storyModel!.story;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: secondaryColor),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(story.photoUrl),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(story.description),
        ),
      ],
    );
  }
}
