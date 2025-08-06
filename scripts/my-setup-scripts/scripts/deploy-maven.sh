#!/usr/bin/env bash

set -e  # exit on error

if [ -z "$1" ]; then
  echo "Usage: $0 <version>"
  echo "Example: $0 1.2.0"
  exit 1
fi

VERSION=$1
TAG="v$VERSION"

echo "🛠️  Starting release process for version $VERSION"

# 1. Checkout main and pull latest changes
git checkout main
git pull origin main

# 2. Bump version in pom.xml
echo "🔖 Setting version to $VERSION in pom.xml"
mvn versions:set -DnewVersion=$VERSION
mvn versions:commit

# 3. Commit and push version bump to main
git add .
git commit -m "Bump version to $VERSION"
git push origin main

# 4. Create GitHub release (tag + release notes)
echo "🏷️ Creating GitHub release $TAG on main"
gh release create $TAG --target main --title "$TAG" --notes "Release $VERSION"

# 5. Checkout develop branch
git checkout develop

# 6. Merge main into develop
echo "🔀 Merging main into develop"
git merge main

# 7. Push updated develop branch
git push origin develop

echo "✅ Release $TAG complete! Your main and develop branches are up to date."
