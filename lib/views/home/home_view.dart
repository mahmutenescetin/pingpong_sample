import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pingpong_sample/common/view_model_builder.dart';
import 'package:pingpong_sample/providers/connectivity_provider.dart';
import 'package:pingpong_sample/services/local/shared_preference_service.dart';
import 'package:pingpong_sample/utils/extensions/object_extensions.dart';
import 'package:pingpong_sample/utils/locator.dart';
import 'package:pingpong_sample/views/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pingpong_sample/common/widgets/reusable_text.dart';
import 'package:pingpong_sample/common/widgets/reusable_custom_progress.dart';
import 'package:pingpong_sample/utils/extensions/context_extensions.dart';
import 'package:pingpong_sample/common/widgets/custom_app_bar.dart';
import 'package:pingpong_sample/common/widgets/custom_banner.dart';
import 'package:pingpong_sample/common/widgets/category_tab_bar.dart';
import 'package:pingpong_sample/common/widgets/product_card.dart';
import 'package:pingpong_sample/common/widgets/custom_bottom_nav_bar.dart';
import 'package:pingpong_sample/views/login/login_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, connectivityProvider, _) {
        final isOnline = connectivityProvider.isOnline;
        return ViewModelBuilder<HomeViewModel>(
          initViewModel: () =>
              HomeViewModel(locator<SharedPreferenceService>()),
          builder: (context, viewModel) {
            if (viewModel.lastIsOnline != isOnline) {
              viewModel.lastIsOnline = isOnline;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                viewModel.fetchActivity(isOnline: isOnline);
              });
            }
            if (!viewModel.isLoaded || viewModel.isBusy) {
              return const Scaffold(
                body: Center(child: ReusableCustomProgress()),
              );
            }
            if (viewModel.activity.isNull || viewModel.activity.isEmpty) {
              return Scaffold(
                body: Center(
                  child: ReusableText(
                    'Hiç etkinlik yok veya çevrimdışısınız. Son veri bulunamadı.',
                    style: context.textStyles.body.b16Regular,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            final categories = <String>{'Hepsi'};
            for (final item in viewModel.activity) {
              if (item['category'] != null &&
                  item['category'].toString().isNotEmpty) {
                categories.add(item['category'].toString());
              }
            }
            final categoriesList = categories.toList();
            final selectedCategoryName =
                viewModel.selectedCategoryName.isNotEmpty
                ? viewModel.selectedCategoryName
                : categoriesList[0];

            final filteredActivities = selectedCategoryName == 'Hepsi'
                ? viewModel.activity
                : viewModel.activity
                      .where((a) => a['category'] == selectedCategoryName)
                      .toList();

            return Scaffold(
              backgroundColor: Colors.grey.shade50,
              appBar: CustomAppBar(
                userName: FirebaseAuth.instance.currentUser!.email ?? '',
                userImageUrl: null,
                subtitle: 'Aradığın etkinliği bul',
                onLogout: viewModel.logOut,
              ),
              body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  CustomBanner(
                    title: '%30’a yakın indirim',
                    description:
                        'Daha çok etkinlik ve\ndaha fazla indirim kazan.',
                    buttonText: 'Teklifi al!',
                    imageUrl:
                        filteredActivities.isNotEmpty &&
                            filteredActivities[0]['image'] != null
                        ? filteredActivities[0]['image']
                        : 'https://randomuser.me/api/portraits/women/45.jpg',
                    onButtonTap: () {},
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        'Kategoriler',
                        style: context.textStyles.title.t18Semibold,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: ReusableText(
                          'Tümünü gör',
                          style: context.textStyles.textLink.tl16Medium
                              .copyWith(color: Colors.purple),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  CategoryTabBar(
                    categories: categoriesList,
                    selectedIndex: categoriesList.indexOf(selectedCategoryName),
                    onCategorySelected: (index) {
                      viewModel.setCategory(categoriesList[index]);
                    },
                  ),
                  const SizedBox(height: 20),
                  filteredActivities.isEmpty
                      ? Center(
                          child: ReusableText(
                            'Bu kategoride etkinlik bulunamadı',
                            style: context.textStyles.body.b16Regular,
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredActivities.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.7,
                              ),
                          itemBuilder: (context, index) {
                            final activity = filteredActivities[index];
                            final image =
                                'https://c7.alamy.com/comp/2H6A4NF/live-music-festival-event-poster-with-guitar-saxophone-and-keyboards-concert-flyer-flat-design-with-musical-instruments-vector-template-2H6A4NF.jpg';
                            final title = activity['title'] ?? '';
                            final description = activity['description'] ?? '';
                            final price = activity['price']?.toString() ?? '₺0';
                            final isFavorite =
                                viewModel.localFavorites[index] ?? false;
                            return ProductCard(
                              imageUrl: image,
                              title: title,
                              description: description,
                              price: price,

                              isFavorite: isFavorite,
                              onFavoriteTap: () {
                                viewModel.toggleFavorite(index);
                              },
                              onTap: () {},
                            );
                          },
                        ),
                ],
              ),
              bottomNavigationBar: CustomBottomNavBar(
                currentIndex: viewModel.bottomNavIndex,
                onTap: (index) {
                  viewModel.setBottomNavIndex(index);
                },
              ),
            );
          },
        );
      },
    );
  }
}
