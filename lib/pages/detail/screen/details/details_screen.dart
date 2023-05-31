import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lenoid/utils/color/color_utils.dart';
import 'package:lenoid/utils/image/image_loader.dart';
import 'package:lenoid/widgets/custom_card.dart';
import 'package:lenoid/widgets/keep_alive_wrapper.dart';

import 'details_screen_controller.dart';

class DetailsScreen extends StatelessWidget {
  final String url;
  final DetailsScreenController controller;
  DetailsScreen({required this.url, super.key})
      : controller = Get.put(
          DetailsScreenController(url),
          tag: DateTime.now().millisecondsSinceEpoch.toString(),
        );

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            ListView(
              children: [
                _buildCoverDetails(materialTheme),
                ...List.generate(controller.episodeLength, (i) {
                  return _episodeItem(
                    materialTheme,
                    episodeTitle: controller.episodeModel![i].title,
                    episodeDate: controller.episodeModel![i].dateUpload,
                  );
                })
              ],
            ),
            Offstage(
              offstage: !controller.pagingLoading.value,
              child: const Center(child: CircularProgressIndicator()),
            ),
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
                  child: controller.detailModel?.thumbnail.isEmpty ?? true
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.1),
                          ),
                          child: const Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 24,
                          ),
                        )
                      : LoadImage(
                          height: 230,
                          width: 150,
                          memCacheHeight: 400,
                          filter: FilterQuality.high,
                          progressPlaceHolder: true,
                          imageUrl: controller.detailModel?.thumbnail ?? "",
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.detailModel?.title ?? "Tidak di Ketahui",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: materialTheme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Wrap(spacing: 7, children: [
                      _textSummaryBody(
                        materialTheme,
                        textTitle: "Season",
                        textBody: controller.detailModel?.season ??
                            "Tidak di Ketahui",
                      ),
                      // const SizedBox(width: 10, height: 8),
                      _textSummaryBody(
                        materialTheme,
                        textTitle: "Status",
                        textBody: controller.detailModel?.status ??
                            "Tidak di Ketahui",
                      ),
                      // const SizedBox(width: 10, height: 8),
                      _textSummaryBody(
                        materialTheme,
                        textTitle: "Studio",
                        textBody: controller.detailModel?.studio ??
                            "Tidak di Ketahui",
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
            controller.detailModel?.sinopsis ?? "Tidak di Ketahui",
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
          Offstage(
            offstage: controller.genreModel?.isEmpty ?? true,
            child: Wrap(
              spacing: 6,
              children: List.generate(
                controller.genreModel?.length ?? 0,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Chip(
                      label: Text(controller.genreModel![index].title),
                      labelStyle: const TextStyle(fontSize: 12),
                      backgroundColor:
                          materialTheme.colorScheme.onInverseSurface,
                      side: BorderSide.none,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _episodeItem(
    ThemeData materialTheme, {
    required String? episodeTitle,
    required String? episodeDate,
  }) {
    return ListTile(
      leading: const Icon(Icons.bookmark_add_outlined),
      title: Text(episodeTitle ?? "Not Found"),
      subtitle: Text(episodeDate ?? "Not Found"),
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
