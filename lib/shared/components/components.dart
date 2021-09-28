// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';

Widget defaultListItem(articles, context, index) => Container(
      color: NewsCubit.get(context).selectedBuisnessItem == index
          ? Colors.grey[300]
          : null,
      child: InkWell(
        onTap: () {
          NewsCubit.get(context).selectedBuisnesItem(index);
          // navigateto(context, WebViewScreen(articles['url']));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CachedNetworkImage(
                  imageUrl: '${articles['urlToImage']}c',
                  // ? '${articles['urlToImage']}'
                  // : 'https://miro.medium.com/max/1838/1*L3mkA69kzrcNonwKy5KJlA.jpeg',
                  imageBuilder: (context, imageProvider) => Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            )),
                      ),
                  errorWidget: (context, url, error) => Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            )),
                        child: const Icon(Icons.error),
                      ),
                  placeholder: (context, url) => Container(
                        height: 120.0,
                        width: 120.0,
                        child: Center(
                          child: Container(
                              height: 30.0,
                              width: 30.0,
                              child: const CircularProgressIndicator()),
                        ),
                      )),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Container(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        '${articles['title']}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.bodyText1,
                      )),
                      Text(
                        '${articles['publishedAt']}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateto(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

Widget defaultFromField({
  required TextEditingController? controller,
  required IconData? prefix,
  required String? label,
  TextInputType? type,
  TextStyle? conterStyle,
  Function(dynamic)? onchange,
}) =>
    TextFormField(
      keyboardType: type,
      onChanged: onchange!,
      decoration: InputDecoration(
          counterStyle: conterStyle,
          prefixIcon: Icon(prefix),
          labelText: label,
          border: const OutlineInputBorder()),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ListView.separated(
    itemBuilder: (context, index) =>
        defaultListItem(list[index], context, index),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: 10);

//   if ('${articles['urlToImage']}' == null) {
//     'https://googleflutter.com/sample_image.jpg';
//   } else
//     (value) {
//       value = '${articles['urlToImage']}';
//     };
// }

Widget defaultDescrpItem(articles, context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        child: Text('${articles['description']}'),
      ),
    );
Widget descriptionListItem(list, context, {isSearch = false}) =>
    ListView.separated(
        itemBuilder: (context, index) =>
            defaultDescrpItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10);
