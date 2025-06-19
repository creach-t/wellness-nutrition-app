import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/constants/wellness_colors.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../shared/widgets/wellness_card.dart';

class ScannerPage extends ConsumerStatefulWidget {
  const ScannerPage({super.key});

  @override
  ConsumerState<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends ConsumerState<ScannerPage>
    with TickerProviderStateMixin {
  MobileScannerController? _controller;
  bool _isScanning = false;
  String? _lastScannedCode;
  
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initializeScanner();
    _initializeAnimations();
  }

  void _initializeScanner() {
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: [BarcodeFormat.ean13, BarcodeFormat.ean8],
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller?.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Scanner principal
          if (_controller != null)
            MobileScanner(
              controller: _controller!,
              onDetect: _onBarcodeDetected,
              errorBuilder: (context, error, child) {
                return _buildErrorView(error);
              },
            ),
          
          // Overlay de guidage
          _buildScannerOverlay(),
          
          // Header
          _buildHeader(),
          
          // Instructions en bas
          _buildInstructions(),
          
          // État de scan
          if (_isScanning) _buildScanningIndicator(),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(
            color: WellnessColors.primaryBlue,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            // Coins animés
            ..._buildAnimatedCorners(),
            
            // Zone de scan
            Center(
              child: AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 4,
                      height: 100,
                      decoration: BoxDecoration(
                        color: WellnessColors.primaryBlue.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAnimatedCorners() {
    return [
      // Coin haut gauche
      Positioned(
        top: -3,
        left: -3,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: WellnessColors.primaryBlue,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
            ),
          ),
        ),
      ),
      // Coin haut droit
      Positioned(
        top: -3,
        right: -3,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: WellnessColors.primaryBlue,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
            ),
          ),
        ),
      ),
      // Coin bas gauche
      Positioned(
        bottom: -3,
        left: -3,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: WellnessColors.primaryBlue,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
          ),
        ),
      ),
      // Coin bas droit
      Positioned(
        bottom: -3,
        right: -3,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: WellnessColors.primaryBlue,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(25),
              ),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(25),
              ),
              child: IconButton(
                onPressed: _toggleFlash,
                icon: Icon(
                  _controller?.torchEnabled == true 
                      ? Icons.flash_on 
                      : Icons.flash_off,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '📱 Placez doucement le code-barres dans le cadre',
                  style: WellnessTextStyles.bodyText.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Nous allons découvrir ensemble ce produit avec bienveillance ✨',
                  style: WellnessTextStyles.bodyTextSmall.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                if (_lastScannedCode != null) ...[
                  const SizedBox(height: 16),
                  WellnessButton(
                    onPressed: () => _showProductDetails(_lastScannedCode!),
                    style: WellnessButtonStyle.soft,
                    child: Text('Voir le dernier produit scanné'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScanningIndicator() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                WellnessColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Recherche du produit...',
              style: WellnessTextStyles.bodyText.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Patience, nous préparons quelque chose de beau ! 🌟',
              style: WellnessTextStyles.bodyTextSmall.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(MobileScannerException error) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt_outlined,
                size: 64,
                color: WellnessColors.textSecondary,
              ),
              const SizedBox(height: 24),
              Text(
                'Oups ! Petit souci avec la caméra',
                style: WellnessTextStyles.heading3.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Pas de souci, nous pouvons essayer autre chose ! '
                'Vous pouvez rechercher votre produit manuellement.',
                style: WellnessTextStyles.bodyText.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              WellnessButton(
                onPressed: _retryScanner,
                icon: const Icon(Icons.refresh),
                child: const Text('Réessayer'),
              ),
              const SizedBox(height: 12),
              WellnessButton(
                onPressed: _navigateToManualSearch,
                style: WellnessButtonStyle.soft,
                child: const Text('Recherche manuelle'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBarcodeDetected(BarcodeCapture capture) async {
    if (_isScanning) return;
    
    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;

    setState(() {
      _isScanning = true;
      _lastScannedCode = barcode!.rawValue!;
    });

    // Feedback haptique doux
    // HapticFeedback.lightImpact();

    // Simulation d'un délai de recherche
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isScanning = false;
      });
      
      _showSuccessAndNavigate(barcode!.rawValue!);
    }
  }

  void _showSuccessAndNavigate(String barcode) {
    // Message d'encouragement
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 Super ! Produit trouvé avec succès'),
        backgroundColor: WellnessColors.successGentle,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    // Navigation vers les détails du produit
    _showProductDetails(barcode);
  }

  void _showProductDetails(String barcode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductDetailsBottomSheet(barcode: barcode),
    );
  }

  void _toggleFlash() {
    _controller?.toggleTorch();
    setState(() {});
  }

  void _retryScanner() {
    setState(() {
      _controller?.dispose();
      _initializeScanner();
    });
  }

  void _navigateToManualSearch() {
    // Navigation vers recherche manuelle
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🔍 Ouverture de la recherche manuelle...'),
        backgroundColor: WellnessColors.primaryBlue,
      ),
    );
  }
}

class ProductDetailsBottomSheet extends StatelessWidget {
  const ProductDetailsBottomSheet({
    super.key,
    required this.barcode,
  });

  final String barcode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: WellnessColors.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.qr_code,
                    color: WellnessColors.primaryBlue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Produit découvert !',
                        style: WellnessTextStyles.heading3,
                      ),
                      Text(
                        'Code: $barcode',
                        style: WellnessTextStyles.bodyTextSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Contenu
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  WellnessCard(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            '🌟 Bravo !',
                            style: WellnessTextStyles.heading2,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Vous venez de découvrir un nouveau produit ! '
                            'Nous analysons ses informations nutritionnelles '
                            'pour vous aider à mieux le connaître.',
                            style: WellnessTextStyles.bodyText,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          WellnessButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Navigation vers le journal
                            },
                            child: const Text('Ajouter à mon journal'),
                          ),
                        ],
                      ),
                    ),
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
