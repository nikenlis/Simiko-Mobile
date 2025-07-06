import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlaceholderOrganizationItem extends StatelessWidget {
  const PlaceholderOrganizationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.black38,
            highlightColor: Colors.black87,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.black38,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.black38,
              highlightColor: Colors.black54,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 160,
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.black26,
                    ),
                  ),
                  SizedBox(height: 6,),
                  Row(
                    children: [82, 24].asMap().entries.map((e) {
                      return Container(
                        width: e.value.toDouble(),
                        height: 24,
                        margin: EdgeInsets.only(left: e.key == 0 ? 0 : 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black26,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 6,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(2, (index) {
                      return Container(
                        width: double.infinity,
                        height: 12,
                        margin: EdgeInsets.only(top: index == 0 ? 0 : 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black26,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
