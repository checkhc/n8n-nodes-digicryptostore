#!/bin/bash
# Script de nettoyage et installation des nodes n8n refactorés
# DigiCryptoStore + SolMemo

set -e  # Exit on error

echo "🧹 NETTOYAGE ET INSTALLATION - Nodes n8n refactorés"
echo "===================================================="
echo ""

# ============================================
# PHASE 1: NETTOYAGE
# ============================================
echo "🧹 PHASE 1/3: NETTOYAGE COMPLET"
echo "================================"
echo ""

# 1.1: Nettoyage du répertoire de build
echo "📂 1.1: Nettoyage du répertoire de build..."
cd /home/greg/n8n/n8n-nodes-digicryptostore
if [ -d "dist" ]; then
    rm -rf dist
    echo "  ✅ dist/ supprimé"
else
    echo "  ℹ️  dist/ n'existe pas"
fi

# 1.2: Nettoyage des anciens packages .tgz
echo "📦 1.2: Suppression des anciens .tgz..."
rm -f n8n-nodes-digicryptostore-*.tgz
echo "  ✅ Anciens .tgz supprimés"

# 1.3: Nettoyage de node_modules (optionnel mais recommandé)
echo "📚 1.3: Nettoyage node_modules du package..."
if [ -d "node_modules" ]; then
    rm -rf node_modules
    echo "  ✅ node_modules/ supprimé"
    yarn install
    echo "  ✅ node_modules réinstallé proprement"
else
    echo "  ℹ️  node_modules/ n'existe pas"
fi

# 1.4: Nettoyage de l'installation n8n
echo "🗑️  1.4: Nettoyage de l'installation n8n..."
cd /home/greg/.n8n/nodes

# Supprimer les anciens .tgz
if ls n8n-nodes-digicryptostore-*.tgz 1> /dev/null 2>&1; then
    rm -f n8n-nodes-digicryptostore-*.tgz
    echo "  ✅ Anciens .tgz n8n supprimés"
else
    echo "  ℹ️  Pas d'anciens .tgz n8n"
fi

# Supprimer le module installé
if [ -d "node_modules/n8n-nodes-digicryptostore" ]; then
    rm -rf node_modules/n8n-nodes-digicryptostore
    echo "  ✅ Module n8n-nodes-digicryptostore supprimé"
else
    echo "  ℹ️  Module n8n-nodes-digicryptostore non installé"
fi

# Nettoyer package-lock.json
if [ -f "package-lock.json" ]; then
    rm -f package-lock.json
    echo "  ✅ package-lock.json supprimé"
fi

echo ""
echo "✅ PHASE 1 TERMINÉE: Nettoyage complet effectué"
echo ""

# ============================================
# PHASE 2: PRÉPARATION ET BUILD
# ============================================
echo "🔨 PHASE 2/3: PRÉPARATION ET BUILD"
echo "==================================="
echo ""

# 2.1: Copier le fichier DigiCryptoStore corrigé
echo "📋 2.1: Copie du fichier DigiCryptoStore corrigé..."
cd /home/greg/n8n/n8n-nodes-digicryptostore/nodes/DigiCryptoStore
cp -v DigiCryptoStore.node.OLD_BEFORE_UNIFY.ts DigiCryptoStore.node.ts
echo "  ✅ Fichier copié"
echo ""

# 2.2: Vérification TypeScript
echo "🔍 2.2: Vérification TypeScript..."
cd /home/greg/n8n/n8n-nodes-digicryptostore
yarn tsc --noEmit
echo "  ✅ TypeScript OK - Aucune erreur de compilation"
echo ""

# 2.3: Build
echo "🔨 2.3: Build du package..."
yarn build
echo "  ✅ Build terminé avec succès"
echo ""

# 2.4: Packaging
echo "📦 2.4: Création du package .tgz..."
npm pack
TGZ_FILE=$(ls -t n8n-nodes-digicryptostore-*.tgz | head -1)
echo "  ✅ Package créé: $TGZ_FILE"
echo ""

echo "✅ PHASE 2 TERMINÉE: Build et packaging réussis"
echo ""

# ============================================
# PHASE 3: INSTALLATION
# ============================================
echo "💾 PHASE 3/3: INSTALLATION DANS N8N"
echo "===================================="
echo ""

# 3.1: Copier le package
echo "📥 3.1: Copie du package vers n8n..."
cp -v "$TGZ_FILE" /home/greg/.n8n/nodes/
echo "  ✅ Package copié"
echo ""

# 3.2: Installation
echo "🔧 3.2: Installation du package dans n8n..."
cd /home/greg/.n8n/nodes
npm install "./$TGZ_FILE"
echo "  ✅ Installation terminée"
echo ""

echo "✅ PHASE 3 TERMINÉE: Installation dans n8n réussie"
echo ""

# ============================================
# RÉSUMÉ FINAL
# ============================================
echo "🎉 INSTALLATION COMPLÈTE!"
echo "========================="
echo ""
echo "📊 Résumé des modifications:"
echo ""
echo "  📍 SolMemo:"
echo "    ✅ 2 operations (Create Memo, List Memos)"
echo "    ✅ Nouveau champ Certification Mode (3 choix)"
echo "    ✅ Mapping automatique vers API"
echo ""
echo "  📍 DigiCryptoStore:"
echo "    ✅ B2B Certify Full avec upload intégré"
echo "    ✅ List NFTs"
echo "    ✅ Champs interdits supprimés (Storage ID, Collection Mint, Affiliate Code)"
echo ""
echo "📦 Package installé:"
echo "    $TGZ_FILE"
echo ""
echo "⚠️  PROCHAINE ÉTAPE CRITIQUE:"
echo "    Redémarrer n8n pour charger les nouveaux nodes"
echo ""
echo "    Option 1: ./scripts/manage-dev.sh restart"
echo "    Option 2: pm2 restart n8n"
echo ""
echo "📖 Tests recommandés après redémarrage:"
echo "    1. SolMemo: Tester les 3 modes de certification"
echo "    2. DigiCryptoStore: Tester B2B Certify Full (URL + Base64)"
echo "    3. DigiCryptoStore: Tester List NFTs"
echo ""
echo "📂 Documentation complète:"
echo "    /home/greg/photocertif/RAPPORT_FINAL_REFACTOR.md"
echo ""
