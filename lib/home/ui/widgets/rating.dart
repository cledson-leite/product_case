import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final int rating;
  const Rating(
    this.rating, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _star(context, 1),
        _star(context, 2),
        _star(context, 3),
        _star(context, 4),
        _star(context, 5),
      ],
    );
  }

  Visibility _star(BuildContext context, int position) {
    return Visibility(
        visible: rating < position,
        replacement: Icon(
          Icons.star,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Icon(
          Icons.star_outline,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
  }
}
