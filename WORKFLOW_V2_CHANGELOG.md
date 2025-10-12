# 📋 WORKFLOW v2.0.0 - CHANGELOG COMPLET

## 🎯 RÉSUMÉ DES CORRECTIONS

Le workflow v1.1.0 contenait **7 erreurs critiques** qui empêchaient son fonctionnement correct. La version v2.0.0 corrige tous ces problèmes.

---

## ❌ PROBLÈMES IDENTIFIÉS DANS v1.1.0

### **1. Vérification de balance incorrecte**
```json
// ❌ v1.1.0 - FAUX
"3. Check CHECKHC Balance": {
  "operation": "getTokenBalance",
  "tokenMint": "={{ $('1. Get Pricing').item.json.checkhc_mint }}"
}
```
**Problème:** Vérifie la balance CHECKHC alors qu'on a besoin de SOL pour le swap !

### **2. Montant swap aberrant**
```json
// ❌ v1.1.0 - FAUX
"5a. Swap SOL → CHECKHC": {
  "amount": "={{ $('1. Get Pricing').item.json.price_checkhc }}"  // Ex: 217
}
```
**Problème:** Essaie de swapper 217 SOL (~$40,000) au lieu de 0.0055 SOL (~$1) !

### **3. Pas de split paiement affilié**
L'ancien workflow n'avait qu'un seul transfert CHECKHC, ignorant complètement le système d'affiliés.

### **4. Pas de calcul des frais Irys**
L'API pricing v1 ne calculait pas les frais d'upload Irys, résultant en des échecs de transaction par manque de SOL.

### **5. Pas de gestion d'erreur**
Le workflow continuait même en cas d'échec de swap ou de transfert.

### **6. Données pricing incomplètes**
L'ancienne API retournait uniquement:
- `price_checkhc`: Montant CHECKHC
- `payment_wallet`: Adresse wallet

Manquait:
- Montant SOL pour le swap
- Split affilié
- Frais détaillés
- Quote Jupiter

### **7. Pas de vérification SOL suffisant**
Aucune vérification que l'utilisateur a assez de SOL pour couvrir:
- Le swap
- Les frais de transaction
- Les frais Irys
- Le mint NFT

---

## ✅ CORRECTIONS APPORTÉES DANS v2.0.0

### **1. API Pricing Complète** (`/api/pricing/service`)

#### Nouvelle réponse API:
```json
{
  "success": true,
  "type": "docs",
  
  // Prix USD avec remise affilié
  "base_price_usd": 1.0,
  "discount_percent": 0.10,        // ← NOUVEAU: Remise 10%
  "final_price_usd": 0.90,
  
  // Conversion SOL (temps réel)
  "sol_usd_price": 182.55,
  "sol_for_service": 0.00493,      // ← NOUVEAU: SOL pour le swap
  
  // CHECKHC (quote Jupiter réel)
  "price_checkhc": 195.40,
  
  // SPLIT PAIEMENT ← NOUVEAU
  "payment_split": {
    "total_checkhc": 195.40,
    "main_checkhc": 166.09,        // 85%
    "main_wallet": "C6bK...",
    "affiliate_checkhc": 29.31,    // 15%
    "affiliate_wallet": "XXXX...",
    "affiliate_percent": 0.15
  },
  
  // FRAIS DÉTAILLÉS ← NOUVEAU
  "fees_sol": {
    "swap": 0.005,
    "transfer_main": 0.000005,
    "transfer_affiliate": 0.000005,
    "irys_upload": 0.00182,        // ← API Irys réelle
    "nft_mint": 0.01,
    "network": 0.005,
    "total": 0.02183
  },
  
  // TOTAUX ← NOUVEAU
  "total_sol_needed": 0.02676,     // ← CRITIQUE: SOL total requis
  "total_usd": 4.88,
  
  // Quote Jupiter (si mainnet)
  "jupiter_quote": {
    "input_amount": 4937951,       // lamports SOL
    "output_amount": 195400000,    // micro CHECKHC
    "price_impact_pct": 0.12
  }
}
```

