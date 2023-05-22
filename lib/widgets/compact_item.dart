import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:lenoid/model/latest_update.dart';
import 'package:lenoid/routes/app_navigator.dart';
import 'package:lenoid/utils/image/image_loader.dart';
import 'package:lenoid/widgets/custom_card.dart';

class CompactItem extends StatelessWidget {
  final LatestUpdate item;
  final int index;
  const CompactItem(this.item, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final delay = Duration(milliseconds: 200 * index);
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.only(top: 7, right: 7),
      child: CustomCard(
        onTap: () {
          AppNavigator.toDetailPage(item.name);
        },
        padding: const EdgeInsets.all(0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: AspectRatio(
              aspectRatio: 80 / 45,
              child: LoadImage(
                height: 140,
                imageUrl: item.thumbnail,
              ),
            ),
          ),
          // load asynchronously dumbass idea
          /* FutureBuilder(
            future: Future.delayed(delay, () => item.thumbnail),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: AspectRatio(
                    aspectRatio: 80 / 45,
                    child: LoadImage(
                      height: 140,
                      imageUrl: snapshot.data!,
                    ),
                  ),
                );
                /* AspectRatio(
                  aspectRatio: 80 / 45,
                  child: ExtendedImage.network(
                    snapshot.data!,
                    cacheHeight: 150,
                    shape: BoxShape.rectangle,
                    imageCacheName: 'lenoid_image',
                    filterQuality: FilterQuality.low,
                    borderRadius: BorderRadius.circular(13),
                  ),
                ); */
              } else {
                return const SizedBox(height: 140);
              }
            },
          ), */
          Container(
            alignment: AlignmentDirectional.topStart,
            padding: const EdgeInsets.all(9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6, bottom: 5),
                  child: Text(
                    episodeText(item.episode, item.dateUpload),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  String episodeText(String episode, String uploadDate) {
    return "$episode・$uploadDate";
  }
}
