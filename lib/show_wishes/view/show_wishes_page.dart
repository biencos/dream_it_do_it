import 'package:dream_it_do_it/add_wish/add_wish.dart';
import 'package:dream_it_do_it/l10n/l10n.dart';
import 'package:dream_it_do_it/show_wishes/show_wishes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:wishes_repository/wishes_repository.dart';

class ShowWishesPage extends StatelessWidget {
  const ShowWishesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShowWishesBloc(wishesRepository: context.read<WishesRepository>())
            ..add(const WishesSubscriptionRequested()),
      child: const ShowWishesView(),
    );
  }
}

class ShowWishesView extends StatelessWidget {
  const ShowWishesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
        child: Column(
          children: [
            Expanded(
              child: _wishesListView(context),
            ),
          ],
        ),
      ),
      floatingActionButton: _floatingActionButton(context),
      resizeToAvoidBottomInset: false,
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    final l10n = context.l10n;

    return PreferredSize(
      preferredSize: Size.fromHeight(15.h),
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 6.h,
          ),
          child: Row(
            children: [
              Text(
                l10n.showWishesAppBarTitle,
                style: Theme.of(context).textTheme.headline6,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _wishesListView(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<ShowWishesBloc, ShowWishesState>(
      builder: (context, state) {
        if (state.wishes.isEmpty) {
          if (state.status == ShowWishesStatus.loading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state.status != ShowWishesStatus.success) {
            return const SizedBox();
          } else {
            return Center(
              child: Text(
                l10n.showWishesNoWishesText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }
        }

        final wishes = state.wishes.toList();
        return CupertinoScrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: wishes.length,
            itemBuilder: (context, i) {
              final wish = wishes[i];
              return Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: WishesListElement(
                  wish: wish,
                  onToggleCompleted: (isCompleted) {
                    context.read<ShowWishesBloc>().add(
                          WishCompletionToggled(
                            wish: wish,
                            isCompleted: isCompleted,
                          ),
                        );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black,
      child: Icon(
        Icons.add_rounded,
        size: 8.w,
        color: Theme.of(context).colorScheme.secondary,
      ),
      onPressed: () {
        final borderRadius = 3.h;

        showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
          ),
          builder: (builder) {
            return const AddWishPage();
          },
        );
      },
    );
  }
}
