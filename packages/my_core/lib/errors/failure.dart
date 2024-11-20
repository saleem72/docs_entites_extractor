//

import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String? message;
  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

final class GeneralFailure extends Failure {
  const GeneralFailure({required String message}) : super(message);
}

final class NoInternetFailure extends Failure {
  const NoInternetFailure() : super('You have no internet connection');
}

final class ConnectionFailure extends Failure {
  const ConnectionFailure() : super('Check your internet connection');
}

final class DecodingFailure extends Failure {
  const DecodingFailure() : super('Some data are corrupted');
}

final class UnAuthorizedFailure extends Failure {
  const UnAuthorizedFailure() : super('You are not authorized to do this');
}

final class ForbiddenFailure extends Failure {
  const ForbiddenFailure() : super('You are not allowed to do this');
}

final class ServerFailure extends Failure {
  const ServerFailure() : super('Some thing bad happened');
}

final class UnExpectedFailure extends Failure {
  const UnExpectedFailure({required String message}) : super(message);
}

final class ProductNotFoundFailure extends Failure {
  const ProductNotFoundFailure({required String message}) : super(message);
}

final class DownloadsDirectoryNotFoundFailure extends Failure {
  const DownloadsDirectoryNotFoundFailure()
      : super('Downloads folder not found');
}

final class CannotOpenUrlFailure extends Failure {
  final String url;
  const CannotOpenUrlFailure({
    required this.url,
  }) : super('Could not launch $url');
}

final class EmptyUrlFailure extends Failure {
  const EmptyUrlFailure() : super('Could not launch empty url');
}

final class BadQrFailure extends Failure {
  const BadQrFailure() : super('This is not valid QR');
}
