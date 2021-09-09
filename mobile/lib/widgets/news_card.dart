import 'package:flutter/material.dart';

import 'package:mebook/widgets/news_tile.dart';

class NewsCard extends StatelessWidget {
  final List<Map<String, Object>> _news = [
    {
      'provider': 'The Economist',
      'icon': 'https://www.economist.com/engassets/ico/favicon.f1ea908894.ico',
      'title': 'How, after 9/11, New York built back better',
      'subtitle':
          'That was the worst day in the city’s history, but it also spurred its transformation',
      'body':
          '  THE MORNING after the September 11th attacks, as exhausted first-responders looked for survivors in rubble still wreathed in smoke, New Yorkers braced themselves for more attacks. The final death toll came to 2,743 people—almost all New Yorkers. America would later launch two long, costly wars in response and squander its moral authority in prisons in Guantánamo Bay and Abu Ghraib. In some ways the country is worse off now than it was on September 10th 2001, more anxious, more polarised, less trusting. New York City, though, is better. The resurrection of Lower Manhattan acted as a catalyst for rebuilding and rethinking well beyond the area destroyed on that terrible day. (...)',
    },
    {
      'provider': 'New York Times',
      'icon':
          'https://www.nytimes.com/vi-assets/static-assets/favicon-d2483f10ef688e6f89e23806b9700298.ico',
      'title':
          'From 4% to 45%: Energy Department Lays Out Ambitious Blueprint for Solar Power',
      'subtitle':
          'The department’s analysis provides only a broad outline, and many of the details will be decided by congressional lawmakers.',
      'body':
          '  The Biden administration on Wednesday released a blueprint showing how the nation could move toward producing almost half of its electricity from the sun by 2050 — a potentially big step toward fighting climate change but one that would require vast upgrades to the electric grid.',
    },
    {
      'provider': 'U.S.News',
      'icon': 'https://www.usnews.com/static/images/favicon.ico',
      'title':
          'Saudi Arabia Issues Statement of Innocence – and Indignation – in Advance of 9/11 Documents Release',
      'subtitle':
          'Families of 9/11 victims believe new documents President Joe Biden ordered to be declassified this week may offer new insights on a long-suspected Saudi link to the hijackers.',
      'body':
          '  Saudi Arabia on Wednesday issued a preemptive statement of innocence in advance of the expected release this week of previously declassified documents related to the U.S. government\'s investigation in the Sept. 11 attacks and expressed indignation that accusations persist of its connection to the hijackers. ',
    },
    {
      'provider': 'NBC News',
      'icon':
          'https://nodeassets.nbcnews.com/cdnassets/projects/ramen/favicon/nbcnews/all-other-sizes-PNG.ico/apple-icon-72x72.png',
      'title':
          'Louisiana televangelist Jesse Duplantis criticized for response to hurricane victims',
      'subtitle':
          '"Outside of your podcasts and Facebook staged videos I\'ve not seen nor heard from you or your church staff," one critic wrote on Facebook.',
      'body':
          '  Jesse Duplantis, a televangelist in Louisiana, is drawing criticism for his ministry\'s response to Hurricane Ida.\n  Duplantis, who heads Jesse Duplantis Ministries, was criticized on the ministry\'s Facebook page by commenters who accused him of not doing enough to help those affected by the storm, which made landfall in southeast Louisiana last month.\n  St. Charles Parish, where Duplantis\' Covenant Church is located, was one of the areas hardest hit by Ida. On Wednesday, more than a week after the storm, 95 percent of customers in the parish remained without power.',
    },
    {
      'provider': 'The Guardian',
      'icon':
          'https://assets.guim.co.uk/images/favicons/873381bf11d58e20f551905d51575117/72x72.png',
      'title':
          'Nxivm co-founder Nancy Salzman jailed for more than 3 years in sex slaves case',
      'subtitle':
          'The former nurse pleaded guilty in 2019 to charges related to her role in the cult-like group that turned some women into sex slaves',
      'body':
          '  A former nurse who co-founded and once ran the cult-like Nxivm group, where prosecutors say women were brainwashed, branded like animals and coerced into sex, was sentenced to 42 months in prison.\n  Nancy Salzman, the former president and co-founder of Nxivm, must also pay a \$150,000 fine, US district judge Nicholas Garaufis said on Wednesday. She has agreed to forfeit more than \$500,000 in cash, several properties and a Steinway grand piano.\n  Salzman must report to prison by 19 January, Garaufis said. Her lawyers said she has been caring for her ailing mother.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        // borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.black12),
              ),
            ),
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Today\'s News',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Material(
                  color: Colors.white,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_vert),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: _news.length,
                itemBuilder: (context, index) => NewsTile(_news[index]),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
