class ActivityLogModel {
  final String id;
  final String traceId;
  final DateTime timestamp;
  final String level;
  final String? userId;
  final String method;
  final String path;
  final int statusCode;
  final int elapsedMs;
  final String? error;

  const ActivityLogModel({
    required this.id,
    required this.traceId,
    required this.timestamp,
    required this.level,
    required this.method,
    required this.path,
    required this.statusCode,
    required this.elapsedMs,
    this.userId,
    this.error,
  });

  bool get isError => level.toLowerCase() == 'error';
  bool get isWarning => level.toLowerCase() == 'warning';

  String get levelLabel {
    if (isError) return 'Error';
    if (isWarning) return 'Advertencia';
    return 'Información';
  }

  /// dd/MM/yyyy HH:mm (hora local del dispositivo)
  String get formattedTimestamp {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(timestamp.day)}/${two(timestamp.month)}/${timestamp.year} '
        '${two(timestamp.hour)}:${two(timestamp.minute)}';
  }

  static ActivityLogModel fromJson(Map<String, dynamic> json) {
    return ActivityLogModel(
      id: json['id'] as String,
      traceId: json['traceId'] as String,
      timestamp: _parseUtc(json['timestamp'] as String),
      level: json['level'] as String,
      userId: json['userId'] as String?,
      method: json['method'] as String,
      path: json['path'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
      elapsedMs: (json['elapsedMs'] as num).toInt(),
      error: json['error'] as String?,
    );
  }

  // El API guarda las fechas en UTC. Si llegan sin "Z" se fuerzan a UTC
  // antes de convertirlas a la hora local del dispositivo.
  static DateTime _parseUtc(String value) {
    final parsed = DateTime.parse(value);
    return (parsed.isUtc ? parsed : DateTime.parse('${value}Z')).toLocal();
  }
}
