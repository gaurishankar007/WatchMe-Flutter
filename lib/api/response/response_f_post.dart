import 'package:assignment/api/response/response_post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_f_post.g.dart';

@JsonSerializable(explicitToJson: true)
class GetFollowedPosts {
  final List<GetPost> followedPosts;

  GetFollowedPosts({required this.followedPosts});

  factory GetFollowedPosts.fromJson(Map<String, dynamic> json) =>
      _$GetFollowedPostsFromJson(json);

  Map<String, dynamic> toJson() => _$GetFollowedPostsToJson(this);
}
