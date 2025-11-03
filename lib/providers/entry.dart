import 'dart:async';
import 'dart:typed_data';

// import 'package:appwrite/appwrite.dart';

import 'package:flutter/material.dart';
import 'package:OBOX/api/client.dart';
import 'package:OBOX/data/entry.dart';

class EntryProvider extends ChangeNotifier {
  Map<String, Uint8List> _imageCache = {};

  static String _collectionId = "movies";

  Entry? _selected = null;
  Entry? get selected => _selected;

  Entry _featured = Entry.empty();
  Entry get featured => _featured;

  List<Entry> _entries = [];
  List<Entry> get entries => _entries;
  List<Entry> get originals => _entries.where((e) => e.isOG == true).toList();
  List<Entry> get animations => _entries
      .where((e) => e.genre.toLowerCase().contains('animation'))
      .toList();
  List<Entry> get newReleases => _entries
      .where((e) =>
          e.releaseDate != null &&
          e.releaseDate!.isAfter(DateTime.parse('2018-01-01')))
      .toList();

  List<Entry> get trending {
    var trending = _entries;

    trending.sort((a, b) => b.trendingIndex.compareTo(a.trendingIndex));

    return trending;
  }

  void setSelected(Entry entry) {
    _selected = entry;

    notifyListeners();
  }

  Future<void> list() async {
    var result =
        await ApiClient.database.listDocuments(collectionId: _collectionId, databaseId: '');

    _entries = result.documents
        .map((document) => Entry.fromJson(document.data))
        .toList();
    _featured = _entries.isEmpty ? Entry.empty() : _entries[0];

    notifyListeners();
  }

  Future<Uint8List> imageFor(Entry entry) async {
    if (_imageCache.containsKey(entry.thumbnailimageid)) {
      return _imageCache[entry.thumbnailimageid]!;
    }

    final result =
        await ApiClient.storage.getFileView(fileId: entry.thumbnailimageid, bucketId: '');

    _imageCache[entry.thumbnailimageid] = result;

    return result;
  }
}