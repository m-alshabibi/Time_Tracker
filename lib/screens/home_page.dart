import 'package:flutter/material.dart';
import 'package:time_tracker/screens/widgets/empty_widget.dart';
import 'package:provider/provider.dart';

import 'package:time_tracker/core/my_custom_tab_bar.dart';
import 'package:time_tracker/models/time_entry_model.dart';
import 'package:time_tracker/provider/project_task_provider.dart';
import 'package:time_tracker/screens/time_entry_screen.dart'
    show AddTimeEntryScreen;
import 'package:time_tracker/screens/widgets/reusable_dismissible_list.dart';
import 'package:time_tracker/screens/widgets/time_entry_card.dart';

import 'package:time_tracker/screens/widgets/app_drawer.dart'; // import the new AppDrawer

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isGroupedNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _isGroupedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Time Tracking'), centerTitle: true),
      drawer: const AppDrawer(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: MyCustomTabBar(
              controller: _tabController,
              onTap: (index) {
                _isGroupedNotifier.value = index == 1;
              },
              items: const ["All Entries", "Grouped by Projects"],
              backagroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          SliverFillRemaining(
            child: ValueListenableBuilder<bool>(
              valueListenable: _isGroupedNotifier,
              builder: (context, isGrouped, child) {
                return Consumer<TimeEntryProvider>(
                  builder: (context, provider, _) {
                    final entries = provider.entries.toList();
                    if (entries.isEmpty) {
                      return const Center(child: TimeEntryEmptyWidget());
                    }

                    return ReusableDismissibleList<TimeEntry>(
                      items: entries,
                      controller: _scrollController,
                      onDismissed: (item) {
                        try {
                          provider.deleteEntry(item.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Deleted Successfully')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Sorry, Try again')),
                          );
                        }
                      },
                      itemBuilder: (context, item) {
                        return TimeEntryCard(entry: item, isGrouped: isGrouped);
                      },
                      isDismissibleEnabled: !isGrouped,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTimeEntryScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
