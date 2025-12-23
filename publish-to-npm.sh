#!/bin/bash
#
# Script de publication npm pour n8n-nodes-digicryptostore
# Utilisation: ./publish-to-npm.sh
#

set -e  # Exit on error

echo "🚀 Publication de n8n-nodes-digicryptostore sur npm"
echo "=================================================="
echo ""

# Check if logged in
echo "📋 Vérification authentification npm..."
if ! npm whoami > /dev/null 2>&1; then
    echo "❌ Non authentifié npm. Exécutez: npm login"
    exit 1
fi

NPM_USER=$(npm whoami)
echo "✅ Authentifié en tant que: $NPM_USER"
echo ""

# Current version
CURRENT_VERSION=$(node -p "require('./package.json').version")
echo "📦 Version actuelle: $CURRENT_VERSION"
echo ""

# Build
echo "🔨 Compilation du code..."
npm run build
echo "✅ Compilation réussie"
echo ""

# Dry run
echo "🧪 Test de packaging (dry-run)..."
npm pack --dry-run > /dev/null
echo "✅ Package valide"
echo ""

# Show what will be published
echo "📂 Fichiers qui seront publiés:"
npm pack --dry-run 2>&1 | grep -E "\.(js|json|md)$" | head -20
echo ""

# Confirmation
read -p "🤔 Publier n8n-nodes-digicryptostore@$CURRENT_VERSION sur npm public ? (y/N) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Publication annulée"
    exit 1
fi

# Publish
echo ""
echo "📤 Publication en cours..."
npm publish --access public

echo ""
echo "=================================================="
echo "✅ PUBLICATION RÉUSSIE!"
echo "=================================================="
echo ""
echo "📦 Package: n8n-nodes-digicryptostore@$CURRENT_VERSION"
echo "🌐 URL: https://www.npmjs.com/package/n8n-nodes-digicryptostore"
echo ""
echo "⏳ Attendre 2-5 minutes pour indexation npm"
echo ""
echo "📋 Prochaines étapes:"
echo "  1. Vérifier sur npmjs.com"
echo "  2. Annoncer sur Discord"
echo "  3. Tweet/LinkedIn post"
echo "  4. Monitorer downloads"
echo ""
echo "🎉 Félicitations!"
