part of 'wallpaper_bloc.dart';

@immutable
abstract class WallpaperEvent {}

class GetSearchWallpaper extends WallpaperEvent{
  String query;
  GetSearchWallpaper({required this.query});
}

class GetTrendingWallpaper extends WallpaperEvent{}