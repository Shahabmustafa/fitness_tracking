import 'package:fitness_tracking/core/exports.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<BarChartGroupData> _buildStepBars() {
    final data = <int, double>{
      0: 100,
      3: 40,
      8: 1400, // big spike like in your image
      9: 50,
      10: 30,
    };

    return List.generate(24, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: data[i] ?? 0,
            color: Colors.redAccent,
            width: 6,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 8),
                const Text("Today", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 32),
                AspectRatio(
                  aspectRatio: 1.6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 2000,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1000,
                              getTitlesWidget: (value, _) => Text(
                                value.toInt().toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: (value, _) {
                                final hour = value.toInt();
                                return Text(
                                  hour % 4 == 0 ? hour.toString() : '',
                                  style: const TextStyle(fontSize: 12),
                                );
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: _buildStepBars(),
                        gridData: FlGridData(show: false),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.28,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 5,
                children: [
                  Text("Step Count",style: Theme.of(context).textTheme.labelSmall,),
                  Text("1000", style: Theme.of(context).textTheme.labelLarge,),
                  Text("Goal: Steps",style: Theme.of(context).textTheme.labelSmall,),
                  AppButton(
                    text: "Change goal",
                    width: 200,
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: AppColor.white,
                    ),
                    height: 40,
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        builder: (context){
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Text("Change Goal", style: Theme.of(context).textTheme.titleLarge,),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Center(child: Text("${index * 1000} Steps")),
                                        onTap: () {

                                        },
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    AppButton(
                                      text: "Cancel",
                                      width: 150,
                                      height: 35,
                                      color: AppColor.white,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        color: AppColor.primaryColor,
                                      ),
                                    ),
                                    AppButton(
                                      text: "Save",
                                      width: 150,
                                      height: 35,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(Icons.history, size: 30, color: AppColor.primaryColor.withOpacity(0.5)),
                      SizedBox(height: 10,),
                      Text("16 M 7 s",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text("Duration",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.location_on_outlined, size: 30, color: AppColor.primaryColor.withOpacity(0.5)),
                      SizedBox(height: 10,),
                      Text("1 KM",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text("Duration",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.water_drop_outlined, size: 30, color: AppColor.primaryColor.withOpacity(0.5)),
                      SizedBox(height: 10,),
                      Text("83 KCAL",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text("Calories",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
