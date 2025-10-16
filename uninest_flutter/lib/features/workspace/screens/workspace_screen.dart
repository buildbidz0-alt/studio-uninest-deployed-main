import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkspaceScreen extends ConsumerWidget {
  const WorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: theme.appBarTheme.backgroundColor,
            child: const TabBar(
              tabs: [
                Tab(text: 'Competitions'),
                Tab(text: 'Internships'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _CompetitionsTab(),
                _InternshipsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompetitionsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: List.generate(
        10,
        (index) => _OpportunityCard(
          title: 'Coding Competition ${index + 1}',
          organization: 'Tech Company ${index + 1}',
          deadline: 'Ends in ${7 + index} days',
          prize: '₹${(index + 1) * 10000}',
          type: 'Competition',
        ),
      ),
    );
  }
}

class _InternshipsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: List.generate(
        10,
        (index) => _OpportunityCard(
          title: 'Software Development Intern',
          organization: 'Company ${index + 1}',
          deadline: 'Apply by ${DateTime.now().add(Duration(days: 14 + index)).toString().split(' ')[0]}',
          prize: '₹${(index + 1) * 15000}/month',
          type: 'Internship',
        ),
      ),
    );
  }
}

class _OpportunityCard extends StatelessWidget {
  final String title;
  final String organization;
  final String deadline;
  final String prize;
  final String type;

  const _OpportunityCard({
    required this.title,
    required this.organization,
    required this.deadline,
    required this.prize,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompetition = type == 'Competition';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to details
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isCompetition
                          ? Colors.purple.shade100
                          : Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        color: isCompetition ? Colors.purple : Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.bookmark_border,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                organization,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    deadline,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.attach_money,
                    size: 16,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    prize,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('View Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
