
import 'package:fitness_tracking/core/exports.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    title: Text("Shahab Mustafa"),
                    trailing: Text("1800",style: Theme.of(context).textTheme.titleMedium,),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
