import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

CachedNetworkImage LoadImage({
  required String imageUrl,
  required double? height,
  BoxFit? fit,
  Duration? duration,
}) {
  const key = 'lendoid_image_cache';
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit ?? BoxFit.cover,
    height: height,
    memCacheHeight: 170,
    key: ValueKey(imageUrl),
    filterQuality: FilterQuality.low,
    errorWidget: (_, url, error) => const Icon(Icons.broken_image),
    cacheManager: CacheManager(Config(
      key,
      repo: JsonCacheInfoRepository(databaseName: key),
      stalePeriod: const Duration(minutes: 56),
    )),
  );
}
