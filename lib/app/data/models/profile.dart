class Profile {
  String? name;
  String? bio;
  String? profilePic;
  List<Stats>? stats;

  Profile({this.name, this.bio, this.profilePic, this.stats});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bio = json['bio'];
    profilePic = json['profilePic'];
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(Stats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['bio'] = bio;
    data['profilePic'] = profilePic;
    if (stats != null) {
      data['stats'] = stats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stats {
  int? count;
  String? label;

  Stats({this.count, this.label});

  Stats.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['label'] = label;
    return data;
  }
}
