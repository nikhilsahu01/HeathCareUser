import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/search_viewmodel.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController searchController =
  TextEditingController();

  Timer? _debouncer;

  @override
  void dispose() {

    searchController.dispose();

    _debouncer?.cancel();

    super.dispose();
  }

  /// ===========================
  /// DEBOUNCER SEARCH
  /// ===========================

  void _onSearchChanged(String value) {

    /// Cancel previous timer
    if (_debouncer?.isActive ?? false) {
      _debouncer!.cancel();
    }

    /// Start new timer
    _debouncer = Timer(
      const Duration(milliseconds: 700),
          () {

        context.read<SearchViewModel>().search(value);

      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(

      create: (_) => SearchViewModel(),

      child: Scaffold(

        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                controller: searchController,
                autofocus: true,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: "Search doctors, services...",
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                    onPressed: () {

                      searchController.clear();

                      context
                          .read<SearchViewModel>()
                          .search('');

                      setState(() {});
                    },
                    icon: const Icon(Icons.close),
                  )
                      : null,
                ),
              ),
            ),
          ),
        ),

        body: Consumer<SearchViewModel>(

          builder: (context, provider, child) {

            /// ===========================
            /// LOADING
            /// ===========================

            if (provider.isLoading) {

              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            /// ===========================
            /// EMPTY STATE
            /// ===========================

            if (provider.searchResults.isEmpty) {

              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(
                      Icons.search_off,
                      size: 80,
                      color: Colors.grey,
                    ),

                    SizedBox(height: 12),

                    Text(
                      "No Results Found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }

            /// ===========================
            /// SEARCH LIST
            /// ===========================

            return ListView.separated(

              padding: const EdgeInsets.all(16),

              itemCount: provider.searchResults.length,

              separatorBuilder: (_, __) =>
              const SizedBox(height: 12),

              itemBuilder: (context, index) {

                final item =
                provider.searchResults[index];

                return InkWell(

                  borderRadius: BorderRadius.circular(16),

                  onTap: () {

                    /// Navigate to details screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Clicked on ${item.title}",
                        ),
                      ),
                    );
                  },

                  child: Container(

                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(16),

                      boxShadow: [

                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Row(

                      children: [

                        CircleAvatar(
                          radius: 26,
                          backgroundColor:
                          Colors.blue.shade50,
                          child: Icon(
                            item.icon,
                            color: Colors.blue,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                item.subtitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}