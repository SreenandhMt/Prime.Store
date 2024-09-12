import 'package:flutter/material.dart';

class FooterScreen extends StatefulWidget {
  const FooterScreen({super.key});

  @override
  State<FooterScreen> createState() => _FooterScreenState();
}

class _FooterScreenState extends State<FooterScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
              const Divider(height: 1,color: Colors.black26),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFeature(Icons.verified, 'Premium Quality', 'All the clothing products are made from 100% premium quality fabric.'),
                _buildFeature(Icons.lock, 'Secure Payments', 'Highly Secured SSL-Protected Payment Gateway.'),
                _buildFeature(Icons.refresh, '7 Days Return', 'Return or exchange the orders within 7 days of delivery.'),
              ],
            ),
          ),
          // Footer Information
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: size.width>=1000?CrossAxisAlignment.center:CrossAxisAlignment.start,
              children: [
               if(size.width>=1000)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Registered Office Address
                    _buildFooterColumn(
                      'REGISTERED OFFICE ADDRESS',
                      [
                        'Prime Store Pvt Ltd',
                        'Lotus Corporate Park Wing G02 - 1502,',
                        'Ram Mandir Lane, off Western Express',
                        'Highway, Goregaon, Mumbai, 400063',
                      ],
                    ),
                    
                    // Useful Links
                    _buildFooterColumn(
                      'USEFUL LINKS',
                      [
                        'About Us',
                        'Shipping Policy',
                        'Privacy Policy',
                        'Affiliate Programme',
                        'Sitemap',
                      ],
                    ),
                    
                    // Categories
                    _buildFooterColumn(
                      'CATEGORIES',
                      [
                        'T-Shirts',
                        'Shirts',
                        'Bottoms',
                        'Jacket',
                        'Co-ords',
                        'Electronics',

                      ],
                    ),
                    
                    // Support
                    _buildFooterColumn(
                      'SUPPORT',
                      [
                        'Mail: support@primestore.in',
                        'Phone: +91 956-6333-000',
                      ],
                    ),
                  ],
                )else Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Registered Office Address
                    _buildFooterColumn(
                      'REGISTERED OFFICE ADDRESS',
                      [
                        'Prime Store Pvt Ltd',
                        'Lotus Corporate Park Wing G02 - 1502,',
                        'Ram Mandir Lane, off Western Express',
                        'Highway, Goregaon, Mumbai, 400063',
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Useful Links
                    _buildFooterColumn(
                      'USEFUL LINKS',
                      [
                        'About Us | Shipping Policy | Privacy Policy | Affiliate Programme | Sitemap'
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Categories
                    _buildFooterColumn(
                      'CATEGORIES',
                      [
                        'T-Shirts | Shirts | Bottoms | Jacket | Co-ords | Electronics',
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Support
                    _buildFooterColumn(
                      'SUPPORT',
                      [
                        'Mail: support@primestore.in',
                        'Phone: +91 956-6333-000',
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Payment Methods & Social Media
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('100% Secure Payment'),
                    Row(
                      children: [
                        Image.network('https://www.powerlook.in/icons/payments-logo.svg?aio=w-256', height: 20),
                      ],
                    ),
                    const Row(
                      children: [
                        Icon(Icons.facebook, color: Colors.blue),
                        SizedBox(width: 10),
                        Icon(Icons.camera, color: Colors.pink),
                        SizedBox(width: 10),
                        Icon(Icons.wallet, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String title, String description) {
    final size = MediaQuery.of(context).size;
    if(size.width<=1000)
    {
      return Column(
      children: [
        Icon(icon, size: 40),
        const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
    }
    return Row(
      children: [
        Icon(icon, size: 40),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        SizedBox(width: size.width*0.15,child: Text(description, textAlign: TextAlign.start)),
          ],
        )
      ],
    );
  }

  Widget _buildFooterColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...items.map((item) => Text(item)).toList(),
      ],
    );
  }
}
