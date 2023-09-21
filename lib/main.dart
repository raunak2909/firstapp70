import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as apiClient;
import 'package:wallcano_46/api/api_helper.dart';
import 'package:wallcano_46/bloc/wallpaper_bloc.dart';
import 'package:wallcano_46/model/data_photo_model.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => WallpaperBloc(apiHelper: ApiHelper()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<WallpaperBloc>().add(GetTrendingWallpaper());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallcano'),
      ),
      body: BlocBuilder<WallpaperBloc, WallpaperState>(
        builder: (_, state){
          if(state is WallpaperLoadingState){
            return Center(child: CircularProgressIndicator(),);
          } else if(state is WallpaperErrorState){

          } else if(state is WallpaperLoadedState){
            return GridView.builder(
                itemCount: state.mData.photos!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 11,
                    crossAxisSpacing: 11,
                    childAspectRatio: 16 / 9),
                itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        image: DecorationImage(
                            image: NetworkImage(state.mData.photos![index].src!.landscape!),
                            fit: BoxFit.fill)),
                  );
                });
          }
          return Container();
        },
      )
    );
  }

  /*Future<DataPhotoModel> getWallpaper(String query) async {
    String url = "https://api.pexels.com/v1/search?query=$query";
    var res = await apiClient.get(Uri.parse(url), headers: {
      "Authorization":
          "nXWH9BLpCYtVtyjDTbJB3Hf20uneSxZcYisVLVmNDV4PamGm6EeVDgZm"
    });

    if (res.statusCode == 200) {
      var mData = jsonDecode(res.body);
      return DataPhotoModel.fromJson(mData);
    } else {
      return DataPhotoModel();
    }
  }*/
}
