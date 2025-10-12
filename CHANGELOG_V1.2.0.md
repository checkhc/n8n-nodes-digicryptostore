# 📋 CHANGELOG v1.2.0 - Node PhotoCertif + Workflow v2.0.0

**Release Date:** October 11, 2025  
**Package:** n8n-nodes-photocertif@1.2.0  
**Breaking Changes:** ❌ Non (rétrocompatible)

---

## 🎯 **RÉSUMÉ**

Cette version corrige **tous les bugs critiques** du workflow v1.1.0 et ajoute le support complet pour:
- Calcul précis des frais Irys via API
- Split automatique des paiements affiliés
- Vérification SOL (pas CHECKHC) avant swap
- Quote Jupiter temps réel pour prix exact

---

## ✨ **NOUVELLES FONCTIONNALITÉS**

### **1. Node PhotoCertif - Opération getPricing**

#### **Ajout de 2 paramètres optionnels:**

```typescript
{
  displayName: 'File Size (Bytes)',
  name: 'fileSize',
  type: 'number',
  default: 0,
  description: 'Processed file size in bytes (optional, for Irys cost calculation)'
}

{
  displayName: 'Original File Size (Bytes)',
  name: 'originalSize', 
  type: 'number',
  default: 0,
  description: 'Original file size in bytes (optional, for Irys cost calculation)'
}
```

#### **Modification backend:**
```typescript
// Avant v1.2.0
GET /api/pricing/service?type=docs

// Après v1.2.0
GET /api/pricing/service?type=docs&fileSize=500000&originalSize=2000000
```

**Bénéfices:**
- ✅ Calcul frais Irys précis (basé sur taille réelle)
- ✅ Estimation SOL total requis exact
- ✅ Évite les erreurs "Insufficient balance"

---

## 🔧 **CORRECTIONS WORKFLOW v2.0.0**

### **Problème 1: Paramètres Swap incorrects** ❌
```json
// v1.1.0 - FAUX
{
  "operation": "executeSwapAdvanced",
  "fromToken": "So11...",     // ❌ Paramètre inexistant
  "toToken": "5tpk...",        // ❌ Paramètre inexistant
  "amount": 0.00548            // ❌ Paramètre inexistant
}
```

```json
// v2.0.0 - CORRIGÉ ✅
{
  "operation": "executeSwapAdvanced",
  "inputMint": "So11111111111111111111111111111111111111112",
  "outputMint": "5tpkrCVVh6tjjve4TuyP8MXBwURufgAnaboaLwo49uau",
  "swapAmount": 0.00548,
  "slippageBps": 100,
  "priorityFee": 5000,
  "dexProvider": "jupiter"
}
```

### **Problème 2: Paramètres Transfer incorrects** ❌
```json
// v1.1.0 - FAUX
{
  "operation": "sendToken",
  "tokenMint": "5tpk...",      // ❌ Paramètre inexistant
  "amount": 217.11              // ❌ Paramètre inexistant
}
```

```json
// v2.0.0 - CORRIGÉ ✅
{
  "operation": "sendToken",
  "recipientAddress": "C6bK...",
  "tokenType": "CUSTOM",
  "customTokenMint": "5tpkrCVVh6tjjve4TuyP8MXBwURufgAnaboaLwo49uau",
  "sendAmount": 217.11,
  "sendPriorityFee": 5000
}
```

### **Problème 3: Paramètres Pricing incorrects** ❌
```json
// v1.1.0 - FAUX
{
  "operation": "getPricing",
  "resourceType": "docs",
  "additionalFields": {        // ❌ N'existe pas dans le node
    "fileSize": 500000,
    "originalSize": 2000000
  }
}
```

```json
// v2.0.0 - CORRIGÉ ✅
{
  "operation": "getPricing",
  "resourceType": "docs",
  "fileSize": 500000,          // ✅ Paramètre direct
  "originalSize": 2000000      // ✅ Paramètre direct
}
```

---

## 📊 **COMPARAISON COMPLÈTE**

