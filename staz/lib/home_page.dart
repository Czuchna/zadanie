import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staz/outlier_cubit.dart';
import 'package:staz/result_page.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: BlocConsumer<OutlierCubit, OutlierState>(
          listener: (context, state) {
            if (state is OutlierFound) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(outlier: state.outlier),
                ),
              );
            }
            if (state is OutlierError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      controller: controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: 'Wpisz liczby przedzielone przecinkami',
                          labelText: 'Liczby wejściowe',
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                controller.clear();
                              })),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9,]'))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      context
                          .read<OutlierCubit>()
                          .processInput(controller.text);
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green),
                    child: const Text(
                      'Wyszukaj',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
