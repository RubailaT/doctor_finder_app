import 'package:doctor_finder_app/components/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DoctorCardShimmer extends StatelessWidget {
  const DoctorCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (_, __) => kHeight(10),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // Avatar shimmer
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              const SizedBox(width: 16),
              // Text shimmer
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 14, width: 150, color: Colors.grey),
                    const SizedBox(height: 8),
                    Container(height: 12, width: 100, color: Colors.grey),
                    const SizedBox(height: 8),
                    Container(height: 12, width: 80, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
