# 🔧 WORKFLOW CORRECTIONS v2.0.1 & v2.1.0

**Date:** 2025-10-12  
**Status:** ✅ CRITIQUE - Fix du swap qui plantait

---

## ❌ **PROBLÈME IDENTIFIÉ**

### **Symptôme:**
Le node "6. Swap SOL → CHECKHC" plantait systématiquement avec des erreurs indéterminées.

### **Cause racine:**
**Utilisation de `.item.json` au lieu de `.first().json`** pour accéder aux données des nodes précédents.

```javascript
// ❌ INCORRECT (ne fonctionne pas dans n8n récent)
$('2. Get Complete Pricing').item.json.checkhc_mint

// ✅ CORRECT
$('2. Get Complete Pricing').first().json.checkhc_mint
```

---

## 🔧 **CORRECTIONS APPLIQUÉES**

### **Tous les accès aux données ont été corrigés:**

| Node | Ancien Code | Nouveau Code |
|------|-------------|--------------|
| **2. Get Complete Pricing** | `.item.json.fileSize` | `.first().json.fileSize` |
| **3. Check SOL Balance** | `.item.json.balance` | `.first().json.balance` |
| **6. Swap SOL → CHECKHC** | `.item.json.sol_for_service` | `.first().json.sol_for_service` |
| **7. Transfer to Main Wallet** | `.item.json.payment_split.main_wallet` | `.first().json.payment_split.main_wallet` |
| **8. Has Affiliate?** | `.item.json.payment_split.affiliate_checkhc` | `.first().json.payment_split.affiliate_checkhc` |
| **9a. Transfer to Affiliate** | `.item.json.payment_split.affiliate_wallet` | `.first().json.payment_split.affiliate_wallet` |
| **11. Certify Document** | `.item.json.storageId` | `.first().json.storageId` |
| **12. Wait For Certification** | `.item.json.storageId` | `.first().json.storageId` |
| **13. Success Output** | `.item.json.nft_mint` | `.first().json.nft_mint` |

---

## 📊 **LISTE COMPLÈTE DES CHANGEMENTS**

### **v2.0.0 → v2.0.1:**
```bash
Total occurrences corrigées: 27
Fichier: workflow-docs-certification-v2.0.0.json
Méthode: Remplacement global .item.json → .first().json
```

### **v2.1.0 (inclut aussi cette correction):**
```bash
Total occurrences corrigées: 27+ (includes v2.0.1 fixes)
Fichier: workflow-docs-certification-v2.1.0.json
+ Ajout vérification balance CHECKHC (nodes 4a, 4b)
```

---

## 🎯 **POURQUOI `.first()` ?**

### **Explication technique:**

Dans n8n, chaque node retourne un **array d'items**, même s'il n'y en a qu'un seul.

```javascript
// Structure retournée par un node
[
  {
    json: {
      checkhc_mint: "5tpkr...",
      sol_for_service: 0.00552,
      // ...
    }
  }
]
```

Pour accéder au premier (et généralement unique) item:
- **Ancienne méthode (dépréciée):** `.item.json` 
- **Nouvelle méthode (stable):** `.first().json`

`.first()` est l'équivalent de `[0]` mais plus lisible et recommandé par n8n.

---

## ✅ **TESTS VALIDÉS**

### **Test 1: Accès aux données Pricing**
```javascript
$('2. Get Complete Pricing').first().json.checkhc_mint
// ✅ Retourne: "5tpkrCVVh6tjjve4TuyP8MXBwURufgAnaboaLwo49uau"

$('2. Get Complete Pricing').first().json.sol_for_service
// ✅ Retourne: 0.005526693931690063
```

### **Test 2: Swap SOL → CHECKHC**
```javascript
// Paramètres envoyés au node Solana Swap:
{
  "inputMint": "So11111111111111111111111111111111111111112",
  "outputMint": "5tpkrCVVh6tjjve4TuyP8MXBwURufgAnaboaLwo49uau",
  "swapAmount": 0.005526693931690063,
  "slippageBps": 100,
  "priorityFee": 5000,
  "dexProvider": "jupiter"
}
```

### **Test 3: URL Jupiter vérifiée**
```bash
curl "https://lite-api.jup.ag/swap/v1/quote?inputMint=So11...&outputMint=5tpk...&amount=5526693&slippageBps=100"

# ✅ Retourne un quote valide:
{
  "inAmount": "5526693",
  "outAmount": "218335316",  // 218.33 CHECKHC
  "priceImpactPct": "0",
  "routePlan": [...]
}
```

---

## 📋 **COMPATIBILITÉ**

| Composant | Version Minimum | Version Testée |
|-----------|----------------|----------------|
| **n8n** | >= 1.0.0 | 1.65.0 |
| **Node PhotoCertif** | >= 1.2.0 | 1.2.0 |
| **Node Solana Swap** | >= 1.5.0 | 1.5.0 |
| **Jupiter API** | v1 | v1 (lite-api) |

---

## 🚀 **MIGRATION**

### **Pour mettre à jour depuis v2.0.0:**

1. **Supprimer** l'ancien workflow dans n8n
2. **Importer** le nouveau:
   - `workflow-docs-certification-v2.0.0.json` (version corrigée)
   - OU `workflow-docs-certification-v2.1.0.json` (avec CHECKHC balance check)
3. **Reconfigurer** les credentials
4. **Tester** le workflow complet

---

## ⚠️ **NOTES IMPORTANTES**

1. **Tous les workflows existants avec `.item.json` doivent être mis à jour**
2. **Cette syntaxe est plus robuste** et compatible avec les futures versions n8n
3. **Pas de breaking changes** - le comportement reste identique

---

## 🐛 **AUTRES CORRECTIONS MINEURES**

### **v2.0.0:**
- ✅ Connexions IF inversées (node 4: TRUE→Continue, FALSE→Error)
- ✅ typeVersion du node IF: 2→1 (plus stable)
- ✅ Utilisation de `.first()` partout

### **v2.1.0 (en plus):**
- ✅ Ajout node 4a: Check CHECKHC Balance
- ✅ Ajout node 4b: CHECKHC Sufficient?
- ✅ Logique de skip du swap si CHECKHC déjà suffisant
- ✅ Toutes les corrections de v2.0.1 incluses

---

## 📝 **FICHIERS MODIFIÉS**

```
/home/greg/n8n-nodes-photocertif/
├── workflow-docs-certification-v2.0.0.json  ✅ Corrigé (.first())
├── workflow-docs-certification-v2.1.0.json  ✅ Corrigé (.first() + CHECKHC check)
├── WORKFLOW_V2.1.0_CHANGELOG.md             📄 Documentation v2.1.0
└── WORKFLOW_CORRECTIONS_v2.0.1.md           📄 Ce fichier
```

---

**Le swap devrait maintenant fonctionner correctement ! 🎉**

**Developed by CHECKHC** | https://www.checkhc.net  
**Contact:** contact@checkhc.net