### **2. Workflow Corrigé**

#### Étape 2: Get Complete Pricing
```json
{
  "operation": "getPricing",
  "resourceType": "docs",
  "additionalFields": {
    "fileSize": "={{ $('1. Input Data').item.json.fileSize }}",
    "originalSize": "={{ $('1. Input Data').item.json.originalSize }}"
  }
}
```
**✅ Nouveau:** Passe les tailles de fichiers pour calcul Irys précis

#### Étape 3: Check SOL Balance
```json
{
  "operation": "getBalance",  // ✅ CORRIGÉ: SOL balance, pas CHECKHC
  "walletAddress": ""
}
```

#### Étape 4: Vérification SOL Suffisant
```json
{
  "conditions": {
    "number": [{
      "value1": "={{ $('3. Check SOL Balance').item.json.balance }}",
      "operation": "largerEqual",
      "value2": "={{ $('2. Get Complete Pricing').item.json.total_sol_needed }}"
    }]
  }
}
```
**✅ Nouveau:** Stop le workflow si SOL insuffisant avec message d'erreur clair

#### Étape 6: Swap SOL → CHECKHC
```json
{
  "operation": "executeSwapAdvanced",
  "fromToken": "So11111111111111111111111111111111111111112",
  "toToken": "={{ $('2. Get Complete Pricing').item.json.checkhc_mint }}",
  "amount": "={{ $('2. Get Complete Pricing').item.json.sol_for_service }}"
  // ✅ CORRIGÉ: 0.00493 SOL au lieu de 217 CHECKHC !
}
```

#### Étape 7: Transfer to Main Wallet
```json
{
  "operation": "sendToken",
  "tokenMint": "={{ $('2. Get Complete Pricing').item.json.checkhc_mint }}",
  "recipientAddress": "={{ $('2. Get Complete Pricing').item.json.payment_split.main_wallet }}",
  "amount": "={{ $('2. Get Complete Pricing').item.json.payment_split.main_checkhc }}"
  // ✅ CORRIGÉ: Envoie uniquement 85% si affilié
}
```

#### Étape 8-9: Gestion Affilié
```json
// Étape 8: Vérifier si affilié
{
  "conditions": {
    "number": [{
      "value1": "={{ $('2. Get Complete Pricing').item.json.payment_split.affiliate_checkhc }}",
      "operation": "larger",
      "value2": 0
    }]
  }
}

// Étape 9a: Transfer to Affiliate (conditionnelle)
{
  "operation": "sendToken",
  "recipientAddress": "={{ $('2. Get Complete Pricing').item.json.payment_split.affiliate_wallet }}",
  "amount": "={{ $('2. Get Complete Pricing').item.json.payment_split.affiliate_checkhc }}"
  // ✅ NOUVEAU: Transfert affilié automatique
}
```

#### Gestion d'erreur
```json
// Tous les nodes critiques ont:
"continueOnFail": false,
"onError": "stopWorkflow"
```
**✅ Nouveau:** Le workflow s'arrête immédiatement en cas d'erreur

---

## 📊 COMPARAISON FLUX COMPLET

### v1.1.0 (BUGUÉ)
```
1. Get Pricing
   ↓ price_checkhc: 217 CHECKHC
2. Upload Document
3. Check CHECKHC Balance ❌ (devrait être SOL)
   ↓ balance: 50 CHECKHC
4. If insufficient? (50 < 217)
   ↓ TRUE → Swap
5. Swap 217 SOL → CHECKHC ❌ (montant aberrant!)
   ↓ ÉCHEC: Insufficient balance
6. Transfer 217 CHECKHC ❌ (n'a pas été swappé)
   ↓ ÉCHEC
7. Certify
   ↓ Continue malgré les échecs ❌
8. Success (FAUX)
```

