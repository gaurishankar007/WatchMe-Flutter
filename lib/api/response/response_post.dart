import 'package:json_annotation/json_annotation.dart';

part 'response_post.g.dart';

@JsonSerializable()
class GetPost {
  @JsonKey(name: "_id")
  String? id;

  Map<String, String>? user_id;
  String? caption;
  String? description;
  List<String>? attach_file;
  List<Map<String, String>>? tag_friend;

  GetPost({this.id, this.user_id, this.caption, this.description, this.attach_file, this.tag_friend});

  factory GetPost.fromJson(Map<String, dynamic> json) =>
      _$GetPostFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostToJson(this);
}
