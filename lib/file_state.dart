part of 'file_cubit.dart';

@immutable
abstract class FileState {}

class FileInitial extends FileState {}

class FileLoaded extends FileState {}
