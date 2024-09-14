import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:i_pharaoh/features/show/presentation/widgets/selection_button.dart';
import 'package:path/path.dart';

import '../../../../core/di/di.dart';
import '../../../../core/helpers/api/api_client.dart';
import '../../../../core/helpers/api/api_endpoints.dart';
import '../../../../core/utils/firebase/firebase_storage.dart';

part 'show_state.dart';

class ShowCubit extends Cubit<ShowState> {
  ShowCubit() : super(ShowInitial());
  late String _imgPath;
  String predictedClass = '';

  String _audioUrl = '';
  String _infoText = '';
  String _videoUrl = '';
  String getAudioUrl() => _audioUrl;

  String getInfoText() => _infoText;

  String getVidUrl() => _videoUrl;
  String txtUrl = '';
  String error = '';
  final SelectionButtonController selectionButtonController =
      SelectionButtonController();

  String get imagePath => _imgPath;
  Future predictImg(String imgPath) async {
    emit(Loading());
    _imgPath = imgPath;
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
    predictedClass = response.data['detected_class'];
    await _fetchPyramids(
        _predictedClassesToStorageFolders[predictedClass] ?? '');
    // emit(DoneState());
    // log('ShowCubit: predictImg: $responseStatusCode: $message');
  }

  Future<void> _fetchPyramids(String folderName) async {
    log('folderName: $folderName');
    List<Reference> references = [];

    if (folderName.isNotEmpty) {
      var result = await fetchDetectedDocument(folderName);
      result.fold((refs) => references = refs, (err) => error = err);
      for (var ref in references) {
        var url = await ref.getDownloadURL();
        log('url: $url');
        txtUrl = txtUrl.isEmpty
            ? url.contains('.txt')
                ? url
                : ''
            : txtUrl;
        _audioUrl = _audioUrl.isEmpty
            ? url.contains('.mp3')
                ? url
                : ''
            : _audioUrl;
        _videoUrl = _videoUrl.isEmpty
            ? url.contains('.mp4')
                ? url
                : ''
            : _videoUrl;

        // log('url of ${ref.name}: $txtUrl');
      }
      emit(GetUrlsState());
      final response = await http.get(Uri.parse(txtUrl));
      if (response.statusCode == 200) {
        _infoText = response.body;
          emit(GetInfoTextState());
        log('txt downloaded: ${response.body}');
      }
    }
  }

  final Map<String, String> _predictedClassesToStorageFolders = {
    'Akhenaten': 'akhenaten',
    'Bent-pyramid-for-senefru': 'bent_pyramid_for_senefru',
    'Colossal-Statue-of-Ramesses-II': 'colossal_statue_of_Ramesses_2',
    'Colossoi-of-Memnon': 'colossoi_of_memnon',
    'Goddess-Isis-with-her-child': 'goddess_isis_with_her_child',
    'Hatshepsut': 'hatshepsut',
    'Hatshepsut-face': 'hatshepsut_face',
    'Khafre-Pyramid': 'khafre_pyramid',
    'Mask-of-Tutankhamun': 'mask_of_tutankhamun',
    'Nefertiti': 'nefertiti',
    'Pyramid_of_Djoser': 'pyramid_of_djoser',
    'Ramessum': 'ramessum',
    'Ramses-II-Red-Granite-Statue': 'ramses_2_red_granite_statue',
    'Statue-of-King-Zoser': 'statue_of_king_zoser',
    'Statue-of-Tutankhamun-with-Ankhesenamun':
        'statue_of_tutankhamun_with_ankhesenamun',
    'Temple_of_Isis_in_Philae': 'temple_of_isis_in_philae',
    'Temple_of_Kom_Ombo': 'temple_of_kom_ombo',
    'The-Great-Temple-of-Ramesses-II': 'the_great_temple_of_ramesses_2',
    'amenhotep-iii-and-tiye': 'amenhotep_3_and_tiye',
    'bust-of-ramesses-ii': 'bust_of_ramesses_2',
    'menkaure-pyramid': 'menkaure_pyramid',
    'sphinx': 'sphinx'
  };

  onSelectionChanged(String value) {
    selectionButtonController.value = value;
    emit(SwiperIndexChangedState());
  }
}
