import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staz/outlier_cubit.dart';
import 'package:staz/result_page.dart';
import 'package:staz/widgets/custom_text_field.dart';

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
    return Scaffold(
      //TODO(Kacper): resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Center _buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomTextField(
            controller: controller,
            onChanged: (v) {
              setState(() {});
            },
          ),
          BlocConsumer<OutlierCubit, OutlierState>(
            listener: (context, state) {
              if (state is OutlierFound) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(outlier: state.outlier),
                  ),
                );
                controller.clear();
                FocusScope.of(context).unfocus();
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
              return TextButton(
                onPressed: controller.text.isNotEmpty
                    ? () {
                        context
                            .read<OutlierCubit>()
                            .processInput(controller.text);
                      }
                    : null,
                style: TextButton.styleFrom(
                    disabledBackgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green),
                child: state is LoadingState
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Wyszukaj',
                        style: TextStyle(fontSize: 20),
                      ),
              );
            },
          )
        ],
      ),
    );
  }
}
