import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';
import './../models/index.dart';
import './../services/Api.dart';

class RecorderPlayingEvent {
  final bool playing;
  final RecordModel record;

  RecorderPlayingEvent({this.playing, this.record});

  factory RecorderPlayingEvent.initialData() {
    return RecorderPlayingEvent(
      playing: false,
      record: new RecordModel(id: '', url: ''),
    );
  }
}

class Recorder {
  final FlutterSound flutterSound = new FlutterSound();
  final StreamController<RecorderPlayingEvent> _streamController =
      new StreamController.broadcast();

  String _path;
  StreamSubscription<PlayStatus> _playerSubscription;
  RecordModel _playingRecord = RecordModel.initialData();

  void destroy() {
    
    flutterSound.stopRecorder();
    _path = null;
    _playingRecord = RecordModel.initialData();

    if (_streamController != null) {
      _streamController.close();
    }

    if (_playerSubscription != null) {
      _playerSubscription.cancel();
      _playerSubscription = null;
    }
    
  }

  Stream<RecorderPlayingEvent> get listen {
    return _streamController.stream;
  }

  Future<String> startRecording(SetItemModel setData) async {
    if (flutterSound.isRecording) {
      return null;
    }
    String path = await flutterSound.startRecorder(uri: setData.id + '.mp4');
//    print('start recording: $path');
    _path = path;
    return path;
  }

  Future<void> stopRecording() async {
    if (!flutterSound.isRecording) {
//      return print('Not recording !!');
      return;
    }

    await flutterSound.stopRecorder();
  }

  Future<String> uploadRecording(SetItemModel setData) async {
    if (_path == null) {
//      print('Nothing to upload !!');
      return '';
    }

    // Ship file !!!
    var _url = await api.uploadFile(_path, setData.id);
    await api.createRecord(setData.id, _url);

    // reset to null
    _path = null;

    return _url;
  }

  void play(RecordModel record) async {
    if (flutterSound.audioState == t_AUDIO_STATE.IS_PLAYING) {
      await stop();
    }

    if(record.url == '') {
      print('No url provided');
      return;
    }

//    print('starting to play $record.id');

    this._playingRecord = record;

    _streamController.add(
        new RecorderPlayingEvent(playing: true, record: this._playingRecord));

    await flutterSound.startPlayer(record.url);
    await flutterSound.setVolume(1.0);

    _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
      if (e != null) {
        if (e.currentPosition == e.duration) {
          _streamController.add(new RecorderPlayingEvent(
              playing: false, record: this._playingRecord));
        }
      }
    });

    // print('playing $record');
  }

  Future<void> stop() async {
    if (flutterSound.audioState != t_AUDIO_STATE.IS_PLAYING) {
      return;
    }

    _streamController.add(
        new RecorderPlayingEvent(playing: false, record: this._playingRecord));

    await flutterSound.stopPlayer();

    if (_playerSubscription != null) {
      _playerSubscription.cancel();
      _playerSubscription = null;
    }

    this._playingRecord = RecordModel.initialData();

    return null;

  }
}

final recorder = new Recorder();
