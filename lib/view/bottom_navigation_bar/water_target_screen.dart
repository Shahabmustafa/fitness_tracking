import 'package:fitness_tracking/core/exports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

final waterTargetProvider = StateProvider<int>((_) => 5000);   // ml
final waterTodayProvider  = StateProvider<int>((_) => 0);      // ml

void addWater(WidgetRef ref, int amount) {
  ref.read(waterTodayProvider.notifier).update((v) => v + amount);
}

class WaterTargetScreen extends ConsumerWidget {
  const WaterTargetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final target = ref.watch(waterTargetProvider);
    final today  = ref.watch(waterTodayProvider);
    final percent = (today / target).clamp(0, 1.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      appBar: AppBar(
        title: const Text('Water Target',),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Progress text
              Text(
                'Today\'s Progress',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1976D2),
                ),
              ),
              const SizedBox(height: 8),

              Text(
                '${(percent * 100).toInt()}% of daily goal',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 40),

              // Enhanced animated circular wave
              Center(
                child: SizedBox(
                  height: 280,
                  width: 280,
                  child: AnimatedWaterFillCircle(
                    percent: percent.toDouble(),
                    text: '$today / $target ml',
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Quick add buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _QuickAddButton(
                    amount: 250,
                    icon: Icons.local_drink,
                    label: '250ml',
                    onTap: () => addWater(ref, 250),
                  ),
                  _QuickAddButton(
                    amount: 500,
                    icon: Icons.sports_bar,
                    label: '500ml',
                    onTap: () => addWater(ref, 500),
                  ),
                  _QuickAddButton(
                    amount: 1000,
                    icon: Icons.water_drop,
                    label: '1L',
                    onTap: () => addWater(ref, 1000),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Set target button with enhanced style
              Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2196F3).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28),
                    onTap: () => _showSetTargetDialog(context, ref),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Set Water Target',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Achievement message
              if (percent >= 1.0)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.celebration, color: Colors.green),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Congratulations! You\'ve reached your daily water goal! 🎉',
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSetTargetDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final currentTarget = ref.read(waterTargetProvider);
    controller.text = currentTarget.toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title:  Row(
          children: [
            Icon(Icons.water_drop, color: Color(0xFF2196F3)),
            SizedBox(width: 8),
            Text('Set Water Target',style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter your daily water target in milliliters:',style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(height: 16),
            AppTextFormField(
              hintText: "Enter target in ml",
              prefixIcon: const Icon(Icons.water_drop),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel',style: Theme.of(context).textTheme.titleMedium,),
          ),
          AppButton(
            text: "Set Target",
            onTap: (){
              final newTarget = int.tryParse(controller.text);
              if (newTarget != null && newTarget > 0) {
                ref.read(waterTargetProvider.notifier).state = newTarget;
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
    );
  }
}

class _QuickAddButton extends StatelessWidget {
  final int amount;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAddButton({
    required this.amount,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                Icon(
                  icon,
                  color: const Color(0xFF2196F3),
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF2196F3),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedWaterFillCircle extends StatefulWidget {
  final double percent;
  final String text;

  const AnimatedWaterFillCircle({
    super.key,
    required this.percent,
    required this.text,
  });

  @override
  State<AnimatedWaterFillCircle> createState() => _AnimatedWaterFillCircleState();
}

class _AnimatedWaterFillCircleState extends State<AnimatedWaterFillCircle>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _fillController;
  late Animation<double> _fillAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _fillController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fillAnimation = Tween<double>(
      begin: 0,
      end: widget.percent,
    ).animate(CurvedAnimation(
      parent: _fillController,
      curve: Curves.easeInOut,
    ));

    _fillController.forward();
  }

  @override
  void didUpdateWidget(AnimatedWaterFillCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.percent != widget.percent) {
      _fillAnimation = Tween<double>(
        begin: _fillAnimation.value,
        end: widget.percent,
      ).animate(CurvedAnimation(
        parent: _fillController,
        curve: Curves.easeInOut,
      ));
      _fillController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    _fillController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_waveController, _fillAnimation]),
      builder: (context, child) {
        return CustomPaint(
          painter: _EnhancedWaterPainter(
            _fillAnimation.value,
            _waveController.value,
          ),
          child: Container(
            height: 280,
            width: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2196F3).withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.water_drop,
                    color: AppColor.white,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.text,
                    style:  TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EnhancedWaterPainter extends CustomPainter {
  final double percent;
  final double wavePhase;

  _EnhancedWaterPainter(this.percent, this.wavePhase);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint borderPaint = Paint()
      ..color = const Color(0xFF2196F3)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF64B5F6).withOpacity(0.8),
          const Color(0xFF2196F3).withOpacity(0.6),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final Paint wavePaint = Paint()
      ..color = const Color(0xFF1976D2).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    // Background circle
    canvas.drawCircle(center, radius, Paint()..color = Colors.white);

    if (percent > 0) {
      // Calculate water level
      final waterLevel = size.height * (1 - percent);

      // Create wave path
      final wavePath = Path();
      final waveHeight = 8.0;
      final waveLength = size.width / 2;

      wavePath.moveTo(0, waterLevel);

      for (double x = 0; x <= size.width; x += 2) {
        final y = waterLevel +
            math.sin((x / waveLength) * 2 * math.pi + wavePhase * 2 * math.pi) * waveHeight +
            math.sin((x / waveLength) * 4 * math.pi + wavePhase * 4 * math.pi) * (waveHeight / 2);
        wavePath.lineTo(x, y);
      }

      wavePath.lineTo(size.width, size.height);
      wavePath.lineTo(0, size.height);
      wavePath.close();

      // Clip to circle
      canvas.save();
      canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: radius)));

      // Draw water fill
      canvas.drawPath(wavePath, fillPaint);

      // Draw wave effect
      canvas.drawPath(wavePath, wavePaint);

      canvas.restore();
    }

    // Outer circle border
    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _EnhancedWaterPainter oldDelegate) {
    return oldDelegate.percent != percent || oldDelegate.wavePhase != wavePhase;
  }
}