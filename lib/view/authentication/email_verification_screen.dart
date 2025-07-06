import 'package:fitness_tracking/core/exports.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Top spacing
              SizedBox(height: 40),

              // Email icon with circular background
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                    color: Colors.blue.shade100,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.mark_email_read_outlined,
                  size: 60,
                  color: Colors.blue.shade600,
                ),
              ),

              SizedBox(height: 32),

              // Title
              Text(
                "Verify Your Email",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16),

              // Subtitle
              Text(
                "We've sent a verification link to your email address. Please check your inbox and click the link to verify your account.",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 8),

              // Email display (you can pass the email as parameter)
              Text(
                "example@email.com", // Replace with actual email
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.blue.shade600,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40),

              // Check Email Button
              AppButton(
                text: "Open Email App",
                onTap: () {
                  // Open email app logic
                  // You can use url_launcher to open email app
                },
              ),

              SizedBox(height: 16),

              // Resend Email Button
              AppButton(
                text: "Resend Verification Email",
                color: Colors.white,
                textStyle: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 16,
                ),
                onTap: () {
                  // Open email app logic
                  // You can use url_launcher to open email app
                },
              ),

              SizedBox(height: 24),

              // Already verified? Login button
              TextButton(
                onPressed: () {
                  // Navigate to login or check verification status
                },
                child: Text(
                  "Already verified? Continue",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),

              Spacer(),

              // Bottom help text
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.help_outline,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Didn't receive the email? Check your spam folder or contact support.",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}