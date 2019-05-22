import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mock_cloud_firestore/mock_types.dart';
import 'package:mockito/mockito.dart';

MockQuerySnapshot createMockQuerySnapshot(Map<String, dynamic> colData,
    {List<Map<String, dynamic>> added = const [],
    modified = const [],
    removed = const []}) {
  MockQuerySnapshot s = MockQuerySnapshot();
  List<MockDocumentChange> docChangeList = [];
  List<MockDocumentSnapshot> docSnapList = [];
  colData.forEach((String key, dynamic value) {
    MockDocumentSnapshot ds = createDocumentSnapshot(value);
    docSnapList.add(ds);
  });
  added.forEach((value) {
    MockDocumentChange dc =
        createDocumentChange(value, DocumentChangeType.added);
    docChangeList.add(dc);
  });
  modified.forEach((value) {
    MockDocumentChange dc =
        createDocumentChange(value, DocumentChangeType.modified);
    docChangeList.add(dc);
  });
  when(s.documentChanges).thenAnswer((_) => docChangeList);
  when(s.documents).thenAnswer((_) => docSnapList);
  return s;
}

MockDocumentReference createDocumentReference(Map<String, dynamic> value) {
  MockDocumentReference r = MockDocumentReference();
  MockDocumentSnapshot s = MockDocumentSnapshot();
  MockSnapshotMetadata sm = createSnapshotMetadata(false, false);
  when(s.data).thenReturn(value);
  when(s.metadata).thenReturn(sm);
  when(r.get()).thenAnswer((_) => Future.value(s));
  return r;
}

MockDocumentChange createDocumentChange(
    Map<String, dynamic> value, DocumentChangeType type) {
  MockDocumentChange dc = MockDocumentChange();
  MockDocumentSnapshot ds = createDocumentSnapshot(value);
  when(dc.oldIndex).thenReturn(-1);
  when(dc.newIndex).thenReturn(-1);
  when(dc.type).thenReturn(type);
  when(dc.document).thenReturn(ds);
  return dc;
}

MockDocumentSnapshot createDocumentSnapshot(Map<String, dynamic> value) {
  MockDocumentSnapshot ds = MockDocumentSnapshot();
  MockSnapshotMetadata sm = createSnapshotMetadata(false, false);
  when(ds.data).thenReturn(value);
  when(ds.metadata).thenReturn(sm);
  return ds;
}

MockSnapshotMetadata createSnapshotMetadata(
    bool isFromCache, bool hasPendingWrites) {
  MockSnapshotMetadata sm = MockSnapshotMetadata();
  when(sm.isFromCache).thenReturn(isFromCache);
  when(sm.hasPendingWrites).thenReturn(hasPendingWrites);
  return sm;
}
