import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:flutter/services.dart';
import 'package:flip_card/flip_card.dart';

import './../../../store/Store.dart';
import './../../../theme.dart';
import './../../../models/index.dart';
import './../../../utils/Recorder.dart';
import './../../../services/Api.dart';
import './../../../utils/Auth.dart';
import './../../../utils/ParseText.dart';

class RecordItem extends StatefulWidget {
  final SetItemModel setData;

  const RecordItem({Key key, @required this.setData}) : super(key: key);

//  @override
  _RecordItem createState() => _RecordItem();
}

class _RecordItem extends State<RecordItem>
    with SingleTickerProviderStateMixin<RecordItem> {
  bool _uploading = false;

  AnimationController _controller;
  Animation<Color> _animation;

  RecordModel _vietnameseAudio;

  @override
  dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();

    _controller = new AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );

    _animation = new ColorTween(
      begin: AppTheme.colorRed,
      end: AppTheme.colorDarkRed,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    if (widget.setData.vietnameseAudio != null) {
      _vietnameseAudio = new RecordModel(
          id: widget.setData.id + '-example',
          url: widget.setData.vietnameseAudio);
    }
  }

  Widget _storeConnector(BuildContext context) {
    return StoreConnector<AppState, RecordModel>(
      converter: (store) {
        try {
          return store.state.getById(widget.setData.id);
        } catch (error) {
          return RecordModel.initialData();
        }
      },
      builder: (context, RecordModel record) {
        return FlipCard(
          direction: FlipDirection.VERTICAL, // default
          front: _frontSide(context, record),
          back: _backSide(context),
        );
      },
    );
  }

  Widget _frontSide(BuildContext context, RecordModel record) {
    return Card(
      shape: AppTheme.cardShape,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: record.id.runes.length == 0
          ? _animation.value
          : AppTheme.colorDarkRed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _bottomLayer(context),
          record.id.runes.length > 1
              ? _topLayerRecorded(context, record)
              : _topLayerRecord(context)
        ],
      ),
    );
  }

  Widget _backSide(BuildContext context) {
    return Card(
      shape: AppTheme.cardShape,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: AppTheme.colorGreen,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  ParseText.parse(widget.setData.vietnamese),
                  style: AppTheme.recordCardText,
                ),
              ),
            ),
          ),
          _vietnameseAudio.url != ''
              ? ConstrainedBox(
                  constraints: new BoxConstraints(
                    minWidth: 48.0,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: _iconSwitcher(context, _vietnameseAudio),
                    ),
                  ),
                )
              : Text('')
        ],
      ),
    );
  }

  Widget _iconSwitcher(BuildContext context, RecordModel record) {
    return StreamBuilder(
      stream: recorder.listen,
      initialData: RecorderPlayingEvent.initialData(),
      builder: (context, AsyncSnapshot<RecorderPlayingEvent> snapshot) {
        if (snapshot.data.playing && snapshot.data.record.id == record.id) {
          return IconButton(
            padding: const EdgeInsets.all(0),
            icon: const Icon(
              Icons.stop,
              color: AppTheme.colorWhite,
            ),
            tooltip: 'Stop',
            onPressed: () => recorder.stop(),
          );
        } else {
          return IconButton(
            padding: const EdgeInsets.all(0),
            icon: const Icon(
              Icons.play_arrow,
              color: AppTheme.colorWhite,
            ),
            tooltip: 'Play',
            onPressed: () => recorder.play(record),
          );
        }
      },
    );
  }

  Widget _topLayerRecorded(BuildContext context, RecordModel record) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Switch play with pause buttons
        _iconSwitcher(context, record),

        // Delete recording
        IconButton(
          padding: const EdgeInsets.all(0),
          icon: const Icon(
            Icons.delete,
            color: AppTheme.colorWhite,
          ),
          tooltip: 'Delete Recording',
          onPressed: () => api.deleteRecord(widget.setData.id),
        ),
      ],
    );
  }

  Widget _topLayerRecord(BuildContext context) {
    return AbsorbPointer(
      absorbing: _uploading,
      child: HoldDetector(
        onHold: () async {
          await recorder.startRecording(widget.setData);
          await _controller.forward();
        },
        onCancel: () async {
          await recorder.stopRecording();
//          print('recording stopped');

          _controller.reset();

          setState(() {
            _uploading = true;
          });

          await recorder.uploadRecording(widget.setData);

          setState(() {
            _uploading = false;
          });

//          print('uploaded !!');

          SystemChannels.platform.invokeMethod<void>(
              'HapticFeedback.vibrate'); // Haptic on android
        },
        onTap: () {
          // ignore tap events
        },
        // holdTimeout: Duration(milliseconds: 5),
//        enableHapticFeedback: true,
        child: ConstrainedBox(
          constraints: new BoxConstraints(
            minWidth: 48.0,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                _uploading ? 'UPLOADING' : 'HOLD',
                style: AppTheme.smallText,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomLayer(BuildContext context) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          Card(
            shape: AppTheme.cardShape,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: const EdgeInsets.all(0.0),
            color: AppTheme.colorGreen,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  ParseText.parse(widget.setData.text),
                  style: AppTheme.recordCardText,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: Padding(
              child: Icon(
                Icons.help,
                size: 17,
                color: AppTheme.transparantText,
              ),
              padding: EdgeInsets.all(7.0),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<FirebaseUser>(
      future: authService.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData && snapshot.data.uid.isNotEmpty)
          return Container(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 125.0,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: IntrinsicHeight(
                  child: _storeConnector(context),
                ),
              ),
            ),
          );
        else
          return const Text('');
      },
    );
  }
}
