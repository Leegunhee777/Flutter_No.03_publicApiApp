import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mvvmpublicapi/repository/location_repository.dart';
import 'package:mvvmpublicapi/repository/store_repository.dart';

import '../model/store.dart';

class StoreViewModel with ChangeNotifier {
  bool isLoading = false;
  List<Store> stores = [];

  //view 에서는 Repository의 존재를 몰라야 한다.
  //그래서 _storeRepository를 사용해준다.
  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();

  StoreViewModel() {
    fetch();
  }
  Future fetch() async {
    isLoading = true;
    //notifyListeners()로 통지를 하면 Provider.of를 사용하고있는 build메소드가 재호출되면서
    //업데이트 된 값을 확인할수있다.
    notifyListeners();

    Position position = await _locationRepository.getCurrentLocation();

    stores = await _storeRepository.fetch(
      position.latitude,
      position.longitude,
    );
    isLoading = false;
    notifyListeners();
  }
}
