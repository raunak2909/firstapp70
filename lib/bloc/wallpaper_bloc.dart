import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallcano_46/api/urls.dart';
import 'package:wallcano_46/model/data_photo_model.dart';

import '../api/api_helper.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  ApiHelper apiHelper;
  WallpaperBloc({required this.apiHelper}) : super(WallpaperInitialState()) {

    on<GetTrendingWallpaper>((event, emit) async{
      emit(WallpaperLoadingState());

      var res = await apiHelper.getApi("${Urls.trendingUrl}?per_page=20");

      if(res!=null){
        emit(WallpaperLoadedState(mData: DataPhotoModel.fromJson(res)));
      } else {
        emit(WallpaperErrorState(errorMsg: "Internet Error"));
      }

    });

    on<GetSearchWallpaper>((event, emit) async{
      emit(WallpaperLoadingState());

      var res = await apiHelper.getApi("${Urls.searchUrl}?query=${event.query}&per_page=20");

      if(res!=null){
        emit(WallpaperLoadedState(mData: DataPhotoModel.fromJson(res)));
      } else {
        emit(WallpaperErrorState(errorMsg: "Internet Error"));
      }
    });
  }
}
