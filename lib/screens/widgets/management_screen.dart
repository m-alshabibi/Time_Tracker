import 'package:flutter/material.dart';

// يمكن أن يكون هذا في ملف منفصل
typedef ItemBuilder<T> = Widget Function(BuildContext context, T item);

class ManagementScreen<T> extends StatelessWidget {
  const ManagementScreen({
    super.key,
    required this.title,
    required this.dataList,
    required this.onDismissed,
    required this.onAddPressed,
    required this.itemBuilder,
  });

  final String title;
  final List<T> dataList;
  final Function(T item) onDismissed;
  final VoidCallback onAddPressed;
  final ItemBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          final item = dataList[index];
          // يجب أن يكون العنصر يحتوي على خاصية `id` للتعامل مع Dismissible
          // يمكنك استخدام واجهة مشتركة أو تمرير keyBuilder
          final dynamic typedItem = item;
          final String itemId = typedItem.id.toString();

          return Dismissible(
            key: Key(itemId),
            direction: DismissDirection.endToStart,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddPressed,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
