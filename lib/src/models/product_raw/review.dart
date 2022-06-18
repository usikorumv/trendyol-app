import 'package:equatable/equatable.dart';

class Review extends Equatable {
  Review({
    required this.id,
    required this.user,
    required this.comment,
    required this.product,
  });

  int id;
  String user;
  String comment;
  int product;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        user: json["user"],
        comment: json["comment"],
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "comment": comment,
        "product": product,
      };

  @override
  List<Object?> get props => [id, user, product];
}
