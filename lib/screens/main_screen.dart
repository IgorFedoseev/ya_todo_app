import 'package:flutter/material.dart';
import 'package:ya_todo_list/theme/app_elements_color.dart';
import 'package:ya_todo_list/theme/app_text_styles.dart';
import '../model/task_manager.dart';
import '../provider/task_provider.dart';
import '../provider_widgets/task_item_provider_widget.dart';
import 'main_screen_componentes/completed_number_widget.dart';
import 'main_screen_componentes/new_task_tile_widget.dart';
import 'main_screen_componentes/offline_mode_widget.dart';
import 'main_screen_componentes/task_tile_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  late TaskManager? manager;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    manager = TaskProvider.getModel(context);
    manager?.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    final appBatTitleColor = TodoElementsColor.getLabelPrimaryColor(context);
    final appBarTitleStyle =
        AppTextStyles.appBarTextStyle.copyWith(color: appBatTitleColor);
    final appBarTitle = AppLocalizations.of(context)?.appbar_title ?? '';
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            backgroundColor: TodoElementsColor.getBackPrimaryColor(context),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(appBarTitle, style: appBarTitleStyle),
            ),
          ),
          const SliverToBoxAdapter(
            child: MainBodyWidget(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskItemScreenProviderWidget(
                onCreate: (item) {
                  manager?.addTask(item);
                  Navigator.pop(context);
                },
                onUpdate: (item) {},
                onDelete: () => Navigator.pop(context),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MainBodyWidget extends StatelessWidget {
  const MainBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final taskListColor = TodoElementsColor.getBackSecondaryColor(context);
    final manager = TaskProvider.of(context);
    final allTasks = manager?.allTasks ?? [];
    final isOffline = manager?.offlineMode ?? true;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isOffline) const OfflineModeInfoWidget(),
        const CompletedNumberWidget(),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 40.0),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: taskListColor,
              border: Border.all(color: taskListColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: allTasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskTile(
                      index: index,
                    );
                  },
                ),
                const NewTaskButtonTile(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
