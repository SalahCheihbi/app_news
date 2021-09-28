import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          var list = NewsCubit.get(context).search;

          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFromField(
                    type: TextInputType.text,
                    controller: searchController,
                    prefix: Icons.search,
                    label: 'Search',
                    onchange: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    // validate: (value) {
                    //   if (value.isEmpty) {
                    //     return 'Search is Empty';
                    //   }
                    //   return null;
                    // }
                  ),
                ),
                Expanded(
                    child: Conditional.single(
                        context: (context),
                        conditionBuilder: (BuildContext context) =>
                            list.isNotEmpty,
                        widgetBuilder: (BuildContext context) =>
                            ListView.separated(
                                itemBuilder: (context, index) =>
                                    defaultListItem(
                                        list[index], context, index),
                                separatorBuilder: (context, index) =>
                                    myDivider(),
                                itemCount: 10),
                        fallbackBuilder: (BuildContext context) =>
                            NewsCubit.get(context).isSearch
                                ? Container()
                                : const Center(
                                    child: CircularProgressIndicator())))
              ],
            ),
          );
        });
  }
}
