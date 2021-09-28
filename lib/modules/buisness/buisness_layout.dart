import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BuisnessScreen extends StatelessWidget {
  const BuisnessScreen({Key? key}) : super(key: key);

  get index => null;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).buisness;
        return ScreenTypeLayout(
          mobile: articleBuilder(list, context),
          desktop: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: articleBuilder(list, context),
              ),
              if (list.isNotEmpty)
                Expanded(
                  child: Container(
                    height: double.infinity,
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                          '${list[NewsCubit.get(context).selectedBuisnessItem]['description']}'),
                    ),
                  ),
                )
            ],
          ),
          breakpoints: const ScreenBreakpoints(
            desktop: 400,
            tablet: 300,
            watch: 100,
          ),
        );
      },
    );
  }
}
