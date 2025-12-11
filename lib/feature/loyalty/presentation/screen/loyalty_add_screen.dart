import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/util/my_dimens.dart';
import 'package:hello_bazar/feature/loyalty/presentation/widget/loyalty_add_widgets/loyalty_add_submit_button.dart';
import 'package:hello_bazar/feature/loyalty/presentation/widget/loyalty_add_widgets/loyalty_add_summary_details.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class LoyaltyAddScreen extends StatefulWidget {
  const LoyaltyAddScreen({super.key});
  @override
  State<LoyaltyAddScreen> createState() => _LoyaltyAddScreenState();
}

class _LoyaltyAddScreenState extends State<LoyaltyAddScreen> {
  final _numberController = TextEditingController();
  final _totalController = TextEditingController();
  final _loyaltyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _numberController.addListener(_updateUI);
    _totalController.addListener(_updateUI);
    _loyaltyController.addListener(_updateUI);
  }

  void _updateUI() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyDimens().getNormalAppBar("Add User Loyalty", [], context, true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Customer Number",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8.h),
              CmNumberField(
                controller: _numberController,
                label: "01XXXXXXXXXX",
                showSpeechButton: true,
                onSpeechResult: _updateUI,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.h),
              Text("Total", style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 8.h),
              CmNumberField(
                controller: _totalController,
                label: "৳ ..................",
                showSpeechButton: true,
                onSpeechResult: _updateUI,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24.h),
              LoyaltyAddSummaryDetails(
                loyaltyController: _loyaltyController,
                getSubTotal: _getSubTotal,
                getGrandTotal: _getGrandTotal,
              ),
              SizedBox(height: 30.h),
              LoyaltyAddSubmitButton(
                numberController: _numberController,
                totalController: _totalController,
                loyaltyController: _loyaltyController,
                getSubTotal: double.parse(_getSubTotal),
                getGrandTotal: double.parse(_getGrandTotal),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _getSubTotal {
    final total = double.tryParse(_totalController.text.trim()) ?? 0.0;
    return total.toStringAsFixed(2);
  }

  String get _getGrandTotal {
    final total = double.tryParse(_totalController.text.trim()) ?? 0.0;
    final loyalty = double.tryParse(_loyaltyController.text.trim()) ?? 0.0;
    final grandTotal = total - loyalty;
    return grandTotal.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _numberController.removeListener(_updateUI);
    _totalController.removeListener(_updateUI);
    _loyaltyController.removeListener(_updateUI);
    _numberController.dispose();
    _totalController.dispose();
    _loyaltyController.dispose();
    super.dispose();
  }
}

class SpeechService {
  static final stt.SpeechToText _speech = stt.SpeechToText();
  static bool _isAvailable = false;
  static bool _isListening = false;

  static Future<void> initialize() async {
    _isAvailable = await _speech.initialize();
  }

  static bool get isAvailable => _isAvailable;
  static bool get isListening => _isListening;

  static Future<void> startListening({
    required Function(String text) onResult,
    required Function() onListeningStarted,
    required Function() onListeningStopped,
  }) async {
    if (!_isAvailable) return;

    await _speech.listen(
      onResult: (result) {
        if (result.finalResult) {
          onResult(result.recognizedWords);
        }
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
    );

    _isListening = true;
    onListeningStarted();
  }

  static Future<void> stopListening() async {
    await _speech.stop();
    _isListening = false;
  }

  static void dispose() {
    _speech.stop();
  }
}

class SpeechButton extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback? onSpeechResult;
  final Color? color;

  const SpeechButton({
    super.key,
    required this.controller,
    this.onSpeechResult,
    this.color,
  });

  @override
  State<SpeechButton> createState() => _SpeechButtonState();
}

class _SpeechButtonState extends State<SpeechButton> {
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    SpeechService.initialize();
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      await SpeechService.stopListening();
      setState(() => _isListening = false);
    } else {
      await SpeechService.startListening(
        onResult: (text) {
          widget.controller.text = text;
          widget.onSpeechResult?.call();
        },
        onListeningStarted: () {
          setState(() => _isListening = true);
        },
        onListeningStopped: () {
          setState(() => _isListening = false);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isListening ? Icons.mic_off : Icons.mic,
        color: widget.color ?? Theme.of(context).primaryColor,
        size: 20.w,
      ),
      onPressed: SpeechService.isAvailable ? _toggleListening : null,
      tooltip: _isListening ? 'Stop listening' : 'Start speech input',
      splashRadius: 20.w,
      padding: EdgeInsets.all(4.w),
      constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.w),
    );
  }
}

class CmNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final bool showSpeechButton;
  final VoidCallback? onSpeechResult;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  const CmNumberField({
    super.key,
    required this.controller,
    this.label,
    this.hintText,
    this.showSpeechButton = false,
    this.onSpeechResult,
    this.keyboardType = TextInputType.number,
    this.focusNode,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: showSpeechButton
            ? SpeechButton(
                controller: controller,
                onSpeechResult: onSpeechResult,
              )
            : null,
        suffixIcon: showSpeechButton
            ? null
            : IconButton(
                icon: Icon(
                  Icons.mic,
                  size: 18.w,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {
                  // Show bottom sheet with speech option
                  _showSpeechOptions(context);
                },
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5.w,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      ),
    );
  }

  void _showSpeechOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => SpeechBottomSheet(
        controller: controller,
        onSpeechResult: () {
          onSpeechResult?.call();
          Navigator.pop(context);
        },
      ),
    );
  }
}

class SpeechBottomSheet extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSpeechResult;

  const SpeechBottomSheet({
    super.key,
    required this.controller,
    required this.onSpeechResult,
  });

  @override
  State<SpeechBottomSheet> createState() => _SpeechBottomSheetState();
}

class _SpeechBottomSheetState extends State<SpeechBottomSheet> {
  bool _isListening = false;
  String _currentText = '';

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  Future<void> _initializeSpeech() async {
    await SpeechService.initialize();
  }

  Future<void> _startListening() async {
    await SpeechService.startListening(
      onResult: (text) {
        setState(() => _currentText = text);
      },
      onListeningStarted: () {
        setState(() => _isListening = true);
      },
      onListeningStopped: () {
        setState(() => _isListening = false);
      },
    );
  }

  Future<void> _stopListening() async {
    await SpeechService.stopListening();
  }

  void _applySpeechResult() {
    widget.controller.text = _currentText;
    widget.onSpeechResult();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Speech to Text',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 16.h),
          // Listening indicator
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  size: 40.w,
                  color: _isListening
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                SizedBox(height: 8.h),
                Text(
                  _isListening ? 'Listening...' : 'Tap to start',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 8.h),
                Text(
                  _currentText.isEmpty
                      ? 'Your speech will appear here'
                      : _currentText,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Cancel button
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              SizedBox(width: 12.w),
              // Start/Stop button
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_isListening) {
                      await _stopListening();
                    } else {
                      await _startListening();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isListening
                        ? Theme.of(context).colorScheme.errorContainer
                        : Theme.of(context).colorScheme.primary,
                    foregroundColor: _isListening
                        ? Theme.of(context).colorScheme.onErrorContainer
                        : Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text(_isListening ? 'Stop' : 'Start'),
                ),
              ),
            ],
          ),
          if (_currentText.isNotEmpty) ...[
            SizedBox(height: 12.h),
            ElevatedButton(
              onPressed: _applySpeechResult,
              child: const Text('Use This Text'),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    SpeechService.dispose();
    super.dispose();
  }
}
