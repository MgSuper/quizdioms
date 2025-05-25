import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'idioms.freezed.dart';
part 'idioms.g.dart';

@freezed
abstract class Idiom with _$Idiom {
  const factory Idiom({
    required String text,
    required String meaning,
    required String usage,
  }) = _Idiom;

  factory Idiom.fromJson(Map<String, dynamic> json) => _$IdiomFromJson(json);
}

@freezed
abstract class IdiomGroup with _$IdiomGroup {
  const factory IdiomGroup({
    required String id,
    required List<Idiom> idioms,
    required String groupName,
    required DateTime createdAt,
  }) = _IdiomGroup;

  factory IdiomGroup.fromJson(Map<String, dynamic> json) =>
      _$IdiomGroupFromJson(json);
}

IdiomGroup idiomGroupFromFirestore(Map<String, dynamic> json, String docId) {
  final idiomsRaw = json['idioms'] as List<dynamic>;

  final idioms = idiomsRaw
      .map((e) => Idiom.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  final createdAtRaw = json['createdAt'];
  final createdAt =
      createdAtRaw is Timestamp ? createdAtRaw.toDate() : DateTime.now();

  return IdiomGroup(
    id: docId,
    groupName: json['groupName'] ?? 'Untitled Group', // ✅ add fallback
    idioms: idioms,
    createdAt: createdAt,
  );
}

// ✅ Firestore mapping helpers (outside the class)
extension IdiomGroupFirestore on IdiomGroup {
  Map<String, dynamic> toFirestore() {
    return {
      'groupName': groupName,
      'idioms': idioms.map((e) => e.toJson()).toList(),
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
