import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const CustomPagination({
    super.key,
    this.currentPage = 1,
    this.totalPages = 7,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryPurple,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _arrowButton(Icons.chevron_left),
          const SizedBox(width: 4),

          for (int i = 1; i <= totalPages; i++)
            _pageNumber(i, active: i == currentPage),
          const SizedBox(width: 4),

          _arrowButton(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _pageNumber(int page, {bool active = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: active ? AppColors.mediumPurple : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      
      child: Text(
        '$page',
        style: TextStyle(
          color: AppColors.white,
          fontSize: 13,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _arrowButton(IconData icon) {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.darkPurple,
      ),
      child: Icon(icon, color: AppColors.white, size: 18),
    );
  }
}