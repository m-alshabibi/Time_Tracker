import 'package:flutter/material.dart';
import 'package:time_tracker/models/managed_entity.dart';

class ManagementItem<T extends ManagedEntity> extends StatelessWidget {
  const ManagementItem({super.key, required this.item});

  final T item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(
                Icons.delete_forever,
                size: 30,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class HasName {
  String get name;
}
