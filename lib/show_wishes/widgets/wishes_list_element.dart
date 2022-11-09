import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:wishes_repository/wishes_repository.dart';

class WishesListElement extends StatelessWidget {
  const WishesListElement({
    super.key,
    required this.wish,
    this.onToggleCompleted,
    this.onDismissed,
  });

  final Wish wish;
  final ValueChanged<bool>? onToggleCompleted;
  final DismissDirectionCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Dismissible(
        key: Key('wishesListElement_dismissible_${wish.id}'),
        onDismissed: onDismissed,
        direction: DismissDirection.endToStart,
        background: _dismissableBackground(),
        child: Row(
          children: [
            _checkbox(context),
            Padding(
              padding: EdgeInsets.only(left: 1.w),
              child: _wishText(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkbox(BuildContext context) {
    return SizedBox(
      width: 10.w,
      height: 10.w,
      child: Checkbox(
        activeColor: Colors.black,
        checkColor: Theme.of(context).colorScheme.secondary,
        value: wish.isCompleted,
        onChanged: onToggleCompleted == null
            ? null
            : (value) => onToggleCompleted!(value!),
        shape: const CircleBorder(),
      ),
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

  Widget _dismissableBackground() {
    return Container(
      alignment: Alignment.centerRight,
      color: const Color.fromARGB(255, 134, 9, 0),
      padding: EdgeInsets.symmetric(
        vertical: 1.h,
        horizontal: 2.w,
      ),
      child: const Icon(
        Icons.delete_rounded,
        color: Colors.white,
      ),
    );
  }
}
