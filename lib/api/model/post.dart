import 'dart:io';

class AddPost {
  String? caption;
  String? description;
  List<File>? images;
  List<String>? taggedFriend;

  AddPost({this.caption, this.description, this.images, this.taggedFriend});
}
