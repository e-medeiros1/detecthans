import 'package:detect_hans/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  final Map<String, bool> _selectedSymptoms = {};
  bool _isEvaluating = false;

  final List<Map<String, dynamic>> _symptoms = [
    {
      'id': 'manchas',
      'title': 'Manchas na pele',
      'description': 'Manchas claras, avermelhadas ou escuras que não doem, não coçam e não suam',
      'severity': 'high',
    },
    {
      'id': 'formigamento',
      'title': 'Formigamento ou dormência',
      'description': 'Sensação de formigamento, agulhadas ou dormência nas extremidades (mãos e pés)',
      'severity': 'high',
    },
    {
      'id': 'parestesia',
      'title': 'Sensações anormais',
      'description': 'Sensação de choque, "picadas" ou queimação na pele',
      'severity': 'high',
    },
    {
      'id': 'dor_nervos',
      'title': 'Dor nos nervos',
      'description': 'Dor ou inchaço nos nervos dos braços, cotovelos e pernas',
      'severity': 'high',
    },
    {
      'id': 'nervos_engrossados',
      'title': 'Nervos engrossados',
      'description': 'Nervos periféricos engrossados e doloridos ao toque',
      'severity': 'high',
    },
    {
      'id': 'pelos',
      'title': 'Alteração nos pelos',
      'description': 'Diminuição ou ausência de pelos em algumas áreas do corpo',
      'severity': 'medium',
    },
    {
      'id': 'problemas_oculares',
      'title': 'Problemas oculares',
      'description': 'Dificuldade para fechar os olhos, visão embaçada ou ressecamento',
      'severity': 'medium',
    },
    {
      'id': 'problemas_nasais',
      'title': 'Problemas nasais',
      'description': 'Obstrução nasal crônica (nariz entupido) ou sangramento nasal',
      'severity': 'medium',
    },
    {
      'id': 'fraqueza_muscular',
      'title': 'Fraqueza muscular',
      'description': 'Fraqueza ou paralisia em mãos, pés ou pálpebras',
      'severity': 'high',
    },
    {
      'id': 'feridas_nao_cicatrizam',
      'title': 'Feridas que não cicatrizam',
      'description': 'Feridas ou úlceras que demoram para cicatrizar, especialmente nas extremidades',
      'severity': 'medium',
    },
    {
      'id': 'alteracao_sensibilidade',
      'title': 'Alteração na sensibilidade',
      'description': 'Diminuição da sensibilidade ao calor, frio ou dor em áreas específicas',
      'severity': 'high',
    },
    {
      'id': 'nodulos_pele',
      'title': 'Nódulos na pele',
      'description': 'Nódulos ou caroços na pele que podem ser dolorosos',
      'severity': 'medium',
    },
  ];

  void _toggleSymptom(String symptomId) {
    setState(() {
      _selectedSymptoms[symptomId] = !(_selectedSymptoms[symptomId] ?? false);
    });
  }

  void _evaluateSymptoms() {
    setState(() {
      _isEvaluating = true;
    });

    // Simulate evaluation delay for better UX
    Future.delayed(const Duration(milliseconds: 500), () {
      _showResult();
    });
  }

  void _showResult() {
    final selectedSymptomIds = _selectedSymptoms.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    final result = _calculateResult(selectedSymptomIds);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              result['icon'],
              color: result['color'],
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                result['title'],
                style: TextStyle(
                  color: result['color'],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                result['message'],
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              if (result['recommendations'] != null) ...[
                const SizedBox(height: 16),
                const Text(
                  'Recomendações:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ...result['recommendations'].map<Widget>((rec) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                          Expanded(child: Text(rec)),
                        ],
                      ),
                    )),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetForm();
            },
            child: const Text(
              'Entendi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if (result['severity'] == 'high' || result['severity'] == 'medium')
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showHealthCenterInfo();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Encontrar UBS',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  void _showHealthCenterInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.location_on, color: AppTheme.primaryColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Unidade Básica de Saúde',
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.left,
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Para um diagnóstico preciso, procure a UBS mais próxima:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '• Diagnóstico gratuito\n• Teste dermatoneurológico\n• Tratamento completo\n• Acompanhamento médico',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
            SizedBox(height: 12),
            Text(
              'Ligue 136 para informações sobre UBS próximas.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resetForm();
            },
            child: const Text(
              'OK',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _selectedSymptoms.clear();
      _isEvaluating = false;
    });
  }

  Map<String, dynamic> _calculateResult(List<String> selectedSymptomIds) {
    if (selectedSymptomIds.isEmpty) {
      return {
        'title': 'Nenhum sintoma selecionado',
        'message': 'Você não selecionou nenhum sintoma. Continue monitorando sua saúde e procure um médico se apresentar algum dos sintomas listados.',
        'icon': Icons.check_circle,
        'color': AppTheme.successColor,
        'severity': 'low',
        'recommendations': [
          'Mantenha hábitos saudáveis',
          'Observe mudanças na pele',
          'Procure um médico se surgirem sintomas',
        ],
      };
    }

    // High priority symptoms
    final highPrioritySymptoms = ['manchas', 'formigamento', 'parestesia', 'dor_nervos', 'nervos_engrossados', 'fraqueza_muscular', 'alteracao_sensibilidade'];
    final hasHighPriority = selectedSymptomIds.any((id) => highPrioritySymptoms.contains(id));

    // Count symptoms by severity
    int highSeverityCount = 0;

    for (String id in selectedSymptomIds) {
      final symptom = _symptoms.firstWhere((s) => s['id'] == id);
      if (symptom['severity'] == 'high') {
        highSeverityCount++;
      }
    }

    // Decision tree logic
    if (selectedSymptomIds.contains('manchas')) {
      return {
        'title': 'ATENÇÃO: Possível Hanseníase',
        'message': 'A presença de manchas dormentes é um dos principais sinais de hanseníase. Este é um sintoma muito característico da doença e requer avaliação médica imediata.',
        'icon': Icons.warning,
        'color': AppTheme.errorColor,
        'severity': 'high',
        'recommendations': [
          'Procure IMEDIATAMENTE uma UBS',
          'Não espere os sintomas piorarem',
          'O diagnóstico precoce é fundamental',
          'O tratamento é gratuito e eficaz',
        ],
      };
    }

    if (highSeverityCount >= 2) {
      return {
        'title': 'ATENÇÃO: Múltiplos Sintomas',
        'message': 'Você apresenta múltiplos sintomas que podem estar relacionados à hanseníase. A combinação de sintomas neurológicos e cutâneos sugere a necessidade de investigação médica urgente.',
        'icon': Icons.warning,
        'color': AppTheme.errorColor,
        'severity': 'high',
        'recommendations': [
          'Procure uma UBS o mais rápido possível',
          'Não ignore os sintomas',
          'O diagnóstico precoce previne complicações',
          'O tratamento é gratuito no SUS',
        ],
      };
    }

    if (hasHighPriority || selectedSymptomIds.length >= 3) {
      return {
        'title': 'Recomendação: Procure um Médico',
        'message': 'Você apresenta sintomas que podem estar relacionados à hanseníase. É importante procurar um profissional de saúde para uma avaliação adequada e diagnóstico correto.',
        'icon': Icons.info,
        'color': AppTheme.accentColor,
        'severity': 'medium',
        'recommendations': [
          'Agende uma consulta na UBS mais próxima',
          'Descreva todos os sintomas ao médico',
          'Não se automedique',
          'O diagnóstico é feito por exame clínico',
        ],
      };
    }

    if (selectedSymptomIds.length >= 2) {
      return {
        'title': 'Observe os Sintomas',
        'message': 'Você apresenta alguns sintomas que merecem atenção. Embora não sejam suficientes para um diagnóstico, é prudente conversar com um médico para esclarecer suas dúvidas.',
        'icon': Icons.visibility,
        'color': AppTheme.accentColor,
        'severity': 'medium',
        'recommendations': [
          'Monitore a evolução dos sintomas',
          'Procure um médico se piorarem',
          'Mantenha hábitos saudáveis',
          'Não hesite em buscar ajuda médica',
        ],
      };
    }

    // Single symptom
    return {
      'title': 'Sintoma Isolado',
      'message': 'Você apresenta um sintoma isolado. Embora não seja suficiente para um diagnóstico, é sempre prudente conversar com um médico em uma UBS para esclarecer suas dúvidas.',
      'icon': Icons.help_outline,
      'color': AppTheme.secondaryColor,
      'severity': 'low',
      'recommendations': [
        'Observe se o sintoma persiste',
        'Procure um médico se houver dúvidas',
        'Mantenha hábitos saudáveis',
        'Não se preocupe excessivamente',
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Autoavaliação de Sintomas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.darkPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppTheme.darkPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.assignment_rounded,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Selecione os sintomas que você apresenta:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '${_selectedSymptoms.values.where((v) => v).length} de ${_symptoms.length} sintomas selecionados',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Symptoms list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _symptoms.length,
              itemBuilder: (context, index) {
                final symptom = _symptoms[index];
                final isSelected = _selectedSymptoms[symptom['id']] ?? false;
                final severity = symptom['severity'] as String;
                
                Color severityColor;
                IconData severityIcon;
                
                switch (severity) {
                  case 'high':
                    severityColor = AppTheme.errorColor;
                    severityIcon = Icons.priority_high;
                    break;
                  case 'medium':
                    severityColor = AppTheme.accentColor;
                    severityIcon = Icons.info;
                    break;
                  default:
                    severityColor = AppTheme.secondaryColor;
                    severityIcon = Icons.help_outline;
                }

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: isSelected ? 4 : 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isSelected ? AppTheme.darkPurple : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => _toggleSymptom(symptom['id']),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: (_) => _toggleSymptom(symptom['id']),
                            activeColor: AppTheme.darkPurple,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        symptom['title'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? AppTheme.darkPurple : Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      severityIcon,
                                      color: severityColor,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  symptom['description'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Evaluate button
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isEvaluating ? null : _evaluateSymptoms,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.darkPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: _isEvaluating
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Avaliando...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        'Avaliar Sintomas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
