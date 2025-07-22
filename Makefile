

get:
	flutter pub get

clean:
	flutter clean

clean-get:
	$(MAKE) clean
	$(MAKE) get

cg:
	$(MAKE) clean-get

outdated:
	flutter pub outdated

gen:
	flutter pub run build_runner build --delete-conflicting-outputs

remove-lock-files:
	rm -f ios/Podfile.lock
	rm -f pubspec.lock

routes:
	cd scripts && dart gen_routes.dart

asset:
	cd scripts && dart gen_assets.dart

view:
	cd scripts && dart gen_view.dart $(VIEW_NAME)

vm:
	cd scripts && fvm dart vm_gen.dart --open
	$(MAKE) routes

vm-no-open:
	cd scripts && fvm dart vm_gen.dart -n
	$(MAKE) routes

dvm:
	cd scripts && fvm dart delete_vm.dart
	$(MAKE) routes

deep-clean-arm:
	rm -rf ./ios/Podfile.lock
	rm -rf ./ios/Pods
	$(MAKE) clean-get
	cd ios && pod cache clean --all
	cd ios && arch -x86_64 pod install --repo-update

