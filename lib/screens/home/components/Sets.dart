import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import './../../../components/setCard/SetCard.dart';
import './../../../services/Api.dart';
import './../../../models/index.dart';

class Sets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<SetModel>>.value(
          value: api.streamSets(),
          initialData: [SetModel.initialData()],
        ),
      ],
      child: Expanded(
        child: SetsList(),
      ),
    );
  }
}

class SetsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _sets = Provider.of<List<SetModel>>(context);

    if (_sets.isEmpty) {
      return const Text('');
    } else {
      return Padding(
        padding: EdgeInsets.only(bottom: 60.0),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            if (index != _sets.length) {
              return new SetCard(num: index, setData: _sets[index]);
            } else {
              return Text('');
            }
          },
          itemCount: _sets.length,
          viewportFraction: .8,
          scale: .9,
          loop: false,
        ),
      );
    }
  }
}
