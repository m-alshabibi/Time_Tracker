// lib/widgets/reusable_dropdown.dart
import 'package:flutter/material.dart';
import 'package:time_tracker/models/managed_entity.dart';
import 'package:provider/provider.dart';

class ReusableDropdown<T extends ManagedEntity, P extends ChangeNotifier>
    extends StatelessWidget {
  const ReusableDropdown({
    super.key,
    required this.labelText,
    required this.onChanged,
  });

  final String labelText;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Consumer<P>(
      builder: (context, provider, _) {
        final List<T> items = (provider as dynamic).items;

        if (items.isEmpty) {
          return const SizedBox.shrink();
        }

        return DropdownButtonFormField<String>(
          value: items.first.id,
          decoration: InputDecoration(labelText: labelText),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((T item) {
            return DropdownMenuItem<String>(
              value: item.id,
              child: Text(item.name),
            );
          }).toList(),
        );
      },
    );
  }
}
