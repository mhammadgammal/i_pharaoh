import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/features/show/presentation/cubit/show_cubit.dart';

import '../widgets/audio_info_widget.dart';
import '../widgets/info_widget.dart';

class ShowScreen extends StatelessWidget {
  const ShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShowCubit, ShowState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = context.read<ShowCubit>();
        return Scaffold(
          body: state is Loading
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 350.0,
                      // Height of the Stack widget
                      pinned: true,
                      centerTitle: true,
                      title: Text(
                        cubit.predictedClass,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: EdgeInsets.zero,
                        background: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Image.file(
                              File(cubit.imagePath),
                              height: 400.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Visibility(
                              visible: cubit.getAudioUrl().isNotEmpty,
                              child: SizedBox(
                                  height: 70.0,
                                  child: AudioInfoWidget(cubit.getAudioUrl())),
                            )
                          ],
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const SizedBox(height: 25.0),
                          InfoWidget(
                            infoText: cubit.getInfoText(),
                            videoUrl:
                            cubit.getVidUrl(),
                            selectionButtonController:
                                cubit.selectionButtonController,
                            onSelectionChanged: cubit.onSelectionChanged,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
