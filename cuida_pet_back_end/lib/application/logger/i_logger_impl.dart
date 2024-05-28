import 'package:cuida_pet_back_end/application/logger/i_logger.dart';
import 'package:logger/logger.dart';

class ILoggerImpl implements ILogger {
  final _logger = Logger();

  @override
  void debug(message, [error, StackTrace? stackTrace]) =>
      _logger.d(message, error: error, stackTrace: stackTrace);

  @override
  void error(message, [error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  @override
  void info(message, [error, StackTrace? stackTrace]) =>
      _logger.i(message, error: error, stackTrace: stackTrace);
  @override
  void warning(message, [error, StackTrace? stackTrace]) =>
      _logger.w(message, error: error, stackTrace: stackTrace);
}
