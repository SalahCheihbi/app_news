import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).science;
        return Conditional.single(
            context: (context),
            conditionBuilder: (BuildContext context) => list.isNotEmpty,
            widgetBuilder: (BuildContext context) => ListView.separated(
                itemBuilder: (context, index) =>
                    defaultListItem(list[index], context, index),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: 10),
            fallbackBuilder: (BuildContext context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
