import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:smart_quotes/models/quote.dart';
import 'package:smart_quotes/utils/colors.dart';
import 'package:smart_quotes/utils/text_styles.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:sizer/sizer.dart';

class WQuoteCard extends StatelessWidget {
  const WQuoteCard({
    required Key key,
    required this.quote,
  }) : super(key: key);

  final Quote quote;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 18,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff171717),
          borderRadius: BorderRadius.circular(
            20,
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 8,
              color: TinyColor(darkColor).color.withOpacity(.8),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Wrap(
              spacing: 8.0,
              children: quote.tags
                  .map(
                    (e) => Text(
                      "#$e",
                      style: textStyle.apply(
                        fontSizeDelta: -4,
                        color: TinyColor(Colors.white).color.withOpacity(.8),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Text(
                quote.content,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                style: textStyle.apply(
                  fontSizeDelta: 16,
                  fontWeightDelta: 10,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),
            Text(
              "By ${quote.author}",
              style: textStyle.apply(
                color: Colors.white.withOpacity(.8),
                fontSizeDelta: -2,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            MaterialButton(
              onPressed: () {},
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Text(
                'Read more'.toUpperCase(),
                style: textStyle.apply(
                  color: darkColor,
                  fontSizeDelta: -2,
                ),
              ),
            ),
            // const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {},
                color: Colors.white,
                icon: const Icon(
                  IconlyBold.bookmark,
                ),
              ),
            )
          ],
        ),
      );
}
