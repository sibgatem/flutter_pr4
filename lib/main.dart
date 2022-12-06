import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statemanagement/cubit/click_cubit.dart';
import 'package:statemanagement/cubit/theme/theme_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => ClickCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            themeMode: context.read<ThemeCubit>().themeMode,
            theme: ThemeData(
              colorScheme: const ColorScheme.light(),
            ),
            darkTheme: ThemeData(
              colorScheme: const ColorScheme.dark(),
            ),
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          BlocBuilder<ClickCubit, ClickState>(
            builder: (context, state) {
              if (state is Click) {
                return Text(state.count.toString());
              }
              return const Text("0");
            },
          ),
          ElevatedButton(
            onPressed: () {
              context
                  .read<ClickCubit>()
                  .onClick(context.read<ThemeCubit>().themeMode);
            },
            child: const Text("+"),
          ),
          Expanded(
            child: BlocBuilder<ClickCubit, ClickState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: context.read<ClickCubit>().list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                        child: Text(context.read<ClickCubit>().list[index]));
                  },
                );
              },
            ),
          ),
        ],
      )),
      floatingActionButton: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<ThemeCubit>().changeTheme();
            },
            child: const Icon(Icons.change_circle),
          );
        },
      ),
    );
  }
}
