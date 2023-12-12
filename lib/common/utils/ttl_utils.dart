class TTLUtils {
  const TTLUtils._();
  static Duration get splashDelayTTL => const Duration(seconds: 60);
  static Duration get refreshDelayTTL => const Duration(seconds: 100);
}
