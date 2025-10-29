# Publishing to pub.dev

Follow these steps to publish the `interactive_modal` package to pub.dev:

## Pre-Publication Checklist

### 1. Update Package Information

Edit `pubspec.yaml`:
```yaml
name: interactive_modal
description: A Flutter package for displaying interactive modals over background content while maintaining full interactivity with both.
version: 0.0.1
homepage: https://github.com/yourusername/interactive_modal
repository: https://github.com/yourusername/interactive_modal
issue_tracker: https://github.com/yourusername/interactive_modal/issues
```

### 2. Verify Package Structure

Ensure you have all required files:
```
interactive_modal/
├── lib/
│   ├── interactive_modal.dart          (main export file)
│   └── src/
│       ├── interactive_modal.dart      (main widget)
│       └── interactive_modal_controller.dart
├── test/
│   └── interactive_modal_test.dart
├── example/
│   ├── lib/
│   │   ├── main.dart
│   │   └── simple_example.dart
│   └── pubspec.yaml
├── CHANGELOG.md
├── LICENSE
├── README.md
├── pubspec.yaml
└── analysis_options.yaml
```

### 3. Test the Package

```bash
# Run tests
flutter test

# Analyze the package
flutter analyze

# Format code
dart format .

# Check package score
flutter pub publish --dry-run
```

### 4. Update Documentation

- ✅ README.md with clear examples
- ✅ API documentation in code (dartdoc comments)
- ✅ CHANGELOG.md with version history
- ✅ LICENSE file (MIT recommended)

### 5. Add Dartdoc Comments

Add documentation comments to public APIs:

```dart
/// A controller for managing the visibility state of an [InteractiveModal].
///
/// Use this controller to programmatically show, hide, or toggle the modal.
///
/// Example:
/// ```dart
/// final controller = InteractiveModalController();
/// controller.show(); // Show the modal
/// controller.hide(); // Hide the modal
/// ```
class InteractiveModalController extends ChangeNotifier {
  // ...
}
```

## Publishing Steps

### 1. Login to pub.dev

```bash
dart pub login
```

### 2. Dry Run

Test the publication process:
```bash
flutter pub publish --dry-run
```

Fix any issues reported.

### 3. Publish

```bash
flutter pub publish
```

Type 'y' to confirm.

## Post-Publication

### 1. Create Git Tag

```bash
git tag v0.0.1
git push origin v0.0.1
```

### 2. Monitor Package Health

Visit your package page:
- https://pub.dev/packages/interactive_modal
- Check the pub points score
- Review the analysis results
- Monitor for issues

### 3. Promote Your Package

- Share on social media (Twitter, Reddit, LinkedIn)
- Post on Flutter communities
- Write a blog post or tutorial
- Add examples and documentation

## Version Updates

For future versions:

1. Update version in `pubspec.yaml`
2. Update `CHANGELOG.md`
3. Commit changes
4. Create git tag
5. Run `flutter pub publish`

### Semantic Versioning

- **Patch** (0.0.X): Bug fixes
- **Minor** (0.X.0): New features, backward compatible
- **Major** (X.0.0): Breaking changes

## Common Issues

### Issue: Package score is low

**Solutions:**
- Add more examples
- Improve documentation
- Add more tests
- Support multiple platforms
- Follow Dart style guide

### Issue: Dependencies conflict

**Solutions:**
- Use flexible version constraints
- Test with different Flutter versions
- Update dependencies regularly

### Issue: Missing documentation

**Solutions:**
- Add dartdoc comments to all public APIs
- Include code examples in comments
- Update README with more examples

## Maintenance Tips

1. **Respond to Issues**: Check GitHub issues regularly
2. **Update Dependencies**: Keep dependencies up to date
3. **Add Tests**: Maintain high test coverage
4. **Follow Conventions**: Stick to Dart/Flutter best practices
5. **Version Carefully**: Don't break existing apps

## Resources

- [Publishing Packages](https://dart.dev/tools/pub/publishing)
- [Package Layout Conventions](https://dart.dev/tools/pub/package-layout)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [pub.dev Help](https://pub.dev/help)
