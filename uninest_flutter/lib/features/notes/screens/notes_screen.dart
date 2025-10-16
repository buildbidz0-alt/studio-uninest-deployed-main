import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Filter chips
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _SubjectChip(label: 'All Subjects'),
                  _SubjectChip(label: 'Mathematics'),
                  _SubjectChip(label: 'Physics'),
                  _SubjectChip(label: 'Chemistry'),
                  _SubjectChip(label: 'Biology'),
                  _SubjectChip(label: 'Computer Science'),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Notes list
            ...List.generate(
              15,
              (index) => _NoteCard(
                title: 'Lecture Notes ${index + 1}',
                subject: ['Mathematics', 'Physics', 'Chemistry'][index % 3],
                author: 'Student ${index + 1}',
                downloads: 45 + index * 5,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to upload notes
        },
        icon: const Icon(Icons.upload_file),
        label: const Text('Upload Notes'),
      ),
    );
  }
}

class _SubjectChip extends StatelessWidget {
  final String label;

  const _SubjectChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: label == 'All Subjects',
        onSelected: (selected) {},
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final String title;
  final String subject;
  final String author;
  final int downloads;

  const _NoteCard({
    required this.title,
    required this.subject,
    required this.author,
    required this.downloads,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.description,
            color: theme.colorScheme.primary,
          ),
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(subject),
            const SizedBox(height: 2),
            Text('By $author • $downloads downloads'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.download),
          onPressed: () {},
        ),
        onTap: () {
          // TODO: Navigate to note details
        },
      ),
    );
  }
}
