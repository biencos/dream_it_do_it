import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:dream_it_do_it/l10n/l10n.dart';
import 'package:dream_it_do_it/show_wishes/show_wishes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class WishesFilterButton extends StatelessWidget {
  const WishesFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Material(
      borderRadius: BorderRadius.circular(5.h),
      elevation: 1.w,
      child: CustomSlidingSegmentedControl<WishesViewFilter>(
        children: {
          WishesViewFilter.activeOnly: _WishesFilterButtonTile(
            title: l10n.showWishesAppBarToDoToggleTitle,
          ),
          WishesViewFilter.completedOnly: _WishesFilterButtonTile(
            title: l10n.showWishesAppBarDoneToggleTitle,
            filter: WishesViewFilter.completedOnly,
          ),
        },
        initialValue: WishesViewFilter.activeOnly,
        decoration: BoxDecoration(
          color: const Color(0xFF1f1f1f),
          borderRadius: BorderRadius.circular(5.h),
        ),
        thumbDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5.h),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInToLinear,
        padding: 4.w,
        onValueChanged: (WishesViewFilter filter) {
          context.read<ShowWishesBloc>().add(WishesFilterChanged(filter));
        },
      ),
    );
  }
}

class _WishesFilterButtonTile extends StatelessWidget {
  const _WishesFilterButtonTile({
    required this.title,
    this.filter = WishesViewFilter.activeOnly,
  });

  final String title;
  final WishesViewFilter filter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowWishesBloc, ShowWishesState>(
      builder: (context, state) {
        return Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: state.filter == filter ? Colors.black : Colors.white,
              ),
        );
      },
    );
  }
}
