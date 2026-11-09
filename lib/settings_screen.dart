import 'package:flutter/material.dart';
import 'sound_service.dart';
import 'store.dart';
import 'theme.dart';

/// شاشة الإعدادات: الصوت والاهتزاز والمظهر.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppStore.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) => ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            const _SectionTitle('التنبيهات'),
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const _TileIcon(Icons.volume_up_rounded),
                    title: const Text('الصوت'),
                    subtitle: const Text('صفير العدّ الأخير ونغمات البداية والنهاية'),
                    value: store.soundEnabled,
                    onChanged: store.setSoundEnabled,
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const _TileIcon(Icons.vibration_rounded),
                    title: const Text('الاهتزاز'),
                    subtitle: const Text('نبضة مع كل تنبيه'),
                    value: store.vibrationEnabled,
                    onChanged: store.setVibrationEnabled,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const _TileIcon(Icons.play_circle_outline_rounded),
                    title: const Text('تجربة التنبيه'),
                    subtitle: const Text('يتبع صوت الوسائط في جهازك'),
                    onTap: () => SoundService.instance.preview(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const _SectionTitle('المظهر'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<ThemeMode>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: Text('تلقائي'),
                        icon: Icon(Icons.brightness_auto_rounded),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: Text('فاتح'),
                        icon: Icon(Icons.light_mode_rounded),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: Text('داكن'),
                        icon: Icon(Icons.dark_mode_rounded),
                      ),
                    ],
                    selected: {store.themeMode},
                    onSelectionChanged: (s) => store.setThemeMode(s.first),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'عداد التمرين  •  الإصدار 1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
      ),
    );
  }
}

class _TileIcon extends StatelessWidget {
  const _TileIcon(this.icon);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.14),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppTheme.primary, size: 22),
    );
  }
}