| Fonctionnalité | v1.1.0 | v1.2.0 + Workflow v2.0.0 |
|----------------|--------|--------------------------|
| **Vérification balance** | ❌ CHECKHC | ✅ SOL |
| **Montant swap** | ❌ 217 SOL (~$40k) | ✅ 0.005 SOL (~$1) |
| **Split affilié** | ❌ Absent | ✅ Automatique 85/15% |
| **Frais Irys** | ❌ Non calculés | ✅ API temps réel |
| **Quote Jupiter** | ❌ Absent | ✅ Temps réel + fallback |
| **Gestion d'erreur** | ❌ Continue même si échec | ✅ Stop immédiat |
| **Paramètres nodes** | ❌ Noms incorrects | ✅ Conformes au node Solana |

---

## 🔄 **MIGRATION DEPUIS v1.1.0**

### **Étape 1: Mettre à jour le node**
```bash
cd /home/greg/n8n-nodes-photocertif
git pull
yarn build
```

### **Étape 2: Importer le nouveau workflow**
- Importer `workflow-docs-certification-v2.0.0.json` dans n8n
- Configurer les credentials (PhotoCertif + Solana API)
- Tester avec un petit document

### **Étape 3: Vérifier les anciens workflows**
Si vous avez des workflows v1.1.0 existants:
1. ❌ **NE PAS LES UTILISER** (bugués)
2. ✅ Créer de nouveaux workflows basés sur v2.0.0
3. ✅ Archiver les anciens workflows

---

## 📦 **FICHIERS MODIFIÉS**

### **Backend (PhotoCertif)**
```
/src/app/api/pricing/service/route.ts
- Ajout: Support fileSize/originalSize query params
- Ajout: Calcul frais Irys via API
- Ajout: Split paiement affilié
- Ajout: Quote Jupiter temps réel
- Lignes: 68 → 312
```

### **Node n8n**
```
/nodes/PhotoCertif/PhotoCertif.node.ts
- Ajout: Paramètre fileSize pour getPricing
- Ajout: Paramètre originalSize pour getPricing
- Modification: Construction query params dynamique
- Lignes: 807 → 837
```

### **Workflow**
```
workflow-docs-certification-v2.0.0.json
- Correction: Tous les paramètres Solana node
- Ajout: Split affilié conditionnel
- Ajout: Vérification SOL suffisant
- Nodes: 10 → 13
```

---

## ✅ **TESTS EFFECTUÉS**

### **Node PhotoCertif**
```bash
✅ TypeScript compilation: OK
✅ Yarn build: OK
✅ Paramètres affichés dans n8n: OK
```

### **API Pricing**
```bash
✅ GET /api/pricing/service?type=docs
   → Retourne prix sans frais Irys
   
✅ GET /api/pricing/service?type=docs&fileSize=500000&originalSize=2000000
   → Retourne prix avec frais Irys: 0.000402 SOL
```

### **Workflow JSON**
```bash
✅ Validation JSON: OK
✅ Syntaxe n8n: OK
✅ Connexions nodes: OK
```

---

## 🐛 **BUGS CORRIGÉS**

1. ✅ **Swap montant aberrant**: 217 SOL → 0.005 SOL
2. ✅ **Vérification balance**: CHECKHC → SOL
3. ✅ **Paramètres incorrects**: fromToken/toToken → inputMint/outputMint
4. ✅ **Pas de split affilié**: Ajout transfert conditionnel
5. ✅ **Frais Irys absents**: Calcul via API temps réel
6. ✅ **Pas de gestion erreur**: continueOnFail: false partout
7. ✅ **Paramètres additionalFields**: Conversion en paramètres directs

---

## 🚀 **PROCHAINES ÉTAPES**

1. Tester le workflow complet sur devnet
2. Créer workflows similaires pour image2 et image3
3. Publier n8n-nodes-photocertif@1.2.0 sur npm
4. Mettre à jour la documentation

---

## 📞 **SUPPORT**

- **Documentation:** `/WORKFLOW_V2_CHANGELOG.md`
- **Issues:** contact@checkhc.net
- **Website:** https://www.checkhc.net

---

**Developed by CHECKHC** | Version 1.2.0 | October 2025
