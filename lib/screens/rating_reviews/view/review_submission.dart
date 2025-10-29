import 'package:flutter/material.dart';
import 'package:health_care/core/utils/custom_widgets/custom_app_button.dart';
import 'package:health_care/core/utils/navigation_helper.dart';
import 'package:health_care/core/utils/theams/color_resource.dart';
import '../../../core/api_service/app_url.dart';
import '../../../core/utils/custom_widgets/booking_completeDialogue.dart';
import '../../../core/utils/custom_widgets/custom_appBar.dart';
import '../../../core/utils/custom_widgets/custom_image_view.dart';
import '../../../core/utils/helper_functions/helpers_methods.dart';
import '../repo/review_submissionRepo.dart';


class ReviewSubmissionPage extends StatefulWidget {
  final String consultantName;
  final String appointmentId;
  final String profileImage;

  const ReviewSubmissionPage({
    super.key,
    required this.consultantName,
    required this.appointmentId,
    required this.profileImage,
  });

  @override
  State<ReviewSubmissionPage> createState() => _ReviewSubmissionPageState();
}

class _ReviewSubmissionPageState extends State<ReviewSubmissionPage> {
  int selectedRating = 0;
  final TextEditingController _reviewController = TextEditingController();
  final ReviewSubmission _reviewSubmission = ReviewSubmission();

  void setRating(int rating) {
    setState(() {
      selectedRating = rating;
    });
  }

  void _submitReview() async {
    final reviewText = _reviewController.text.trim();

    if (selectedRating == 0) {
      HelperMethods.showCustomSnackbar(context, message: "Please select a rating");
      return;
    }

    if (reviewText.isEmpty) {
      HelperMethods.showCustomSnackbar(context, message: "Please write your review");
      return;
    }

    try {
      final response = await _reviewSubmission.submitReviews(
        appointmentId: widget.appointmentId,
        rating: selectedRating.toString(),
        review: reviewText,
      );

      if (response['success'] == true) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const BookingCompletionDialogue(
            message: "Thank you for your review!",
          ),
        );
      } else {
        // Check for specific error message
        if (response['message'] == "You have already reviewed this appointment") {
          HelperMethods.showCustomSnackbar(context, message: "You have already submitted a review for this appointment.");
        } else {
          HelperMethods.showCustomSnackbar(context, message: "Something went wrong");
        }
      }
    } catch (e) {
      HelperMethods.showCustomSnackbar(context, message: "Failed to submit review");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.white,
      appBar: CustomAppBar(title: 'Review'),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.transparent,
                      child: CustomImageView(
                        imagePath: '${AppUrl.baseUrl}/${widget.profileImage}',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "How was your experience with\n${widget.consultantName}?",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          onPressed: () => setRating(index + 1),
                          icon: Icon(
                            index < selectedRating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.orange,
                            size: 32,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: TextField(
                        controller: _reviewController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Write your review...",
                          hintStyle: TextStyle(color: ColorResource.primaryBlue),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CustomAppButton(
                label: 'Cancel',
                onPressed: () => navPop(context: context),
                textColor: Colors.grey,
                color: ColorResource.white,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomAppButton(
                label: 'Submit',
                onPressed: _submitReview,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
