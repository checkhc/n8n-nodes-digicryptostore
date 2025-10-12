# 📋 WORKFLOW v2.1.0 CHANGELOG

**Date:** 2025-10-12  
**Version:** 2.1.0  
**Status:** ✅ Production Ready

---

## 🎯 **CHANGEMENTS MAJEURS**

### ✅ **NOUVEAUTÉ: Vérification Balance CHECKHC**

**PROBLÈME RÉSOLU:**
- Le workflow v2.0.0 effectuait TOUJOURS un swap SOL→CHECKHC, même si le wallet avait déjà suffisamment de tokens CHECKHC
- Cela causait des erreurs inutiles et du gaspillage de frais

**SOLUTION v2.1.0:**
- Ajout de 2 nouveaux nodes pour vérifier la balance CHECKHC AVANT de swap
- Si balance CHECKHC suffisante → Skip le swap et utilise les tokens existants
- Si balance CHECKHC insuffisante → Effectue le swap SOL→CHECKHC

---

## 🔧 **NOUVEAUX NODES**

### **Node 4a: Check CHECKHC Balance**
```json
{
  "operation": "getTokenBalance",
  "tokenMint": "={{ $('2. Get Complete Pricing').first().json.checkhc_mint }}"
}
```
- **Type:** n8n-nodes-solana-swap.solanaNode
- **Fonction:** Récupère la balance CHECKHC actuelle du wallet
- **Output:** `{ balance: 123.456789 }`

### **Node 4b: CHECKHC Sufficient?**
```json
{
  "conditions": {
    "number": [{
      "value1": "={{ $('4a. Check CHECKHC Balance').first().json.balance }}",
      "operation": "largerEqual",
      "value2": "={{ $('2. Get Complete Pricing').first().json.price_checkhc }}"
    }]
  }
}
```
- **Type:** n8n-nodes-base.if
- **Fonction:** Compare balance CHECKHC actuelle vs montant requis
- **TRUE:** Skip vers node 7 (Transfer directement)
- **FALSE:** Continue vers node 5 (Upload + Swap)

---

## 📊 **NOUVEAU FLUX COMPLET**

### **Flux Logique v2.1.0:**

```
1. Input Data
   ↓
2. Get Complete Pricing (calcule price_checkhc nécessaire)
   ↓
3. Check SOL Balance
   ↓
4. SOL Sufficient?
   ├─ FALSE → ERROR: Insufficient SOL ❌
   └─ TRUE → 4a. Check CHECKHC Balance
              ↓
              4b. CHECKHC Sufficient?
              ├─ TRUE → 7. Transfer to Main Wallet ⚡ (SKIP SWAP)
              └─ FALSE → 5. Upload Document
                         ↓
                         6. Swap SOL → CHECKHC
                         ↓
                         7. Transfer to Main Wallet
                         ↓
                         8. Has Affiliate?
                         ├─ TRUE → 9a. Transfer to Affiliate
                         └─ FALSE → 10. Wait Blockchain Confirmation
                                    ↓
                                    11. Certify Document
                                    ↓
                                    12. Wait For Certification
                                    ↓
                                    13. Success Output ✅
```

---

## 🎯 **AVANTAGES v2.1.0**

| Avantage | Description |
|----------|-------------|
| **💰 Économie de frais** | Pas de swap inutile si CHECKHC déjà présent |
| **⚡ Plus rapide** | Skip une étape blockchain si possible |
| **🔧 Flexible** | Fonctionne avec wallet pré-rempli OU vide |
| **✅ Robuste** | Gestion d'erreur à chaque étape |

---

## 📋 **COMPATIBILITÉ**

| Composant | Version Requise |
|-----------|----------------|
| **n8n** | >= 1.0.0 |
| **Node PhotoCertif** | >= 1.2.0 |
| **Node Solana Swap** | >= 1.5.0 |
| **API PhotoCertif** | /api/pricing/service |

---

## 🚀 **MIGRATION v2.0.0 → v2.1.0**

### **Étapes:**

1. **Supprimer** le workflow v2.0.0 dans n8n
2. **Importer** `workflow-docs-certification-v2.1.0.json`
3. **Reconfigurer** les credentials:
   - PhotoCertif API
   - Solana API (avec private key)
4. **Tester** avec:
   - Wallet VIDE (testera le swap)
   - Wallet avec CHECKHC (testera le skip)

---

## 🔍 **TESTS RECOMMANDÉS**

### **Test 1: Wallet avec CHECKHC suffisant**
```
Balance CHECKHC: 200 tokens
Prix requis: 196.51 tokens
Résultat attendu: Skip swap, transfer direct ✅
```

### **Test 2: Wallet sans CHECKHC**
```
Balance CHECKHC: 0 tokens
Prix requis: 196.51 tokens
Résultat attendu: Swap SOL→CHECKHC puis transfer ✅
```

### **Test 3: Wallet avec CHECKHC insuffisant**
```
Balance CHECKHC: 50 tokens
Prix requis: 196.51 tokens
Résultat attendu: Swap complément puis transfer ✅
```

---

## ⚠️ **NOTES IMPORTANTES**

1. **Le node "getTokenBalance"** doit être supporté par votre version du node Solana Swap
2. **La balance CHECKHC** est vérifiée avec 6 décimales (standard SPL token)
3. **Si pas assez de SOL** pour le swap, l'erreur sera levée au node 4 (comme avant)

---

## 📝 **FICHIERS MODIFIÉS**

- `workflow-docs-certification-v2.1.0.json` ← **NOUVEAU**
- `WORKFLOW_V2.1.0_CHANGELOG.md` ← **NOUVEAU**

---

**Developed by CHECKHC** | https://www.checkhc.net  
**Contact:** contact@checkhc.net
