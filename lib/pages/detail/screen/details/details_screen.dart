import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lenoid/utils/behavior/custom_behavior.dart';
import 'package:lenoid/utils/color/color_utils.dart';
import 'package:lenoid/utils/image/image_loader.dart';
import 'package:lenoid/widgets/custom_card.dart';
import 'package:lenoid/widgets/keep_alive_wrapper.dart';

import 'details_screen_controller.dart';

class DetailsScreen extends StatelessWidget {
  final DetailsScreenController controller;
  DetailsScreen({Key? key})
      : controller = Get.put(DetailsScreenController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    return Scaffold(
      body: KeepAliveWrapper(
        child: Stack(
          children: [
            EasyRefresh(
              refreshOnStart: true,
              header: const MaterialHeader(),
              footer: const MaterialFooter(),
              scrollBehaviorBuilder: (physic) {
                return CustomScrollBehavior(physic);
              },
              child: ListView(
                children: [
                  _buildCoverDetails(materialTheme),
                  _episodeItem(materialTheme),
                  _episodeItem(materialTheme),
                  _episodeItem(materialTheme),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // WIP
  Widget _buildCoverDetails(ThemeData materialTheme) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCard(
                padding: const EdgeInsets.all(0),
                backgroundColor: ColorUtils.elevationOverlay,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: LoadImage(
                    height: 230,
                    width: 150,
                    memCacheHeight: 400,
                    filter: FilterQuality.high,
                    progressPlaceHolder: true,
                    imageUrl:
                        "https://lendrive.web.id/wp-content/uploads/2023/04/1681178702-6099-130452.jpg",
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kanojo ga Koushaku-tei ni Itta Riyuu, Kanojo ga Koushaku-tei ni Itta Riyuu',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: materialTheme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Wrap(spacing: 7, children: [
                      _textSummaryBody(
                        materialTheme,
                        textTitle: "Season",
                        textBody: "textBody",
                      ),
                      // const SizedBox(width: 10, height: 8),
                      _textSummaryBody(
                        materialTheme,
                        textTitle: "Status",
                        textBody: "textBody",
                      ),
                      // const SizedBox(width: 10, height: 8),
                      _textSummaryBody(
                        materialTheme,
                        textTitle: "Studio",
                        textBody: "textBody",
                      ),
                    ]),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.movie_outlined,
              weight: 400,
              size: 16,
            ),
            label: const Text("Trailer"),
          ),
          const SizedBox(height: 20),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis gravida nisl. Fusce euismod elit vel arcu tincidunt, nec posuere mi egestas. Sed nec orci nisi. Nulla facilisi. Integer euismod massa quis nisl eleifend, ac blandit dui vehicula. Proin vitae enim euismod, faucibus nibh eget, bibendum augue. Sed vestibulum urna vel cursus vestibulum. Integer dignissim erat non orci facilisis, sed dignissim velit molestie. Vivamus lacinia, libero ac lobortis tincidunt, mi quam lobortis enim, sed eleifend quam urna vel velit. Sed vel orci ligula.',
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              letterSpacing: 0.33,
              fontWeight: FontWeight.w300,
              color: materialTheme.textTheme.bodySmall!.color,
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Offstage(
              offstage: controller.listGenre.isEmpty,
              child: Wrap(
                spacing: 6,
                children: controller.listGenre.map(
                  (genre) {
                    return Chip(
                      label: Text(genre.title),
                      labelStyle: const TextStyle(fontSize: 12),
                      backgroundColor:
                          materialTheme.colorScheme.onInverseSurface,
                      side: BorderSide.none,
                    );
                  },
                ).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _episodeItem(ThemeData materialTheme) {
    return ListTile(
      leading: const Icon(Icons.bookmark_add_outlined),
      title: const Text("Oshi No Ko – Ep 01"),
      subtitle: const Text("April 27, 2023"),
      titleTextStyle: materialTheme.textTheme.titleMedium,
      subtitleTextStyle: materialTheme.textTheme.bodySmall,
    );
  }

  Widget _textSummaryBody(
    ThemeData materialTheme, {
    required String textTitle,
    required String textBody,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textTitle,
          style: materialTheme.textTheme.bodyLarge!.copyWith(
            letterSpacing: 0.58,
          ),
        ),
        Text(
          textBody,
          style: materialTheme.textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}

// Kanojo ga Koushaku-tei ni Itta Riyuu
