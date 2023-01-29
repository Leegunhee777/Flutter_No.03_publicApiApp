import 'package:flutter/material.dart';
import 'package:mvvmpublicapi/model/store.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;
  const RemainStatListTile({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name!),
      subtitle: Column(
        children: [
          Text(store.addr!),
        ],
      ),
      trailing: buildRemainWidget(store),
      onTap: () {
        onClickTap(store.lat, store.lng);
      },
    );
  }

  //방법1
  onClickTap(double? lat, double? lng) async {
    await launchUrlString(
        'https://google.com/maps/search/?api=1&query=$lat,$lng');
  }

  //방법2
  // final Uri _url = Uri.parse('https://flutter.dev');
  // Future<void> _launchUrl() async {
  //   if (!await launchUrl(_url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }

  Widget buildRemainWidget(Store store) {
    var remainStat = '판매중지';
    var description = '판매중지';
    var color = Colors.black;

    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30 ~ 100 개이상';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2 ~ 30개이상';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
      default:
    }

    return Column(
      children: [
        Text(
          remainStat,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(description),
      ],
    );
  }
}
