import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// image dengan low res di butuhkan biar gak ngecrash (oom)
CachedNetworkImage LoadImage({
  required String imageUrl,
  required double? height,
  double? width,
  BoxFit? fit,
  Duration? duration,
  int? memCacheHeight,
  FilterQuality? filter,
  bool progressPlaceHolder = false,
}) {
  const key = 'lendoid_image_cache';
  return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: fit ?? BoxFit.cover,
    height: height,
    width: width,
    memCacheHeight: memCacheHeight ?? 150,
    key: ValueKey(imageUrl),
    filterQuality: filter ?? FilterQuality.low,
    fadeInDuration: const Duration(milliseconds: 100),
    placeholder: (_, error) => progressPlaceHolder
        ? const Center(child: CircularProgressIndicator())
        : const Icon(Icons.broken_image, size: 24),
    errorWidget: (_, url, error) => const Icon(Icons.broken_image, size: 24),
    cacheManager: CacheManager(Config(
      key,
      repo: JsonCacheInfoRepository(databaseName: key),
      stalePeriod: const Duration(minutes: 56),
    )),
  );
}
