import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/directory_category.dart';
import '../models/directory_profile.dart';
import '../models/profile_contact.dart';
import '../models/profile_location.dart';
import '../models/profile_social.dart';
import 'dio_provider.dart';

final directoryCategoriesProvider =
    FutureProvider<List<DirectoryCategory>>((ref) async {
  ref.keepAlive();
  final repo = ref.read(directoryRepositoryProvider);
  final response = await repo.getCategories();
  return response.data ?? [];
});

final directoryProfilesProvider =
    FutureProvider<List<DirectoryProfile>>((ref) async {
  ref.keepAlive();
  final repo = ref.read(directoryRepositoryProvider);
  final response = await repo.getProfiles();
  return response.data ?? [];
});

final featuredProfilesProvider =
    Provider<AsyncValue<List<DirectoryProfile>>>((ref) {
  return ref.watch(directoryProfilesProvider).whenData(
        (profiles) => profiles.where((p) => p.planTier == 'standard' || p.planTier == 'premium').toList(),
      );
});

// Provider dedicado para el Home: llama al endpoint filtrado en el servidor.
// Solo descarga los destacados (max 10), sin cargar toda la colección.
final featuredProfilesHomeProvider = FutureProvider<List<DirectoryProfile>>((ref) async {
  ref.keepAlive();
  final repo = ref.read(directoryRepositoryProvider);
  final response = await repo.getFeaturedProfiles(limit: 10);
  return response.data ?? [];
});

final profileByIdProvider =
    FutureProvider.family<DirectoryProfile?, int>((ref, id) async {
  final repo = ref.read(directoryRepositoryProvider);
  final response = await repo.getProfileById(id);
  return response.data;
});

final profileContactsProvider =
    FutureProvider<List<ProfileContact>>((ref) async {
  final repo = ref.read(directoryRepositoryProvider);
  final response = await repo.getProfileContacts();
  return response.data ?? [];
});

final profileLocationsProvider =
    FutureProvider<List<ProfileLocation>>((ref) async {
  final repo = ref.read(directoryRepositoryProvider);
  final response = await repo.getProfileLocations();
  return response.data ?? [];
});

final profileSocialsProvider =
    FutureProvider<List<ProfileSocial>>((ref) async {
  final repo = ref.read(directoryRepositoryProvider);
  final response = await repo.getProfileSocials();
  return response.data ?? [];
});

final profileContactsByIdProvider =
    Provider.family<AsyncValue<List<ProfileContact>>, int>((ref, profileId) {
  return ref.watch(profileContactsProvider).whenData(
        (contacts) =>
            contacts.where((c) => c.profileId == profileId).toList(),
      );
});

final profileLocationsByIdProvider =
    Provider.family<AsyncValue<List<ProfileLocation>>, int>((ref, profileId) {
  return ref.watch(profileLocationsProvider).whenData(
        (locations) =>
            locations.where((l) => l.profileId == profileId).toList(),
      );
});

final profileSocialsByIdProvider =
    Provider.family<AsyncValue<List<ProfileSocial>>, int>((ref, profileId) {
  return ref.watch(profileSocialsProvider).whenData(
        (socials) =>
            socials.where((s) => s.profileId == profileId).toList(),
      );
});

final profilesByCategoryProvider =
    Provider.family<AsyncValue<List<DirectoryProfile>>, int>((ref, categoryId) {
  return ref.watch(directoryProfilesProvider).whenData(
        (profiles) =>
            profiles.where((p) => p.categoryId == categoryId).toList(),
      );
});