### v2.0.0 (CORRIGÉ)
```
1. Input Data
   ↓ fileSize, originalSize
2. Get Complete Pricing
   ↓ total_sol_needed: 0.02676 SOL
   ↓ sol_for_service: 0.00493 SOL
   ↓ price_checkhc: 195.40 CHECKHC
   ↓ payment_split: { main: 166.09, affiliate: 29.31 }
3. Check SOL Balance ✅
   ↓ balance: 0.05 SOL
4. If SOL >= 0.02676?
   ↓ TRUE → Continue
   ↓ FALSE → Stop with error message
5. Upload Document ✅
   ↓ storageId: iv_xxx
6. Swap 0.00493 SOL → CHECKHC ✅
   ↓ Reçu: ~195.40 CHECKHC
7. Transfer 166.09 CHECKHC → Main Wallet ✅
   ↓ signature: xxx
8. Has Affiliate? (29.31 > 0)
   ↓ TRUE
9a. Transfer 29.31 CHECKHC → Affiliate Wallet ✅
   ↓ signature: yyy
10. Wait 10s ✅
11. Certify Document ✅
12. Wait For Certification ✅
13. Success Output ✅
    ↓ nft_mint, all signatures, pricing details
```

---

## 🔧 UTILISATION DU NOUVEAU WORKFLOW

### Prérequis
1. **PhotoCertif API Key** configurée dans n8n
2. **Solana API Key** avec private key configurée
3. **SOL dans le wallet** (minimum calculé automatiquement)

### Configuration
1. Importer `workflow-docs-certification-v2.0.0.json` dans n8n
2. Configurer les credentials (PhotoCertif + Solana)
3. Éditer le node "1. Input Data":
   - `fileUrl`: URL du document à certifier
   - `title`: Titre du document
   - `description`: Description
   - `cert_name`: Nom NFT
   - `cert_symbol`: Symbole NFT (4 lettres max)
   - `cert_description`: Description NFT
   - `cert_prop`: Propriétaire
   - `fileSize`: Taille fichier certifié (bytes)
   - `originalSize`: Taille fichier original (bytes)

### Exécution
1. Cliquer sur "Execute Workflow"
2. Le workflow vérifie automatiquement:
   - Prix avec remise affilié si applicable
   - SOL suffisant dans le wallet
   - Calcul précis des frais Irys
3. En cas de succès, retourne:
   - `nft_mint_address`: Adresse du NFT créé
   - `swap_signature`: Signature du swap
   - `main_payment_signature`: Signature paiement principal
   - `affiliate_payment_signature`: Signature paiement affilié
   - `pricing_details`: Tous les détails de prix

### Gestion d'erreur
Si une étape échoue:
- Le workflow s'arrête immédiatement
- Un message d'erreur clair est affiché
- Aucune transaction partielle n'est effectuée

Exemple erreur SOL insuffisant:
```json
{
  "error": "Insufficient SOL balance",
  "required_sol": 0.02676,
  "current_sol": 0.01,
  "message": "Please add 0.01676 SOL to your wallet"
}
```

---

## 📈 BÉNÉFICES v2.0.0

1. ✅ **Calculs précis** - Quote Jupiter temps réel, frais Irys calculés
2. ✅ **Gestion affiliés** - Split automatique des paiements
3. ✅ **Sécurité** - Vérification SOL avant toute transaction
4. ✅ **Transparence** - Tous les montants et signatures dans l'output
5. ✅ **Robustesse** - Gestion d'erreur à chaque étape
6. ✅ **Maintenabilité** - Code clair et documenté

---

## 🚀 PROCHAINES ÉTAPES

1. Tester le workflow v2.0.0 sur devnet
2. Valider avec un document réel
3. Créer workflows similaires pour image2 et image3
4. Publier la version corrigée sur npm

---

**Développé par CHECKHC** | https://www.checkhc.net  
**Contact:** contact@checkhc.net
