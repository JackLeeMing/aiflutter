import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ColorScheme 颜色展示组件
/// 用于展示 Material Design 3 ColorScheme 中的所有基础颜色
/// 支持点击颜色块复制十六进制颜色代码
class ColorSchemeDisplayWidget extends StatelessWidget {
  final ColorScheme colorScheme;
  final String title;
  final VoidCallback? onColorCopied;

  const ColorSchemeDisplayWidget({
    super.key,
    required this.colorScheme,
    this.title = 'ColorScheme 总览',
    this.onColorCopied,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
            ),
            const SizedBox(height: 16),
            _buildColorSection('Primary', [
              _ColorInfo('primary', colorScheme.primary, colorScheme.onPrimary),
              _ColorInfo('onPrimary', colorScheme.onPrimary, colorScheme.primary),
              _ColorInfo('primaryContainer', colorScheme.primaryContainer, colorScheme.onPrimaryContainer),
              _ColorInfo('onPrimaryContainer', colorScheme.onPrimaryContainer, colorScheme.primaryContainer),
              _ColorInfo('primaryFixed', colorScheme.primaryFixed, colorScheme.onPrimaryFixed),
              _ColorInfo('onPrimaryFixed', colorScheme.onPrimaryFixed, colorScheme.primaryFixed),
              _ColorInfo('primaryFixedDim', colorScheme.primaryFixedDim, colorScheme.onPrimaryFixedVariant),
              _ColorInfo('onPrimaryFixedVariant', colorScheme.onPrimaryFixedVariant, colorScheme.primaryFixedDim),
            ]),
            const SizedBox(height: 16),
            _buildColorSection('Secondary', [
              _ColorInfo('secondary', colorScheme.secondary, colorScheme.onSecondary),
              _ColorInfo('onSecondary', colorScheme.onSecondary, colorScheme.secondary),
              _ColorInfo('secondaryContainer', colorScheme.secondaryContainer, colorScheme.onSecondaryContainer),
              _ColorInfo('onSecondaryContainer', colorScheme.onSecondaryContainer, colorScheme.secondaryContainer),
              _ColorInfo('secondaryFixed', colorScheme.secondaryFixed, colorScheme.onSecondaryFixed),
              _ColorInfo('onSecondaryFixed', colorScheme.onSecondaryFixed, colorScheme.secondaryFixed),
              _ColorInfo('secondaryFixedDim', colorScheme.secondaryFixedDim, colorScheme.onSecondaryFixedVariant),
              _ColorInfo('onSecondaryFixedVariant', colorScheme.onSecondaryFixedVariant, colorScheme.secondaryFixedDim),
            ]),
            const SizedBox(height: 16),
            _buildColorSection('Tertiary', [
              _ColorInfo('tertiary', colorScheme.tertiary, colorScheme.onTertiary),
              _ColorInfo('onTertiary', colorScheme.onTertiary, colorScheme.tertiary),
              _ColorInfo('tertiaryContainer', colorScheme.tertiaryContainer, colorScheme.onTertiaryContainer),
              _ColorInfo('onTertiaryContainer', colorScheme.onTertiaryContainer, colorScheme.tertiaryContainer),
              _ColorInfo('tertiaryFixed', colorScheme.tertiaryFixed, colorScheme.onTertiaryFixed),
              _ColorInfo('onTertiaryFixed', colorScheme.onTertiaryFixed, colorScheme.tertiaryFixed),
              _ColorInfo('tertiaryFixedDim', colorScheme.tertiaryFixedDim, colorScheme.onTertiaryFixedVariant),
              _ColorInfo('onTertiaryFixedVariant', colorScheme.onTertiaryFixedVariant, colorScheme.tertiaryFixedDim),
            ]),
            const SizedBox(height: 16),
            _buildColorSection('Surface', [
              _ColorInfo('surface', colorScheme.surface, colorScheme.onSurface),
              _ColorInfo('surfaceContainerLowest', colorScheme.surfaceContainerLowest, colorScheme.onSurface),
              _ColorInfo('surfaceContainerHighest', colorScheme.surfaceContainerHighest, colorScheme.onSurface),
              _ColorInfo('inverseSurface', colorScheme.inverseSurface, colorScheme.onInverseSurface),
              _ColorInfo('surfaceDim', colorScheme.surfaceDim, colorScheme.onSurface),
              _ColorInfo('surfaceContainerLow', colorScheme.surfaceContainerLow, colorScheme.onSurface),
              _ColorInfo('shadow', colorScheme.shadow, Colors.white),
              _ColorInfo('onInverseSurface', colorScheme.onInverseSurface, colorScheme.inverseSurface),
              _ColorInfo('onSurface', colorScheme.onSurface, colorScheme.surface),
              _ColorInfo('surfaceContainer', colorScheme.surfaceContainer, colorScheme.onSurface),
              _ColorInfo('scrim', colorScheme.scrim, Colors.white),
              _ColorInfo('outline', colorScheme.outline, colorScheme.surface),
              _ColorInfo('onSurfaceVariant', colorScheme.onSurfaceVariant, colorScheme.surface),
              _ColorInfo('surfaceContainerHigh', colorScheme.surfaceContainerHigh, colorScheme.onSurface),
              _ColorInfo('surfaceTint', colorScheme.surfaceTint, colorScheme.onSurface),
              _ColorInfo('outlineVariant', colorScheme.outlineVariant, colorScheme.onSurface),
              _ColorInfo('surfaceBright', colorScheme.surfaceBright, colorScheme.onSurface),
              _ColorInfo('inversePrimary', colorScheme.inversePrimary, colorScheme.onSurface),
            ]),
            const SizedBox(height: 16),
            _buildColorSection('Error', [
              _ColorInfo('error', colorScheme.error, colorScheme.onError),
              _ColorInfo('errorContainer', colorScheme.errorContainer, colorScheme.onErrorContainer),
              _ColorInfo('onError', colorScheme.onError, colorScheme.error),
              _ColorInfo('onErrorContainer', colorScheme.onErrorContainer, colorScheme.errorContainer),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSection(String sectionName, List<_ColorInfo> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              _getSectionIcon(sectionName),
              size: 20,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              sectionName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: colors.map((colorInfo) => _buildColorTile(colorInfo)).toList(),
        ),
      ],
    );
  }

  IconData _getSectionIcon(String sectionName) {
    switch (sectionName) {
      case 'Primary':
        return Icons.star;
      case 'Secondary':
        return Icons.flash_on;
      case 'Tertiary':
        return Icons.palette;
      case 'Surface':
        return Icons.layers;
      case 'Error':
        return Icons.error;
      default:
        return Icons.circle;
    }
  }

  Widget _buildColorTile(_ColorInfo colorInfo) {
    return GestureDetector(
      onTap: () => _copyColorToClipboard(colorInfo),
      child: Container(
        width: 200,
        height: 88,
        decoration: BoxDecoration(
          color: colorInfo.color,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              colorInfo.name,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: colorInfo.textColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              _colorToHex(colorInfo.color),
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                color: colorInfo.textColor.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _colorToHex(Color color) {
    return '#${(0xFF000000 | (color.r * 255).round() << 16 | (color.g * 255).round() << 8 | (color.b * 255).round()).toRadixString(16).substring(2).toUpperCase()}';
  }

  void _copyColorToClipboard(_ColorInfo colorInfo) {
    final hexColor = _colorToHex(colorInfo.color);
    Clipboard.setData(ClipboardData(text: hexColor));
    onColorCopied?.call();
  }
}

class _ColorInfo {
  final String name;
  final Color color;
  final Color textColor;

  _ColorInfo(this.name, this.color, this.textColor);
}
