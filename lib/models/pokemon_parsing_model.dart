class PokemonListModel {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonResultModel> results;

  PokemonListModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonListModel.fromJson(Map<String, dynamic> json) {
    return PokemonListModel(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>)
          .map((item) => PokemonResultModel.fromJson(item))
          .toList(),
    );
  }
}
class PokemonResultModel {
  final String name;
  final String url;
  bool? isFav;

  PokemonResultModel({
    required this.name,
    required this.url,
    this.isFav = false,
  });

  factory PokemonResultModel.fromJson(Map<String, dynamic> json) {
    return PokemonResultModel(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'isFav': isFav == true ? 1 : 0,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PokemonResultModel &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              url == other.url;

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
