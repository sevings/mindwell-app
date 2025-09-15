import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindwell_api/mindwell_api.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/profile_provider.dart';

/// A dialog for editing user profile information.
/// 
/// This dialog allows users to edit their profile text information including:
/// - Display name
/// - Bio/title
/// - Gender
/// - Country
/// - City
/// - Birthday
/// - Privacy settings
/// - Chat privacy settings
/// - Show in tops setting
/// - Daylog mode setting
class ProfileEditDialog extends ConsumerStatefulWidget {
  /// The user profile to edit
  final MwProfile profile;

  const ProfileEditDialog({
    super.key,
    required this.profile,
  });

  @override
  ConsumerState<ProfileEditDialog> createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends ConsumerState<ProfileEditDialog> {
  late final TextEditingController _showNameController;
  late final TextEditingController _titleController;
  late final TextEditingController _countryController;
  late final TextEditingController _cityController;
  late final TextEditingController _birthdayController;

  String? _selectedGender;
  String? _selectedPrivacy;
  String? _selectedChatPrivacy;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers with current profile data
    _showNameController = TextEditingController(text: widget.profile.showName ?? '');
    _titleController = TextEditingController(text: widget.profile.title ?? '');
    _countryController = TextEditingController(text: widget.profile.country ?? '');
    _cityController = TextEditingController(text: widget.profile.city ?? '');
    
    // Handle birthday - only available in MwAuthProfile
    String birthday = '';
    if (widget.profile is MwAuthProfile) {
      birthday = (widget.profile as MwAuthProfile).birthday ?? '';
    }
    _birthdayController = TextEditingController(text: birthday);
    
    // Initialize other fields with proper enum handling
    _selectedGender = widget.profile.gender?.name;
    _selectedPrivacy = widget.profile.privacy?.name;
    _selectedChatPrivacy = widget.profile.chatPrivacy?.name;
  }

  @override
  void dispose() {
    _showNameController.dispose();
    _titleController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return AlertDialog(
      title: Text(l10n.editProfile),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Name
            TextField(
              controller: _showNameController,
              decoration: InputDecoration(
                labelText: l10n.showName,
                border: const OutlineInputBorder(),
              ),
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            
            // Bio/Title
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: l10n.bio,
                border: const OutlineInputBorder(),
                hintText: l10n.bio,
              ),
              maxLines: 3,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            
            // Gender
            DropdownButtonFormField<String>(
              initialValue: _selectedGender,
              decoration: InputDecoration(
                labelText: l10n.gender,
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text(l10n.gender),
                ),
                const DropdownMenuItem<String>(
                  value: 'male',
                  child: Text('Мужской'),
                ),
                const DropdownMenuItem<String>(
                  value: 'female',
                  child: Text('Женский'),
                ),
                const DropdownMenuItem<String>(
                  value: 'notSet',
                  child: Text('Не указан'),
                ),
              ],
              onChanged: _isLoading ? null : (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 16),
            
            // Country
            TextField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: l10n.country,
                border: const OutlineInputBorder(),
              ),
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            
            // City
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: l10n.city,
                border: const OutlineInputBorder(),
              ),
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            
            // Birthday
            TextField(
              controller: _birthdayController,
              decoration: InputDecoration(
                labelText: l10n.birthday,
                border: const OutlineInputBorder(),
                hintText: 'YYYY-MM-DD',
              ),
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            
            // Privacy
            DropdownButtonFormField<String>(
              initialValue: _selectedPrivacy,
              decoration: InputDecoration(
                labelText: l10n.privacy,
                border: const OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem<String>(
                  value: 'all',
                  child: Text('Все'),
                ),
                DropdownMenuItem<String>(
                  value: 'followers',
                  child: Text('Подписчики'),
                ),
                DropdownMenuItem<String>(
                  value: 'invited',
                  child: Text('Приглашенные'),
                ),
                DropdownMenuItem<String>(
                  value: 'registered',
                  child: Text('Зарегистрированные'),
                ),
              ],
              onChanged: _isLoading ? null : (value) {
                setState(() {
                  _selectedPrivacy = value;
                });
              },
            ),
            const SizedBox(height: 16),
            
            // Chat Privacy
            DropdownButtonFormField<String>(
              initialValue: _selectedChatPrivacy,
              decoration: InputDecoration(
                labelText: l10n.chatPrivacy,
                border: const OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem<String>(
                  value: 'invited',
                  child: Text('Приглашенные'),
                ),
                DropdownMenuItem<String>(
                  value: 'followers',
                  child: Text('Подписчики'),
                ),
                DropdownMenuItem<String>(
                  value: 'friends',
                  child: Text('Друзья'),
                ),
                DropdownMenuItem<String>(
                  value: 'me',
                  child: Text('Только я'),
                ),
              ],
              onChanged: _isLoading ? null : (value) {
                setState(() {
                  _selectedChatPrivacy = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () {
            Navigator.of(context).pop();
          },
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveProfile,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.save),
        ),
      ],
    );
  }

  /// Save the profile information
  Future<void> _saveProfile() async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      final profileNotifier = ref.read(profileProvider(widget.profile.name!).notifier);
      
      await profileNotifier.updateProfileInfo(
        showName: _showNameController.text.trim(),
        privacy: _selectedPrivacy ?? 'all',
        chatPrivacy: _selectedChatPrivacy ?? 'invited',
        gender: _selectedGender,
        isDaylog: null,
        title: _titleController.text.trim().isEmpty ? null : _titleController.text.trim(),
        birthday: _birthdayController.text.trim().isEmpty ? null : _birthdayController.text.trim(),
        country: _countryController.text.trim().isEmpty ? null : _countryController.text.trim(),
        city: _cityController.text.trim().isEmpty ? null : _cityController.text.trim(),
        showInTops: null,
      );

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.save),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка при сохранении: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
