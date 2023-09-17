// ignore_for_file: prefer_null_aware_operators

class WordModel {
  String? word;
  List<Results>? results;
  Syllables? syllables;
  Pronunciation? pronunciation;
  double? frequency;

  WordModel(
      {this.word,
      this.results,
      this.syllables,
      this.pronunciation,
      this.frequency});

  WordModel.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    syllables = json['syllables'] != null
        ? Syllables.fromJson(json['syllables'])
        : null;
    pronunciation = json['pronunciation'] != null
        ? json['pronunciation'] is String
            ? Pronunciation(all: json['pronunciation'])
            : Pronunciation.fromJson(json['pronunciation'])
        : null;
    frequency = json['frequency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['word'] = word;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    if (syllables != null) {
      data['syllables'] = syllables!.toJson();
    }
    data['pronunciation'] = pronunciation;
    data['frequency'] = frequency;
    return data;
  }
}

class Results {
  Results(
      {this.definition,
      this.partOfSpeech,
      this.synonyms,
      this.typeOf,
      this.hasTypes,
      this.derivation,
      this.examples});

  Results.fromJson(Map<String, dynamic> json) {
    definition = json['definition'];
    partOfSpeech = json['partOfSpeech'];
    synonyms =
        json['synonyms'] != null ? json['synonyms'].cast<String>() : null;
    typeOf = json['typeOf'] != null ? json['typeOf'].cast<String>() : null;
    hasTypes =
        json['hasTypes'] != null ? json['hasTypes'].cast<String>() : null;
    derivation =
        json['derivation'] != null ? json['derivation'].cast<String>() : null;
    examples =
        json['examples'] != null ? json['examples'].cast<String>() : null;
  }

  String? definition;
  List<String>? derivation;
  List<String>? examples;
  List<String>? hasTypes;
  String? partOfSpeech;
  List<String>? synonyms;
  List<String>? typeOf;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['definition'] = definition;
    data['partOfSpeech'] = partOfSpeech;
    data['synonyms'] = synonyms;
    data['typeOf'] = typeOf;
    data['hasTypes'] = hasTypes;
    data['derivation'] = derivation;
    data['examples'] = examples;
    return data;
  }
}

class Syllables {
  Syllables({this.count, this.list});

  Syllables.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    list = json['list'].cast<String>();
  }

  int? count;
  List<String>? list;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['count'] = count;
    data['list'] = list;
    return data;
  }
}

class Pronunciation {
  String? all;

  Pronunciation({this.all});

  Pronunciation.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['all'] = all;
    return data;
  }
}
