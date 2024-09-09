import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/core/di/di.dart';
import 'package:i_pharaoh/core/helpers/api/api_client.dart';
import 'package:i_pharaoh/core/helpers/api/api_endpoints.dart';
import 'package:path/path.dart';

part 'show_state.dart';

class ShowCubit extends Cubit<ShowState> {
  ShowCubit() : super(ShowInitial());

  Future predictImg(String imgPath) async {
    log('ShowCubit: predictImg: $imgPath');
    var imageFile = File(imgPath); // Get the image file
    String fileName = basename(imageFile.path); // Get the name of the file

    // Prepare FormData
    FormData formData = FormData.fromMap({
      "pic": await MultipartFile.fromFile(imageFile.path, filename: fileName),
    });

    var response = await sl<ApiClient>().post(ApiEndPoints.predict, formData);

    var responseStatusCode = response.statusCode;
    var message = response.data['message'];
    log('ShowCubit: predictImg: $responseStatusCode: $message');
  }
}
