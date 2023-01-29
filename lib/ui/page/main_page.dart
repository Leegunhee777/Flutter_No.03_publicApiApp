import 'package:flutter/material.dart';
import 'package:mvvmpublicapi/ui/widget/remain_stat_list_tile.dart';
import 'package:mvvmpublicapi/viewModel/store_viewModel.dart';

import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final storeViewModel = Provider.of<StoreViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('마스크 재고 있는 곳: ${storeViewModel.stores.length}곳'),
          actions: [
            IconButton(
              onPressed: (() {
                storeViewModel.fetch();
              }),
              icon: const Icon(Icons.refresh),
            )
          ],
        ),
        body: buildBody(storeViewModel));
  }
}

Widget buildBody(StoreViewModel storeViewModel) {
  if (storeViewModel.isLoading == true) {
    return loadingWidget();
  }

  if (storeViewModel.stores.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('재고가 있는 매장이 없습니다'),
          Text('또는 인터넷이 연결되어 있는지 확인해 주세요.'),
        ],
      ),
    );
  }

  return ListView(
    children: storeViewModel.stores
        .map(
          (element) => RemainStatListTile(store: element),
        )
        .toList(),
  );
}

Widget loadingWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('정보를 가져오는중'),
        CircularProgressIndicator(),
      ],
    ),
  );
}
