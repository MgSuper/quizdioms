import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class DateTimeTimestampConverter implements JsonConverter<DateTime, dynamic> {
  const DateTimeTimestampConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate();
    } else if (json is String) {
      return DateTime.parse(json);
    } else if (json is DateTime) {
      return json;
    }
    throw Exception('Invalid date format: $json');
  }

  @override
  Object toJson(DateTime date) => Timestamp.fromDate(date);
}

class TimestampConverter implements JsonConverter<DateTime, Object> {
  const TimestampConverter();

  @override
  DateTime fromJson(Object json) {
    if (json is Timestamp) {
      return json.toDate();
    } else if (json is String) {
      return DateTime.parse(json);
    }
    throw Exception('Invalid date format');
  }

  @override
  Object toJson(DateTime date) => Timestamp.fromDate(date);
}
