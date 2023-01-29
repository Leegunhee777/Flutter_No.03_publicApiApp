import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/store.dart';

//MVVM패턴에서의! Model역할!을 하는 StoreRepository
class StoreRepository {
  Future<List<Store>> fetch(double lat, double lng) async {
    List<Store> stores = [];

    String baseUrl =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/?lat=$lat,lng=$lng/sample.json';

    try {
      final response = await http.get(Uri.parse(baseUrl));

      final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
      final jsonStores = jsonResult['stores'];

      for (var e in jsonStores) {
        stores.add(Store.fromJson(e));
      }
      //javasript의 filter와 흡사하다
      return stores
          .where((e) =>
              e.remainStat == 'plenty' ||
              e.remainStat == 'some' ||
              e.remainStat == 'few')
          .toList()
        //..sort의 compareTo를 통해 오름차순 정렬할수있음
        ..sort(
          ((a, b) => a.type!.compareTo(b.type!)),
        );
    } catch (error) {
      return [];
    }
  }
}
