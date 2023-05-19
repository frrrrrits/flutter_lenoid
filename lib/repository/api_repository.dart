import 'package:html/dom.dart';
import '../../model/latest_update.dart';
import '../../utils/network/htpp_client.dart';
import '../data/constants.dart';
import '../data/network/api_service.dart';

class ApiRepository extends ApiService {
  final String baseUrl = Constants.base_url;
  late final httpClient = HttpClient.instance;

  @override
  Future<List<LatestUpdate>> getLatestUpdate({int page = 1}) async {
    List<LatestUpdate> list = [];
    Document document = await httpClient.requests("$baseUrl/page/$page");
    List<Element> selector = document.querySelectorAll(
        "div.bixbox.bbnofrm > div.releases.latesthome + div.listupd.normal div.bsx");
    for (var document in selector) {
      var aElement = document.querySelector("a");
      var title = aElement!.attributes['title'];
      var links = aElement.attributes['href'];
      var episodes = document.querySelector('span.epx')?.text;
      var dateUploads = document.querySelector('span.datex')?.text;
      var thumbnails = document.querySelector('img')!.attributes['src'];
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
}
