import 'package:dream_it_do_it/add_wish/add_wish.dart';
import 'package:dream_it_do_it/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:wishes_repository/wishes_repository.dart';

class AddWishPage extends StatelessWidget {
  const AddWishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddWishBloc(
        wishesRepository: context.read<WishesRepository>(),
      ),
      child: BlocListener<AddWishBloc, AddWishState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == AddWishStatus.success,
        listener: (context, state) => Navigator.of(context).pop(),
        child: const AddWishView(),
      ),
    );
  }
}

class AddWishView extends StatelessWidget {
  const AddWishView({super.key});

  @override
  Widget build(BuildContext context) {
    final borderRadius = 3.h;

    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(
          top: 2.h,
          left: 7.w,
          right: 5.w,
          bottom: MediaQuery.of(context).viewInsets.bottom == 0
              ? 50.h
              : MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(
                  child: _WishTitleField(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: const _ConfirmIconButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WishTitleField extends StatelessWidget {
  const _WishTitleField();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddWishBloc>().state;

    return TextFormField(
      key: const Key('addWishView_title_textFormField'),
      initialValue: state.title,
      onChanged: (value) {
        context.read<AddWishBloc>().add(AddWishTitleChanged(value));
      },
      onFieldSubmitted: (String v) {
        final isConfirmDisabled = state.title.isEmpty ||
            state.status == AddWishStatus.loading ||
            state.status == AddWishStatus.success;
        if (!isConfirmDisabled) {
          context.read<AddWishBloc>().add(const AddWishSubmitted());
        }
      },
      autofocus: true,
      keyboardType: TextInputType.name,
      cursorColor: Theme.of(context).colorScheme.secondary,
      decoration: InputDecoration(
        enabled: state.status == AddWishStatus.initial ||
            state.status == AddWishStatus.failure,
        hintText: context.l10n.addWishTitleFieldHelperText,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(),
        focusedBorder: const UnderlineInputBorder(),
      ),
    );
  }
}

class _ConfirmIconButton extends StatelessWidget {
  const _ConfirmIconButton();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddWishBloc>().state;
    final isDisabled = state.title.isEmpty ||
        state.status == AddWishStatus.loading ||
        state.status == AddWishStatus.success;
    return GestureDetector(
      key: const Key('addWishView_confirm_GestureDetector'),
      onTap: () {
        if (!isDisabled) {
          context.read<AddWishBloc>().add(const AddWishSubmitted());
        }
      },
      child: Icon(
        Icons.send_rounded,
        color:
            isDisabled ? Colors.grey : Theme.of(context).colorScheme.secondary,
        size: 7.w,
      ),
    );
  }
}
