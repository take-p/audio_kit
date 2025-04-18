import '../../../audio_box.dart';

abstract interface class AudioRepository {
  /// キーとファイルパスのペアを登録
  Future<void> registerAll(Map<String, AudioSourceEntry> sources);

  /// メモリ読込（プリロード）
  Future<void> preload({required String key, Duration? autoDisposeAfter});
  Future<void> preloadAll({
    required List<String> keys,
    Duration? autoDisposeAfter,
  });

  /// メモリ解放
  Future<void> dispose({required String key});
  Future<void> disposeAll({required List<String> keys});

  /// マスターボリューム
  double getMasterVolume();
  Future<void> setMasterVolume(double volume);

  /// マスタースピード
  double getMasterSpeed();
  Future<void> setMasterSpeed(double speed);

  /// マスターピッチ
  double getMasterPitch();
  Future<void> setMasterPitch(double pitch);

  /// 音声操作
  ///
  /// - [key] は必須です。
  /// - [channel] を指定した場合、そのチャンネルに対して処理を行います。
  ///   （playメソッドでは、keyとchannelを同時指定可能です）
  /// - [stop]、[pause]、[resume]、[changeVolume]、[changeSpeed] では、keyとchannelが同時指定された場合はエラーをスローし、
  ///   両方とも null の場合は全ての音声に対して処理を行います。
  Future<void> play({
    required String key,
    String? channel,
    bool loop = false,
    Duration? fadeDuration,
    Duration? playPosition,
    double? playSpeed,
    Duration? loopStartPosition,
  });

  Future<void> stop({String? key, String? channel, Duration? fadeDuration});

  Future<void> pause({String? key, String? channel, Duration? fadeDuration});

  Future<void> resume({
    String? key,
    String? channel,
    Duration? fadeDuration,
    Duration? playPosition,
    double? playSpeed,
  });

  /// 音声調整
  Future<void> changeVolume({
    String? key,
    String? channel,
    required double volume,
    Duration? fadeDuration,
  });

  Future<void> changeSpeed({
    String? key,
    String? channel,
    required double speed,
    Duration? fadeDuration,
  });

  Future<void> changePitch({
    String? key,
    String? channel,
    required double pitch,
    Duration? fadeDuration,
  });

  /// 状態取得
  Future<bool> isPreloaded({required String key});
  Future<AudioStatus> getStatus({required String key});
  Future<Duration> getPosition({required String key});
}
