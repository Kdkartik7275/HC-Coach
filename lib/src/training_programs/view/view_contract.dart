import 'package:flutter/material.dart';
import 'package:hicoach_coach/core/constants/colors.dart';
import 'package:intl/intl.dart';



class Contract {
  final String title;
  final String coachName;
  final String sport;
  final int durationDays;
  final DateTime startDate;
  final DateTime endDate;
  final int sessions;
  final String frequency; // e.g., "3 days/week"
  final String paymentType; // "Fixed", "Monthly", "Per Session"
  final double price;
  final String description;
  final String cancellationPolicy;

  Contract({
    required this.title,
    required this.coachName,
    required this.sport,
    required this.durationDays,
    required this.startDate,
    required this.endDate,
    required this.sessions,
    required this.frequency,
    required this.paymentType,
    required this.price,
    required this.description,
    required this.cancellationPolicy,
  });
}

class ViewContractPage extends StatelessWidget {

   ViewContractPage({super.key});



  final contract = Contract(
  title: "Beginner Tennis Coaching Contract",
  coachName: "Rahul Sharma",
  sport: "Tennis",
  durationDays: 30,
  startDate: DateTime.now(),
  endDate: DateTime.now().add(const Duration(days: 30)),
  sessions: 12,
  frequency: "3 days/week",
  paymentType: "Fixed",
  price: 4500,
  description:
      "This 1-month tennis coaching program focuses on fundamentals such as footwork, grip, serves, and rallies. Students will be assessed weekly.",
  cancellationPolicy:
      "Cancellations allowed only within first 3 days. No refunds after first week.",
);


  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.3,
        title: const Text("Contract Details"),
        centerTitle: true,
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER CARD
            _headerCard(context),

            const SizedBox(height: 20),
            _sectionTitle("Contract Overview"),
            const SizedBox(height: 10),

            _infoTile("Coach", contract.coachName),
            _infoTile("Sport", contract.sport),
            _infoTile("Duration", "${contract.durationDays} days"),
            _infoTile("Start Date", dateFormat.format(contract.startDate)),
            _infoTile("End Date", dateFormat.format(contract.endDate)),
            _infoTile("Total Sessions", "${contract.sessions} sessions"),
            _infoTile("Session Frequency", contract.frequency),
            _infoTile("Payment Type", contract.paymentType),
            _infoTile("Price", "₹${contract.price.toStringAsFixed(0)}"),

            const SizedBox(height: 24),
            _sectionTitle("Description"),
            const SizedBox(height: 8),
            _descriptionBox(contract.description),

            const SizedBox(height: 24),
            _sectionTitle("Cancellation Policy"),
            const SizedBox(height: 8),
            _descriptionBox(contract.cancellationPolicy),

            const SizedBox(height: 40),

            // ACTION BUTTONS
            _actionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _headerCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contract.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            "Professional Coaching Contract",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.textLighter, fontSize: 15),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionBox(String text) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.filled,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.text),
      ),
    );
  }

  Widget _actionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Accept Contract",
              style: TextStyle(color: AppColors.white, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Download PDF",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
