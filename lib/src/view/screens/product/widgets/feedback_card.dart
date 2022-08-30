import 'package:flutter/widgets.dart';
import 'package:trendyol_market/src/models/products/product/feedback.dart';

import 'package:trendyol_market/src/view/constants/colors.dart';


import '../../../components/rating_bar.dart';

class FeedbackCard extends StatelessWidget {
  const FeedbackCard({
    Key? key,
    required this.feedback,
  }) : super(key: key);

  final Feedback feedback;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              feedback.user,
              style: const TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 20),
            RatingBar(
              currentRating: feedback.rating.floor(),
              maxRating: 5,
              filledColor: kSecondaryColor,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          feedback.date,
          style: const TextStyle(
            color: Color(0xFFAFAFAF),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          feedback.comment,
          style: const TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
