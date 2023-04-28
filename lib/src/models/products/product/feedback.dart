import 'dart:convert';

import 'package:equatable/equatable.dart';

class Feedback extends Equatable {
  final String user;
  final String comment;
  final String date;
  final double rating;

  final int likes;
  const Feedback({
    required this.user,
    required this.comment,
    required this.date,
    required this.rating,
    required this.likes,
  });

  @override
  List<Object> get props {
    return [
      user,
      comment,
      date,
      rating,
      likes,
    ];
  }

  Feedback copyWith({
    String? user,
    String? comment,
    String? date,
    double? rate,
    int? likes,
  }) {
    return Feedback(
      user: user ?? this.user,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      rating: rate ?? this.rating,
      likes: likes ?? this.likes,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user': user});
    result.addAll({'comment': comment});
    result.addAll({'date': date});
    result.addAll({'rate': rating});
    result.addAll({'likes': likes});

    return result;
  }

  factory Feedback.fromMap(Map<String, dynamic> map) {
    return Feedback(
      user: map['user'] ?? '',
      comment: map['comment'] ?? '',
      date: map['date'] ?? '',
      rating: map['rate']?.toDouble() ?? 0.0,
      likes: map['likes']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Feedback.fromJson(String source) =>
      Feedback.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Feedback(user: $user, comment: $comment, date: $date, rate: $rating, likes: $likes)';
  }
}
