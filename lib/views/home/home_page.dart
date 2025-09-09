import 'package:detect_hans/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showComingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const SelectableText(
          'Em breve',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const SelectableText(
          'Esta funcionalidade estará disponível em breve!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const SelectableText(
              'OK',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToStory(BuildContext context, String story) {
    Navigator.of(context).pushNamed('/story', arguments: story);
  }

  void _navigateToQuestionnaire(BuildContext context) {
    Navigator.of(context).pushNamed('/questionnaire');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth;
        double minWidth;
        if (isMobile) {
          maxWidth = size.width;
          minWidth = 0;
        } else {
          maxWidth = size.width * 0.5;
          if (maxWidth < 320) maxWidth = 320;
          minWidth = 320;
        }
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              minWidth: minWidth,
              minHeight: size.height,
              maxHeight: size.height,
            ),
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SizedBox.expand(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 0 : 16.0,
                            vertical: 8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ProfileHeader(),
                              const SizedBox(height: 12),
                              HighlightsBar(
                                onShowComingSoon: _showComingSoon,
                                onNavigateToStory: _navigateToStory,
                                onNavigateToQuestionnaire: _navigateToQuestionnaire,
                                isMobile: isMobile,
                              ),
                              const SizedBox(height: 16),
                              const FeedGrid(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, bottom: 8.0),
          child: SelectableText(
            'detect-hans',
            style: TextStyle(
              color: AppTheme.darkPurple,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: const AssetImage('assets/profilepic.png'),
                    backgroundColor: AppTheme.lightestPurple,
                  ),

                  // Stats
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatColumn(value: '2.352', label: 'casos no Maranhão'),
                        _StatColumn(value: '22.500', label: 'casos no Brasil'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Bio Section
              Padding(
                padding: const EdgeInsets.only(left: 4.0, top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SelectableText(
                      'Bacilo de Hansen',
                      style: TextStyle(
                        color: AppTheme.darkPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.hourglass_empty, color: AppTheme.darkPurple, size: 18),
                        SizedBox(width: 6),
                        Expanded(
                          child: SelectableText(
                            'Doença mais antiga do mundo',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.darkPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.emoji_objects, color: AppTheme.darkPurple, size: 18),
                        SizedBox(width: 6),
                        Expanded(
                          child: SelectableText(
                            'Também conhecida como "Lepra"',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.darkPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.location_on, color: AppTheme.darkPurple, size: 18),
                        SizedBox(width: 6),
                        Expanded(
                          child: SelectableText(
                            'Maranhão, BR',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.darkPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HighlightsBar extends StatelessWidget {
  final void Function(BuildContext) onShowComingSoon;
  final void Function(BuildContext, String) onNavigateToStory;
  final void Function(BuildContext) onNavigateToQuestionnaire;
  final bool isMobile;
  const HighlightsBar({
    super.key,
    required this.onShowComingSoon,
    required this.onNavigateToStory,
    required this.onNavigateToQuestionnaire,
    this.isMobile = true,
  });

  @override
  Widget build(BuildContext context) {
    final highlightButtons = [
      _HighlightButton(
        icon: Icons.assignment_rounded,
        label: 'Questionário',
        onTap: () => onNavigateToQuestionnaire(context),
      ),
      _HighlightButton(
        icon: Icons.info_rounded,
        label: 'Conceito',
        onTap: () => onNavigateToStory(context, 'conceito'),
      ),
      _HighlightButton(
        icon: Icons.sick_rounded,
        label: 'Sintomas',
        onTap: () => onNavigateToStory(context, 'sintomas'),
      ),
      _HighlightButton(
        icon: Icons.sync_alt_rounded,
        label: 'Transmissão',
        onTap: () => onNavigateToStory(context, 'transmissao'),
      ),
      _HighlightButton(
        icon: Icons.search_rounded,
        label: 'Diagnóstico',
        onTap: () => onNavigateToStory(context, 'diagnostico'),
      ),
      _HighlightButton(
        icon: Icons.healing_rounded,
        label: 'Tratamento',
        onTap: () => onNavigateToStory(context, 'tratamento'),
      ),
      _HighlightButton(
        icon: Icons.menu_book,
        label: 'Conhecer',
        onTap: () => onNavigateToStory(context, 'conhecer'),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: highlightButtons.length,
          itemExtent: 100,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: highlightButtons[index],
          ),
        ),
      ),
    );
  }
}

class FeedGrid extends StatelessWidget {
  const FeedGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(child: Image.asset('assets/feed.png', fit: BoxFit.fitHeight)),
          Positioned.fill(child: Image.asset('assets/grid.png', fit: BoxFit.fitHeight)),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String value;
  final String label;
  const _StatColumn({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SelectableText(
          value,
          style: const TextStyle(
            color: AppTheme.darkPurple,
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 2),
        SelectableText(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.darkPurple,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _HighlightButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _HighlightButton({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: AppTheme.lightestPurple,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.darkPurple, size: 26),
          ),
          const SizedBox(height: 4),
          SelectableText(
            label,
            style: const TextStyle(
              color: AppTheme.darkPurple,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
