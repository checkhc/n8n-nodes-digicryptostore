#!/bin/bash
# Script d'installation des nodes n8n refactorés
# DigiCryptoStore + SolMemo

set -e  # Exit on error

echo "🚀 Installation des nodes n8n refactorés"
echo "========================================"
echo ""

# Étape 1: Copier le fichier DigiCryptoStore corrigé
echo "📋 Étape 1/6: Copie du fichier DigiCryptoStore corrigé..."
cd /home/greg/n8n/n8n-nodes-digicryptostore/nodes/DigiCryptoStore
cp -v DigiCryptoStore.node.OLD_BEFORE_UNIFY.ts DigiCryptoStore.node.ts
echo "✅ Fichier copié"
echo ""

# Étape 2: Vérification TypeScript
echo "🔍 Étape 2/6: Vérification TypeScript..."
cd /home/greg/n8n/n8n-nodes-digicryptostore
yarn tsc --noEmit
echo "✅ TypeScript OK"
echo ""

# Étape 3: Build
echo "🔨 Étape 3/6: Build du package..."
yarn build
echo "✅ Build terminé"
echo ""

# Étape 4: Packaging
echo "📦 Étape 4/6: Création du package .tgz..."
npm pack
TGZ_FILE=$(ls -t n8n-nodes-digicryptostore-*.tgz | head -1)
echo "✅ Package créé: $TGZ_FILE"
echo ""

# Étape 5: Installation dans n8n
echo "💾 Étape 5/6: Installation dans n8n..."
cp -v "$TGZ_FILE" /home/greg/.n8n/nodes/
cd /home/greg/.n8n/nodes
npm install "./$TGZ_FILE"
echo "✅ Installation terminée"
echo ""

# Étape 6: Résumé
echo "🎉 Étape 6/6: Installation complète!"
echo "========================================"
echo ""
echo "📋 Modifications appliquées:"
echo "  ✅ SolMemo: 2 operations (Create Memo, List Memos)"
echo "  ✅ SolMemo: Nouveau champ Certification Mode (3 choix)"
echo "  ✅ DigiCryptoStore: B2B Certify Full + List NFTs"
echo "  ✅ DigiCryptoStore: Champs interdits supprimés"
echo "  ✅ DigiCryptoStore: Upload intégré dans B2B"
echo ""
echo "⚠️  PROCHAINE ÉTAPE:"
echo "  Redémarrer n8n avec: ./scripts/manage-dev.sh restart"
echo "  OU: pm2 restart n8n"
echo ""
echo "📖 Tests recommandés:"
echo "  - SolMemo: Tester les 3 modes de certification"
echo "  - DigiCryptoStore: Tester B2B Certify Full"
echo "  - DigiCryptoStore: Tester List NFTs"
echo ""
