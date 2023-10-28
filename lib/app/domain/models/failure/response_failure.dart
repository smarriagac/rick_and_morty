import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_failure.freezed.dart';

@freezed
class ResponseFailure with _$ResponseFailure {
  factory ResponseFailure.notFound() = _ResponseFailureNotFound;
  factory ResponseFailure.notVerified() = _ResponseFailureNotVerified;
  factory ResponseFailure.network() = _ResponseFailureNetwork;
  factory ResponseFailure.unauthorized() = _ResponseFailureUnauthorized;
  factory ResponseFailure.linkDevice() = _ResponseFailureLinkDevice;
  factory ResponseFailure.diseableAccount() = _ResponseFailureDiseableAccount;
  factory ResponseFailure.lockedDevice() = _ResponseFailureLockedDevice;
  factory ResponseFailure.unknow() = _ResponseFailureUnknow;
}
