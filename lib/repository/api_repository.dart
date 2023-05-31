import 'package:collection/src/iterable_extensions.dart';
import 'package:html/dom.dart';
import 'package:lenoid/model/detail_model.dart';

import '../../model/latest_update.dart';
import '../../utils/network/htpp_client.dart';
import '../data/constants.dart';
import '../data/network/api_service.dart';

class ApiRepository extends ApiService {
  final String baseUrl = Constants.base_url;
  final httpClient = HttpClient.instance;

  @override
  Future<List<LatestUpdate>> getLatestUpdate({int page = 1}) async {
    List<LatestUpdate> list = [];
    Document document = await httpClient.requests("$baseUrl/page/$page");
    List<Element> selector = document.querySelectorAll(
        "div.bixbox.bbnofrm > div.releases.latesthome + div.listupd.normal div.bsx");
    for (var document in selector) {
      var aElement = document.querySelector("a");
      var title = aElement?.attributes['title'] ?? "Tidak di Ketahui";
      var links = aElement?.attributes['href'];
      var episodes = document.querySelector('span.epx')?.text ?? "??";
      var dateUploads = document.querySelector('span.datex')?.text ?? "??";
      var thumbnails = document.querySelector('img')!.attributes['src'];
      if (title.toLowerCase().contains("link download") ||
          title.toLowerCase().contains("download")) {
        continue;
      }
      list.add(LatestUpdate(
        name: title.toString(),
        episode: episodes.toString(),
        episodeUrl: links.toString(),
        dateUpload: dateUploads.toString(),
        thumbnail: thumbnails.toString(),
      ));
    }
    return list;
  }

  @override
  Future<String> getDetailUrl({required String url}) async {
    Document document = await httpClient.requests(url);
    Element? selector = document.querySelector('div.nvs.nvsc > a');
    var detailUrl = selector?.attributes['href'];
    return detailUrl.toString();
  }

  @override
  Future<DetailModel> getDetail({required String url}) async {
    List<Genres> genre = [];
    List<Episodes> episode = [];
    Document document = await httpClient.requests(url);
    Element? infoSelector = document.querySelector('div.infox');
    List<Element>? genreSelector =
        document.querySelector('div.genxed')?.querySelectorAll('a');
    List<Element>? episodeSelector =
        document.querySelectorAll('div.bixbox.bxcl.epcheck li');

    // information
    var title = infoSelector!.querySelector("h1")?.text;
    // var season = _containSelector(infoSelector, "div.spe span", "Season:");
    var season = containSelector(infoSelector, "div.spe span", "Season:");
    var status = containSelector(infoSelector, "div.spe span", "Status:");
    var studio = containSelector(infoSelector, "div.spe span", "Studio:");
    var sinopsis =
        document.querySelector("div.bixbox.synp")?.text ?? "Tidak di Ketahui";
    var thumbnail = document
        .querySelector("div.bigcontent.nobigcv div.thumb img")
        ?.attributes['src'];

    // genre
    if (genreSelector != null) {
      for (var document in genreSelector) {
        genre.add(Genres(document.text));
      }
    }

    // episode
    if (episodeSelector != null) {
      for (var document in episodeSelector) {
        episode.add(Episodes(
          url: document.querySelector('a')!.attributes['href'].toString(),
          title: document.querySelector('div.epl-title')!.text,
          dateUpload: document.querySelector('div.epl-date')!.text,
        ));
      }
    }

    return DetailModel(
      genre: genre,
      episodes: episode,
      title: title.toString(),
      sinopsis: sinopsis.toString(),
      thumbnail: thumbnail.toString(),
      season: season,
      status: status,
      studio: studio,
    );
  }

  String containSelector(Element selector, String query, String contains) {
    var element = selector.querySelectorAll(query);
    var firstWhere =
        element.firstWhereOrNull((element) => element.text.contains(contains));
    return firstWhere?.text.replaceFirst(contains, '').trim().toString() ??
        "Tidak Di Ketahui";
  }
}
