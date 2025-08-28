import 'package:flutter/material.dart';
import '../models/note.dart';

class StyledNoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;

  const StyledNoteCard({
    super.key,
    required this.note,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
                         colors: [
               theme.colorScheme.surface,
               theme.colorScheme.surface.withValues(alpha: 0.95),
             ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      note.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_outline,
                      color: theme.colorScheme.error,
                    ),
                    tooltip: 'Delete note',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                note.content,
                style: theme.textTheme.bodyMedium?.copyWith(
                                     color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: theme.colorScheme.primary.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    note.formattedTimestamp,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Note',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StyledContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const StyledContainer({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
                         color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
                     color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
                     colors: [
             theme.colorScheme.primary,
             theme.colorScheme.primary.withValues(alpha: 0.8),
           ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
                         color: theme.colorScheme.primary.withValues(alpha: 0.3),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: theme.colorScheme.onPrimary),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StyledTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLines;

  const StyledTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: theme.colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: theme.colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        labelStyle: TextStyle(
                     color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          fontFamily: 'Roboto',
        ),
        hintStyle: TextStyle(
                     color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          fontFamily: 'Roboto',
        ),
      ),
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurface,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class StyledText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const StyledText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Text(
      text,
      style: style ?? theme.textTheme.bodyMedium,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
