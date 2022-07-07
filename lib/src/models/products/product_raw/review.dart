import 'dart:convert';

import 'package:equatable/equatable.dart';

class Review extends Equatable {
  int id;
  String user;
  String comment;
  int product;
  
  Review({
    required this.id,
    required this.user,
    required this.comment,
    required this.product,
  });

  Review copyWith({
    int? id,
    String? user,
    String? comment,
    int? product,
  }) {
    return Review(
      id: id ?? this.id,
      user: user ?? this.user,
      comment: comment ?? this.comment,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'user': user});
    result.addAll({'comment': comment});
    result.addAll({'product': product});
  
    return result;
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id']?.toInt() ?? 0,
      user: map['user'] ?? '',
      comment: map['comment'] ?? '',
      product: map['product']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Review(id: $id, user: $user, comment: $comment, product: $product)';
  }

  @override
  List<Object> get props => [id, user, comment, product];
}
