import 'package:flutter/material.dart';
import '../../core/client.dart';
import '../../core/constants.dart';
import '../../core/localization_helper.dart';
import '../list_controller.dart';

class QuickTemplateItem {
  final String title;
  final String description;
  final int color;
  final IconData icon;
  final List<String> defaultTasks;

  const QuickTemplateItem({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.defaultTasks,
  });
}

class QuickTemplatesView extends StatelessWidget {
  final ListController listController;
  final bool isCompact;

  const QuickTemplatesView({
    super.key,
    required this.listController,
    this.isCompact = false,
  });

  static const List<QuickTemplateItem> templatesDe = [
    QuickTemplateItem(
      title: '🛒 Wocheneinkauf & Vorräte',
      description: 'Schnelle Liste für Supermarkt, Frischeartikel & Snacks',
      color: 0xFF10B981,
      icon: Icons.shopping_basket_outlined,
      defaultTasks: [
        '🥦 Frisches Gemüse & Obst',
        '🥛 Hafermilch & Butter',
        '🍞 Vollkornbrot & Aufstrich',
        '☕ Kaffeebohnen',
      ],
    ),
    QuickTemplateItem(
      title: '🚀 Projekt-Sprint & Roadmap',
      description: 'Ziele definieren, Meilensteine planen & im Team umsetzen',
      color: 0xFF6366F1,
      icon: Icons.rocket_launch_outlined,
      defaultTasks: [
        '🎯 Sprint-Ziele abstimmen',
        '📋 Backlog prüfen & Prioritäten setzen',
        '💻 MVP Features implementieren',
        '🔍 QA Testing & Feedback-Runde',
      ],
    ),
    QuickTemplateItem(
      title: '💡 Brainstorming & Ideen',
      description: 'Spontane Gedanken, Konzepte & Entwürfe sammeln',
      color: 0xFFF59E0B,
      icon: Icons.lightbulb_outline_rounded,
      defaultTasks: [
        '✨ Kernidee formulieren',
        '📊 Zielgruppe & Mehrwert analysieren',
        '🎨 Erste UI-Skizzen entwerfen',
      ],
    ),
    QuickTemplateItem(
      title: '📚 Lern- & Studienplan',
      description: 'Prüfungsvorbereitung, Kapitel & Lernblöcke strukturieren',
      color: 0xFF0284C7,
      icon: Icons.school_outlined,
      defaultTasks: [
        '📖 Kapitel 1-3 zusammenfassen',
        '📝 Karteikarten für Fachbegriffe erstellen',
        '⏱️ 2x 45 Min Pomodoro Lerneinheit',
      ],
    ),
  ];

  static const List<QuickTemplateItem> templatesEn = [
    QuickTemplateItem(
      title: '🛒 Weekly Groceries',
      description: 'Quick list for supermarket, fresh produce & snacks',
      color: 0xFF10B981,
      icon: Icons.shopping_basket_outlined,
      defaultTasks: [
        '🥦 Fresh Vegetables & Fruit',
        '🥛 Oat Milk & Butter',
        '🍞 Whole Wheat Bread',
        '☕ Coffee Beans',
      ],
    ),
    QuickTemplateItem(
      title: '🚀 Project Sprint & Roadmap',
      description: 'Define goals, plan milestones & execute with team',
      color: 0xFF6366F1,
      icon: Icons.rocket_launch_outlined,
      defaultTasks: [
        '🎯 Align on sprint goals',
        '📋 Refine backlog & prioritize',
        '💻 Implement MVP features',
        '🔍 QA testing & feedback review',
      ],
    ),
    QuickTemplateItem(
      title: '💡 Brainstorming & Ideas',
      description: 'Capture thoughts, concepts & drafts quickly',
      color: 0xFFF59E0B,
      icon: Icons.lightbulb_outline_rounded,
      defaultTasks: [
        '✨ Draft core proposition',
        '📊 Identify target group & value',
        '🎨 Sketch initial UI mockups',
      ],
    ),
    QuickTemplateItem(
      title: '📚 Study & Learning Plan',
      description: 'Exam prep, textbook chapters & learning sessions',
      color: 0xFF0284C7,
      icon: Icons.school_outlined,
      defaultTasks: [
        '📖 Summarize Chapters 1-3',
        '📝 Flashcards for terminology',
        '⏱️ 2x 45 min Pomodoro study block',
      ],
    ),
  ];

  List<QuickTemplateItem> _getTemplates(BuildContext context) =>
      context.isEn ? templatesEn : templatesDe;


  Future<void> _applyTemplate(
    BuildContext context,
    QuickTemplateItem template,
  ) async {
    try {
      final newList = await listController.createList(
        title: template.title,
        description: template.description,
        color: template.color,
      );

      if (newList != null && newList.id != null) {
        // Add default tasks
        for (final task in template.defaultTasks) {
          try {
            await client.todoItem.createItem(
              listId: newList.id!,
              title: task,
              priority: TodoPriority.medium,
            );
          } catch (_) {}
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Vorlage „${template.title}“ erfolgreich erstellt! 🎉',
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFF10B981),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Erstellen der Vorlage: $e'),
            backgroundColor: AppColors.priorityHigh,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight(context);
    final currentTemplates = _getTemplates(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  size: 16,
                  color: Color(0xFF6366F1),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                context.isEn ? 'Quick-Start Templates' : 'Schnellstart-Vorlagen',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text(context),
                  letterSpacing: -0.3,
                ),
              ),
              const Spacer(),
              Text(
                context.isEn ? '1-Click Launch' : '1-Klick Start',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary(context),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: currentTemplates.length,
            separatorBuilder: (context, index) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final template = currentTemplates[index];
              final tColor = Color(template.color);

              return InkWell(
                onTap: () => _applyTemplate(context, template),
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg(context),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isLight
                          ? AppColors.borderSubtle(context)
                          : tColor.withValues(alpha: 0.3),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: tColor.withValues(alpha: isLight ? 0.06 : 0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: tColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(template.icon, size: 16, color: tColor),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.add_circle_outline_rounded,
                            size: 18,
                            color: tColor,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            template.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text(context),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            template.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
