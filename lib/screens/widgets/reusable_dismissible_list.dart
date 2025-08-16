// lib/widgets/reusable_dismissible_list.dart
import 'package:flutter/material.dart';
import 'package:time_tracker/models/time_entry_model.dart';

// يجب أن تمد جميع النماذج التي تريد استخدامها مع هذه القائمة بـ UniqueId
// أو يمكنك تمرير دالة keyBuilder بدلاً من ذلك.

class ReusableDismissibleList<T extends TimeEntry> extends StatelessWidget {
  const ReusableDismissibleList({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onDismissed,
    this.controller,
    this.isDismissibleEnabled = true,
  });

  final List<T> items;
  final ScrollController? controller;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final void Function(T item) onDismissed;
  final bool isDismissibleEnabled;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: ValueKey(item.id), // استخدام ValueKey لتحسين الأداء
          direction: isDismissibleEnabled
              ? DismissDirection.endToStart
              : DismissDirection.none,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) => onDismissed(item),
          child: itemBuilder(context, item),
        );
      },
    );
  }
}
