import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'error_view.dart';
import 'loading_view.dart';

// visor de un reporte de Power BI publicado en la web

class PowerBiView extends StatefulWidget {
  final String url;

  const PowerBiView({super.key, required this.url});

  @override
  State<PowerBiView> createState() => _PowerBiViewState();
}

class _PowerBiViewState extends State<PowerBiView> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (!mounted) return;
            setState(() {
              _isLoading = true;
              _error = null;
            });
          },
          onPageFinished: (_) {
            if (!mounted) return;
            setState(() => _isLoading = false);
          },
          onWebResourceError: (error) {
            if (!mounted || !(error.isForMainFrame ?? true)) return;
            setState(() {
              _isLoading = false;
              _error = 'No se pudo cargar el reporte. Revisa tu conexión a internet.';
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _reload() {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return ErrorView(errorMessage: _error!, onRetry: _reload);
    }

    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          const ColoredBox(
            color: Colors.white,
            child: LoadingView(message: 'Cargando reporte...'),
          ),
      ],
    );
  }
}