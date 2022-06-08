import 'dart:convert';

import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String user;
  final String question;
  final String answer;
  const Question({
    required this.user,
    required this.question,
    required this.answer,
  });

  @override
  // TODO: implement props
  List<Object> get props => [user, question, answer];

  Question copyWith({
    String? user,
    String? question,
    String? answer,
  }) {
    return Question(
      user: user ?? this.user,
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user': user});
    result.addAll({'question': question});
    result.addAll({'answer': answer});

    return result;
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      user: map['user'] ?? '',
      question: map['question'] ?? '',
      answer: map['answer'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() =>
      'QuestionAndAnswer(user: $user, question: $question, answer: $answer)';
}
