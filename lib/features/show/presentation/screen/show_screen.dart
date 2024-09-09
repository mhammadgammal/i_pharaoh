import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_pharaoh/features/show/presentation/cubit/show_cubit.dart';

class ShowScreen extends StatelessWidget {
  const ShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShowCubit, ShowState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: const Center(
            child: Text('Show Screen'),
          ),
        );
      },
    );
  }
}
