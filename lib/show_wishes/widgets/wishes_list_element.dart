import 'package:flutter/material.dart';
import 'package:wishes_repository/wishes_repository.dart';

class WishesListElement extends StatelessWidget {
  const WishesListElement({
    super.key,
    required this.wish,
  });

  final Wish wish;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _wishText(context),
    );
  }

  Widget _wishText(BuildContext context) {
    return Text(
      wish.title,
      style: !wish.isCompleted
          ? Theme.of(context).textTheme.bodyMedium
          : const TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
    );
  }
}
