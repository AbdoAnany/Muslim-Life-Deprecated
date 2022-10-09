// @dart=2.9

import 'package:azkar/Features/bloc/bookmarks/cubit.dart';
import 'package:azkar/Features/bloc/bookmarks/state.dart';
import 'package:azkar/Features/model/ayah.dart';
import 'package:azkar/Features/model/chapter.dart';
import 'package:azkar/core/providers/app_provider.dart';
import 'package:azkar/core/shared/colors.dart';
//import 'package:azkar/core/widgets/groupList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
//import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/groupList.dart';
import 'surah_app_bar.dart';

class PageScreen extends StatefulWidget {
  final Chapter chapter;

  const PageScreen({
    Key key,
    this.chapter,
  }) : super(key: key);

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  @override
  void initState() {
    final bookmarkCubit = BookmarkCubit.get(context);
    if (widget.chapter != null) {
      bookmarkCubit.checkBookmarked(widget.chapter);
    }
    widget.chapter.ayahs.sort((a, b) =>
        a.numberInSurah.compareTo(b.numberInSurah),);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //App.init(context);
    final appProvider = AppProvider.get(context);
    final bookmarkCubit = BookmarkCubit.get(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:




        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              actions: [
                BlocBuilder<BookmarkCubit, BookmarkState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        if (bookmarkCubit.state.isBookmarked) {
                          bookmarkCubit.updateBookmark(widget.chapter, false);
                        } else {
                          bookmarkCubit.updateBookmark(widget.chapter, true);
                        }
                      },
                      icon: Icon(
                        bookmarkCubit.state.isBookmarked
                            ? Icons.bookmark_added
                            : Icons.bookmark_add_outlined,
                        color: appProvider.isDark ? Colors.white : Colors.black54,
                      ),
                    );
                  },
                ),
              ],
              leading: BackButton(
                color: appProvider.isDark ? Colors.white : Colors.black54,
              ),
              backgroundColor:
                  appProvider.isDark ? Colors.grey[850] : Colors.white,
              pinned: true,
              floating: true,
              title: Slider(
                onChanged: (value) {

                  setState(() {
                    appProvider.fontSize  = value;
                  });
                },
                max: 0.07,
                min: 0.01,
                value:   appProvider.fontSize,
              ),
              expandedHeight: height * 0.17,
              flexibleSpace: SurahAppBar(
                data: widget.chapter ??
                    Chapter(
                      // englishName: 'Juz No. ${widget.juz!.number}',
                      englishNameTranslation:
                          '\nبِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                      //  name: JuzUtils.juzNames[(widget.juz!.number! - 1)],
                    ),
              ),
            ),

            // SliverList(
            //   delegate: SliverChildListDelegate([
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: GroupedListView<Ayah, String>(
            //         elements: widget.chapter == null ? '' : widget.chapter.ayahs,
            //
            //         groupBy: (element) {
            //           return element.page.toString();
            //         },
            //         //fontSize:    height*  appProvider.fontSize,
            //         groupComparator: (a, b) {
            //           return int.parse(a).compareTo(int.parse(b));
            //         },
            //         sort: true,fontSize:  appProvider.fontSize  ,
            //         shrinkWrap: true,
            //
            //         // sort: true,
            //         itemComparator: (a, b) {
            //
            //           return a.numberInSurah.compareTo(b.numberInSurah);
            //         },
            //         groupSeparatorBuilder: (String groupByValue) {
            //           return Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               SizedBox(
            //                   width: MediaQuery.of(context).size.width * .4,
            //                   child: Divider(color: kMainColor.withOpacity(.5))),
            //               Text(
            //                 ' $groupByValue ',
            //                 style: TextStyle(
            //                   fontFamily: 'ArbFONTS',
            //                   fontSize: height * 0.03,
            //                   color: Colors.black,
            //                 ),
            //               ),
            //               SizedBox(
            //                   width: MediaQuery.of(context).size.width * .4,
            //                   child: Divider(color: kMainColor.withOpacity(.5))),
            //             ],
            //           );
            //         },
            //         indexedItemBuilder: (context, Ayah element, i) {
            //           return
            //             RichText(    textDirection: TextDirection.rtl,
            //               text: TextSpan(
            //
            //                 children:  <TextSpan>[
            //                   TextSpan(text: element.text, style: TextStyle(fontWeight: FontWeight.bold)),
            //
            //                 ],
            //               ),
            //             );
            //
            //
            //         },
            //         //order: GroupedListOrder.ASC, // optional
            //       ),
            //     )
            //   ]),
            // )
            SliverList(
              delegate: SliverChildListDelegate([
                GroupedListView<Ayah, String>(
                  elements: widget.chapter == null ? '' : widget.chapter.ayahs,

                  groupBy: (element) {
                    return element.page.toString();
                  },fontSize:    height*  appProvider.fontSize,
                  groupComparator: (a, b) {
                    return int.parse(a).compareTo(int.parse(b));
                  },
                  sort: true,
                  shrinkWrap: true,

                  // sort: true,
                  itemComparator: (a, b) {

                    return a.numberInSurah.compareTo(b.numberInSurah);
                  },
                  groupSeparatorBuilder: (String groupByValue) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .35,
                            child: Divider(color: kMainColor.withOpacity(.5))),
                        Text(
                          ' $groupByValue ',textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'ArbFONTS',
                            fontSize: height * 0.03,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .35,
                            child: Divider(color: kMainColor.withOpacity(.5))),
                      ],
                    );
                  },
                  indexedItemBuilder: (context, Ayah element, i) {
                    return SizedBox();
                  },
                  order: GroupedListOrder.ASC, // optional
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
