import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mini_app/providers.dart';
import 'package:mini_app/components/textfield.dart';

class SearchAndSortBar extends ConsumerWidget {
  const SearchAndSortBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          // Search bar
          MyTextfield(
            controller: TextEditingController(),
            hintText: "Search notes...",
            obscuretext: false,
            prefixIcon: Icons.search,
            onChanged: (value) =>
                ref.read(searchProvider.notifier).state = value,
          ),

          const SizedBox(height: 16),

          // Sort buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _SortButton(
                  label: 'Recently Updated',
                  isSelected: ref.watch(sortByProvider) == 'updatedAt',
                  onPressed: () =>
                      ref.read(sortByProvider.notifier).state = 'updatedAt',
                  icon: Icons.update,
                ),
                const SizedBox(width: 8),
                _SortButton(
                  label: 'Recently Created',
                  isSelected: ref.watch(sortByProvider) == 'createdAt',
                  onPressed: () =>
                      ref.read(sortByProvider.notifier).state = 'createdAt',
                  icon: Icons.calendar_today,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;
  final IconData icon;

  const _SortButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}
