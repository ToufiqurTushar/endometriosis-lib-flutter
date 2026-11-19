import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rapid/flutter_rapid.dart';

import '../../config/color_config.dart';
import '../pdf_viewer/pdf_viewer_page.dart';

class ReferencesCitationsView extends StatelessWidget {
  static String routeName = '/references_citations';

  const ReferencesCitationsView({super.key});

  final List<String> references = const [
    'Chapron C, Lafay-Pillet MC, Santulli P, Bourdon M, Maignien C, Gaudet-Chardonnet A, Maitrot-Mantelet L, Borghese B, Marcellin L. A new validated screening method for endometriosis diagnosis based on patient questionnaires. EClinicalMedicine. 2022 Jan 10;44:101263.',
    'Cho HH, Yoon YS. Development of an endometriosis self-assessment tool for patient. Obstet Gynecol Sci. 2024 Jul;67(4):431-432.',
    'Fauconnier A, Drioueche H, Huchon C, Du Cheyron J, Indersie E, Candau Y, Panel P, Fritel X. Early identification of women with endometriosis by means of a simple patient-completed questionnaire screening tool: a diagnostic study. Fertil Steril. 2021 Dec;116(6):1580-1589.',
    'DiBenedetti DB, Soliman AM, Ervin C, Evans E, Coddington CC, Agarwal SK, Surrey ES, Taylor HS. Development of the Painful Periods Screening Tool for endometriosis. Postgrad Med. 2018 Nov;130(8):694-702.',
    'Yeung P, Bazinet C, Gavard JA. Development of a Symptom-Based, Screening Tool for Early-Stage Endometriosis in Patients with Chronic Pelvic Pain. Journal of Endometriosis and Pelvic Pain Disorders. 2014;6(4):174-189.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'References & Citations',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderSection(),
                const SizedBox(height: 24),
                _buildSectionTitle('Official Certificates'),
                const SizedBox(height: 12),
                _buildCertificateCard(
                  context: context,
                  title: 'BMRC Certificate',
                  subtitle: 'Bangladesh Medical Research Council',
                  pdfPath: 'assets/pdf/BMRC.pdf',
                  icon: Icons.verified_user_rounded,
                  color: Colors.teal,
                ),
                const SizedBox(height: 12),
                _buildCertificateCard(
                  context: context,
                  title: 'BBS Certificate',
                  subtitle: 'Bangladesh Bureau of Statistics',
                  pdfPath: 'assets/pdf/BBS.pdf',
                  icon: Icons.analytics_rounded,
                  color: Colors.indigo,
                ),
                const SizedBox(height: 28),
                _buildSectionTitle('5 References of Endometriosis'),
                const SizedBox(height: 12),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: references.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _buildReferenceCard(context, index + 1, references[index]);
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorConfig.textFieldIconColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorConfig.textFieldIconColor.withOpacity(0.24),
          width: 1,
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.menu_book_rounded,
            color: ColorConfig.textFieldIconColor,
            size: 36,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scientific References',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'All self-assessment screening questions and methodologies are validated based on established medical publications and certifications.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildCertificateCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String pdfPath,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            Get.to(() => PdfViewerPage(pdfPath: pdfPath, title: title));
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.picture_as_pdf_rounded, size: 16, color: color),
                      const SizedBox(width: 4),
                      const Text(
                        'View',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReferenceCard(BuildContext context, int index, String referenceText) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: ColorConfig.textFieldIconColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Ref #$index',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ColorConfig.textFieldIconColor,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy_rounded, size: 18, color: Colors.grey),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: referenceText));
                  Get.snackbar(
                    'Copied to Clipboard',
                    'Reference text copied successfully.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.black87,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                  );
                },
                tooltip: 'Copy Reference',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            referenceText,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
