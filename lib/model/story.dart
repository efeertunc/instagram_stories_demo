class Story {
  String? profileUrl;
  String? userId;
  String? username;
  List<String>? stories;

  Story({this.profileUrl, this.stories});

  Story.fromJson(Map<String, dynamic> json) {
    profileUrl = json['profile_url'];
    userId = json['user_id'];
    username = json['username'];
    stories = json['stories'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_url'] = this.profileUrl;
    data['user_id'] = this.userId;
    data['stories'] = this.stories;
    data['username'] = this.username;
    return data;
  }
}
