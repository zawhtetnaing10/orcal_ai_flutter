import 'dart:collection';

import 'package:orcal_ai_flutter/data/vos/info_to_embed_vo.dart';

class KnowledgeBaseCache {
  /// Singleton
  static final KnowledgeBaseCache _instance = KnowledgeBaseCache._internal();

  KnowledgeBaseCache._internal();

  factory KnowledgeBaseCache() {
    return _instance;
  }

  Map<int, InfoToEmbedVO> knowledgeBaseCache = HashMap();

  void clearInfoToEmbed() {
    knowledgeBaseCache.clear();
  }

  void addInfoToEmbedMultiple(Map<int, InfoToEmbedVO> infoToEmbed) {
    knowledgeBaseCache.addAll(infoToEmbed);
  }

  void addInfoToEmbedSingle(int id, InfoToEmbedVO infoToEmbed) {
    knowledgeBaseCache[id] = infoToEmbed;
  }
}
