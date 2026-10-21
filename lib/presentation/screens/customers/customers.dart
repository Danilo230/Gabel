import 'package:flutter/material.dart';
import 'package:gabel/presentation/screens/customers/widgets/customer_add_modal.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_pagination.dart';
import '../../widgets/custom_filter_dropdown.dart';
import '../../widgets/custom_filter_modal.dart';
import '../../widgets/search_bar_add.dart';
import 'models/customer.dart';
import '../../theme/app_colors.dart';
import 'widgets/customer_card.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  static const List<String> status = ['Activo', 'Inactivo'];
  String selectedStatus = status.first;

  void _openFilterModal() {
    CustomFilterModal.show(
      context,
      title: 'Filtrar Clientes',
      builder: (modalContext, setModalState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFilterDropdown(
              label: 'Estado',
              value: selectedStatus,
              items: status,
              onChanged: (val) {
                if (val != null) {
                  setModalState(() => selectedStatus = val);
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      },
      onApply: () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgtextColor,
      appBar: const AppHeader(title: 'Catalógo de Clientes'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Column(
            children: [
              SearchBarAdd(
                onAddPressed: () {
                  NewCustomerModal.show(context);
                },
                onFilterPressed: _openFilterModal,
              ),
              SizedBox(height: 12),
              CustomerCard(
                customer: const Customer(
                  customerName: 'Juan',
                  customerLastName: 'Pérez',
                  customerPhone: '+505 88923213',
                  customerStatus: 'Activo',
                ),
              ),
              SizedBox(height: 12),
              CustomerCard(
                customer: Customer(
                  customerName: 'María',
                  customerLastName: 'González',
                  customerPhone: '+505 88923214',
                  customerStatus: 'Activo',
                ),
              ),

              SizedBox(height: 12),
              CustomerCard(
                customer: Customer(
                  customerName: 'Carlos',
                  customerLastName: 'Ramírez',
                  customerPhone: '+505 88923215',
                  customerStatus: 'Activo',
                ),
              ),
              SizedBox(height: 12),
              CustomerCard(
                customer: const Customer(
                  customerName: 'Juan',
                  customerLastName: 'Pérez',
                  customerPhone: '+505 88923213',
                  customerStatus: 'Activo',
                ),
              ),
              SizedBox(height: 12),
              CustomPagination(currentPage: 3),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(activeTab: 'Clientes'),
    );
  }
}
