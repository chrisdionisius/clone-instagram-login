class Post {
  int? id;
  String? name;
  String? profileImg;
  String? postImg;
  String? caption;
  bool? isLoved;
  String? commentCount;
  String? likedBy;
  String? timeAgo;

  Post(
      {this.id,
      this.name,
      this.profileImg,
      this.postImg,
      this.caption,
      this.isLoved,
      this.commentCount,
      this.likedBy,
      this.timeAgo});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImg = json['profileImg'];
    postImg = json['postImg'];
    caption = json['caption'];
    isLoved = json['isLoved'];
    commentCount = json['commentCount'];
    likedBy = json['likedBy'];
    timeAgo = json['timeAgo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['profileImg'] = profileImg;
    data['postImg'] = postImg;
    data['caption'] = caption;
    data['isLoved'] = isLoved;
    data['commentCount'] = commentCount;
    data['likedBy'] = likedBy;
    data['timeAgo'] = timeAgo;
    return data;
  }
}
