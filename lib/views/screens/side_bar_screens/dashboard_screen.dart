import 'package:chaya_webadmin/views/screens/side_bar_screens/widgets/dashboard_contents/dashboard_banner.dart';
import 'package:chaya_webadmin/views/screens/side_bar_screens/widgets/dashboard_contents/dashboard_carousel.dart';
import 'package:chaya_webadmin/views/screens/side_bar_screens/widgets/dashboard_contents/dashboard_files.dart';
import 'package:chaya_webadmin/views/screens/side_bar_screens/widgets/dashboard_contents/dashboard_users.dart';
import 'package:chaya_webadmin/views/screens/side_bar_screens/widgets/dashboard_contents/resposive_widget.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '\ DashboardScreen';
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: ResPonsiveUi(
          mobile:body() ,
          desktop: body(),
          tablet: body(),
        ),

      ),
    );
  }

  Widget body(){
    final Screenwidth= MediaQuery.of(context).size.width;

    return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF3E4685),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                  Container(
                  height: 120,
                  width: Screenwidth/4.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF39A2DB),
                  ),
                  child: ListTile(
                    title: Text('App Downloads', style: TextStyle(color: Colors.white)),
                    subtitle: Text('5463k', style: TextStyle(color: Colors.white)),
                  ),),
                    Container(
                      height: 120,
                      width: Screenwidth/4.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFEF476F),
                      ),
                      child: ListTile(
                        title: Text('App Installations', style: TextStyle(color: Colors.white)),
                        subtitle: Text('8989k', style: TextStyle(color: Colors.white)),
                      ),),
                    Container(
                      height: 120,
                      width: Screenwidth/4.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFF9A03F),
                      ),
                      child: ListTile(
                        title: Text('Ad Revenue', style: TextStyle(color: Colors.white)),
                        subtitle: Text('\$95.65', style: TextStyle(color: Colors.white)),
                      ),),

                  ],
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DashUsersWidget(),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: DashBannerWidget(),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: DashCarouselWidget(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: DashFilesWidget(),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [


                            Container(
                              width: Screenwidth/4,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color(0xFF3E4685),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Forecast',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ForecastItemWithLifeline(
                                        title: 'Profit',
                                        value: '\$95.65',
                                        color: Colors.green,
                                      ),
                                      ForecastItemWithLifeline(
                                        title: 'Expenses',
                                        value: '\$20.44',
                                        color: Colors.red,
                                      ),
                                      ForecastItemWithLifeline(
                                        title: 'Revenue',
                                        value: '\$45.32',
                                        color: Colors.blue,
                                      ),
                                      ForecastItemWithLifeline(
                                        title: 'Statistics',
                                        value: '74%',
                                        color: Colors.orange,
                                      ),
                                      ForecastItemWithLifeline(
                                        title: 'User Storage',
                                        value: '18%',
                                        color: Colors.purple,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnimatedShareMarketStatistics(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container (
                        height: 1600,
                        width: 700,
                        color:Color(0xFFEF476F),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text("Help and guidance",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                tileColor: Color(0xff292D3F),
                                leading: Icon(Icons.book_rounded,color: Colors.yellow.shade900,),
                                title: Text('New Pages guide',style: TextStyle(color: Colors.white70),),
                                subtitle: Text('Learn how to use your Page and get answers to frequently asked questions',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                tileColor: Color(0xff292D3F),
                                leading: Icon(Icons.account_circle_outlined,color: Color(0xff2697ff),),
                                title: Text('Creator Support',style: TextStyle(color: Colors.white70),),
                                subtitle: Text('Centralised support and education for creator'
                                  ,style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                tileColor: Color(0xff292D3F),
                                leading: Icon(Icons.question_mark),
                                title: Text('Help Centre',style: TextStyle(color: Colors.white70),),
                                subtitle: Text('Find articles and other resources to help solve common problems.',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
      );
  }
}

class ForecastItemWithLifeline extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const ForecastItemWithLifeline({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final Screenwidth= MediaQuery.of(context).size.width;
    return Container(

      child: Row(
        children: [
          Container(
            width:  Screenwidth/10,
            height: 6,
            color: color,
          ),
          SizedBox(width: 10),
          Container(
            width:  Screenwidth/20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(color: Colors.lightGreenAccent, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class AnimatedShareMarketStatistics extends StatefulWidget {
  @override
  _AnimatedShareMarketStatisticsState createState() => _AnimatedShareMarketStatisticsState();
}

class _AnimatedShareMarketStatisticsState extends State<AnimatedShareMarketStatistics>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _animationValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);
    _controller.addListener(() {
      setState(() {
        _animationValue = _controller.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Screenwidth = MediaQuery.of(context).size.width;
    final double lineHeight = 120;

    return Container(
      width: Screenwidth / 4,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF3E4685),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Analytics',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: lineHeight,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 5; i++)
                      AnimatedLine(
                        animationValue: _animationValue,
                        lineHeight: lineHeight,
                        index: i,
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedLine extends StatelessWidget {
  final double animationValue;
  final double lineHeight;
  final int index;

  const AnimatedLine({
    required this.animationValue,
    required this.lineHeight,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final double maxWidth = 30;
    final double minWidth = 2;
    final double lineWidth = minWidth +
        (animationValue * (maxWidth - minWidth)) *
            (1 - ((index + 1) % 2)); // Vary width for odd and even lines

    return Container(
      width: lineWidth,
      height: lineHeight,
      color: Colors.lightBlueAccent,
    );
  }
}

