import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TestimonialCard extends StatelessWidget {
  final String quote;
  final String name;
  final String school;
  final String? avatarUrl;

  const TestimonialCard({
    super.key,
    required this.quote,
    required this.name,
    required this.school,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
              backgroundImage: avatarUrl != null
                  ? CachedNetworkImageProvider(avatarUrl!)
                  : null,
              child: avatarUrl == null
                  ? Text(
                      name[0],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            Flexible(
              child: Text(
                '"$quote"',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              school,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
