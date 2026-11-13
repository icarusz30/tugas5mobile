import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'faizal_tugas 5',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF4F6F52),
        scaffoldBackgroundColor: const Color(0xFFF7F5EF),
        useMaterial3: true,
      ),
      home: const FoodPage(),
    );
  }
}

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  final List<Map<String, dynamic>> makanan = [
    {
      'gambar':
          'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800',
      'nama': 'Nasi Goreng',
      'harga': 18000,
      'deskripsi': 'Nasi goreng hangat dengan telur dan ayam.',
    },
    {
      'gambar':
          'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=800',
      'nama': 'Mie Goreng',
      'harga': 15000,
      'deskripsi': 'Mie goreng dengan sayuran dan bumbu pilihan.',
    },
    {
      'gambar':
          'https://images.unsplash.com/photo-1529563021893-cc83c992d75d?w=800',
      'nama': 'Sate Ayam',
      'harga': 22000,
      'deskripsi': 'Sate ayam lembut dengan saus kacang.',
    },
    {
      'gambar':
          'https://images.unsplash.com/photo-1547592180-85f173990554?w=800',
      'nama': 'Rendang',
      'harga': 25000,
      'deskripsi': 'Daging sapi empuk dengan rempah khas Indonesia.',
    },
    {
      'gambar':
          'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=800',
      'nama': 'Bakso',
      'harga': 15000,
      'deskripsi': 'Bakso sapi dengan kuah hangat dan mie.',
    },
    {
      'gambar':
          'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=800',
      'nama': 'Ayam Geprek',
      'harga': 17000,
      'deskripsi': 'Ayam renyah dengan sambal yang gurih dan pedas.',
    },
    {
      'gambar':
          'https://images.unsplash.com/photo-1547592180-85f173990554?w=800',
      'nama': 'Soto Ayam',
      'harga': 16000,
      'deskripsi': 'Soto ayam berkuah segar dengan nasi.',
    },
    {
      'gambar':
          'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800',
      'nama': 'Martabak Manis',
      'harga': 20000,
      'deskripsi': 'Martabak lembut dengan cokelat dan keju.',
    },
  ];

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset >= 300 && !_showBackToTopButton) {
        setState(() {
          _showBackToTopButton = true;
        });
      } else if (_scrollController.offset < 300 && _showBackToTopButton) {
        setState(() {
          _showBackToTopButton = false;
        });
      }
    });
  }

  Future<void> _refreshFoods() async {
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Daftar makanan sudah diperbarui!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Makanan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF365A40),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF4F6F52),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Makan enak, yuk!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Ada ' +
                              makanan.length.toString() +
                              ' menu untuk dipilih hari ini.',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.restaurant_menu,
                    color: Color(0xFFFFD166),
                    size: 42,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Menu pilihan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    makanan.length.toString() + ' makanan',
                    style: const TextStyle(
                      color: Color(0xFF77766F),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshFoods,
                color: const Color(0xFF4F6F52),
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                  itemCount: makanan.length,
                  itemBuilder: (context, index) {
                    final food = makanan[index];
                    final String gambar = food['gambar'];
                    final String nama = food['nama'];
                    final int harga = food['harga'];
                    final String deskripsi = food['deskripsi'];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 2,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            gambar,
                            height: 170,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 170,
                                width: double.infinity,
                                color: const Color(0xFFE8E7DF),
                                child: const Icon(
                                  Icons.restaurant,
                                  size: 52,
                                  color: Color(0xFF8C9386),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nama,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  deskripsi,
                                  style: const TextStyle(
                                    color: Color(0xFF6F716B),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEAF0E6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.local_offer,
                                        color: Color(0xFF4F6F52),
                                        size: 18,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Rp ' +
                                            (harga ~/ 1000).toString() +
                                            '.000',
                                        style: const TextStyle(
                                          color: Color(0xFF365A40),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: const Color(0xFFFFD166),
              foregroundColor: const Color(0xFF365A40),
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }
}