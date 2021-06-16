part of '../polar.dart';

class PolarEcgData {
  final int timeStamp;
  final List<int> samples;

  PolarEcgData.fromJson(Map<String, dynamic> json)
      : timeStamp = json['timeStamp'],
        samples = (json['samples'] as List).map((e) => e as int).toList();
}

class PolarAccData {
  final int timeStamp;
  final List<Xyz> samples;

  PolarAccData.fromJson(Map<String, dynamic> json)
      : timeStamp = json['timeStamp'],
        samples =
            (json['samples'] as List).map((e) => Xyz.fromJson(e)).toList();
}

class PolarExerciseData {
  final int interval;
  final List<int> samples;

  PolarExerciseData.fromJson(Map<String, dynamic> json)
      : interval = json['interval'],
        samples = (json['samples'] as List).map((e) => e as int).toList();
}

class PolarGyroData {
  final int timeStamp;
  final List<Xyz> samples;

  PolarGyroData.fromJson(Map<String, dynamic> json)
      : timeStamp = json['timeStamp'],
        samples =
            (json['samples'] as List).map((e) => Xyz.fromJson(e)).toList();
}

class PolarMagnetometerData {
  final int timeStamp;
  final List<Xyz> samples;

  PolarMagnetometerData.fromJson(Map<String, dynamic> json)
      : timeStamp = json['timeStamp'],
        samples =
            (json['samples'] as List).map((e) => Xyz.fromJson(e)).toList();
}

class PolarOhrData {
  final int timeStamp;
  final OhrDataType type;
  final List<List<int>> samples;

  PolarOhrData.fromJson(Map<String, dynamic> json)
      : timeStamp = json['timeStamp'],
        type = OhrDataTypeExtension.fromJson(json['type']),
        samples = Platform.isIOS
            ? (json['samples'] as List)
                .map((e) => (e as List).map((e) => e as int).toList())
                .toList()
            : (json['samples'] as List)
                .map((e) =>
                    (e['channelSamples'] as List).map((e) => e as int).toList())
                .toList();
}

class PolarPpiData {
  final int timeStamp;
  final List<PolarOhrPpiSample> samples;

  PolarPpiData.fromJson(Map<String, dynamic> json)
      : timeStamp = json['timeStamp'],
        samples = (json['samples'] as List)
            .map((e) => PolarOhrPpiSample.fromJson(e))
            .toList();
}