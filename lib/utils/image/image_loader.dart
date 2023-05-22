import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// image dengan low res di butuhkan biar gak ngecrash (oom)
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
    memCacheHeight: 150,
    key: ValueKey(imageUrl),
    filterQuality: FilterQuality.low,
    fadeInDuration: const Duration(milliseconds: 100),
    placeholder: (_, error) => const Icon(Icons.image, size: 24),
    errorWidget: (_, url, error) => const Icon(Icons.broken_image, size: 24),
    cacheManager: CacheManager(Config(
      key,
      repo: JsonCacheInfoRepository(databaseName: key),
      stalePeriod: const Duration(minutes: 56),
    )),
  );
}
