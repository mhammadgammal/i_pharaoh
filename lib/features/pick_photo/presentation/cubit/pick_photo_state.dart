part of 'pick_photo_cubit.dart';

@immutable
sealed class PickPhotoState {}

final class ImageSetState extends PickPhotoState {}

final class PhotoTakenState extends PickPhotoState {}

final class PickPhotoInitial extends PickPhotoState {}

final class CameraInitializedState extends PickPhotoState {}

final class ImageTakenState extends PickPhotoState {}

final class CheckCameraPermissionState extends PickPhotoState {}

final class CmaeraPermissionState extends PickPhotoState {
  final CmaeraPermissionRequestState permissionState;
  CmaeraPermissionState({required this.permissionState});
}
