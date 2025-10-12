# PhotoCertif Docs Certification Workflow v2.4.0 🚀

## ✨ ULTRA-SIMPLIFIED - 2 NODES ONLY

Ce workflow fait **TOUT** en **1 SEUL APPEL API** au lieu de 13 nodes.

---

## 🎯 Comparaison des versions

### ❌ **v2.3.0 (Over-Engineered)**
```
13 nodes:
- Manual Trigger
- Upload Document  
- Get Pricing
- Check SOL Balance
- Need Swap?
- Swap SOL→CHECKHC
- Transfer Main
- Has Affiliate?
- Transfer Affiliate
- B2B Step 1
- B2B Step 2
- B2B Step 3
- Success Output

Private key transmise 6 fois ❌
Multiples points d'échec ❌
Complexe à maintenir ❌
```

### ✅ **v2.4.0 (Simplifié)**
```
2 nodes:
- 📝 Input Data
- 🚀 Certify My Document

Private key transmise 1 fois ✅
1 seul point d'échec ✅
Facile à maintenir ✅
```

---

## 📊 Architecture

```
┌──────────────────────────────────────────────────────┐
│ Node 1: 📝 Input Data                                │
│   - storage_id                                       │
│   - document_name                                    │
│   - cert_symbol                                      │
│   - cert_description                                 │
│   - cert_owner                                       │
│   - collection_mint_address (optional)               │
│   - affiliate_code (optional)                        │
└──────────────────────────────────────────────────────┘
                        ↓
┌──────────────────────────────────────────────────────┐
│ Node 2: 🚀 Certify My Document                       │
│ POST /api/storage/docs/b2b-certify-full             │
│                                                      │
│ Le backend fait TOUT (en ~30-60s):                  │
│ ┌────────────────────────────────────────────┐     │
│ │ 1. Verify storage_id                       │     │
│ │ 2. Get pricing (avec affilié)              │     │
│ │ 3. Check SOL/CHECKHC balances              │     │
│ │ 4. Swap SOL→CHECKHC (si besoin)           │     │
│ │ 5. Transfer CHECKHC au payment_wallet      │     │
│ │ 6. Transfer CHECKHC à l'affilié (si appli.)│     │
│ │ 7. Prépare certification (/certify/iv_route)│    │
│ │ 8. Upload Irys (3 fichiers, 3 signatures): │     │
│ │    - Document original                     │     │
│ │    - Image certifiée preview               │     │
│ │    - Metadata JSON                         │     │
│ │ 9. Create NFT (1 signature Metaplex/Umi)   │     │
│ │ 10. Finalize (iv_certificates + COMPLETED) │     │
│ └────────────────────────────────────────────┘     │
│                                                      │
│ Retourne:                                            │
│ - NFT mint address                                   │
│ - NFT transaction signature                          │
│ - Irys URLs (metadata, certified, original)          │
│ - Payment signatures (main + affiliate)              │
│ - Pricing breakdown                                  │
│ - Solscan URL                                        │
└──────────────────────────────────────────────────────┘
```

**Private key transmise UNE SEULE FOIS en HTTPS** 🔐

---

## 🔐 Configuration

### 1. Credential "Solana Wallet"

```json
{
  "name": "Solana Wallet",
  "type": "solanaApi",
  "data": {
    "publicKey": "VOTRE_PUBLIC_KEY_BASE58",
    "privateKey": "VOTRE_PRIVATE_KEY_BASE58"
  }
}
```

**Utilisée pour 4 signatures blockchain:**
1. Upload Irys - Document original
2. Upload Irys - Image certifiée
3. Upload Irys - Metadata JSON
4. Création NFT

### 2. Credential "PhotoCertif API Key"

```json
{
  "name": "PhotoCertif API Key",
  "type": "httpHeaderAuth",
  "data": {
    "name": "X-API-Key",
    "value": "VOTRE_API_KEY_B2B"
  }
}
```

**Scopes requis:**
- `docs:upload`
- `docs:certify`

### 3. Variables d'environnement n8n

```bash
# PhotoCertif API
PHOTOCERTIF_API_BASE_URL=https://app.photocertif.com
```

**C'est tout ! 🎉**

---

## 🚀 Utilisation

### **Étape 1: Upload le document**

D'abord, uploader le document via l'API:

```bash
curl -X POST https://app.photocertif.com/api/storage/docs/upload/iv_route \
  -H "X-API-Key: VOTRE_API_KEY" \
  -F "file=@document.pdf"
```

Réponse:
```json
{
  "success": true,
  "iv_storageid": "iv_1760288714956_1u4s76u"
}
```

### **Étape 2: Exécuter le workflow**

1. Ouvrir le workflow dans n8n
2. Cliquer sur **Execute Workflow**
3. Remplir les inputs:

```json
{
  "storage_id": "iv_1760288714956_1u4s76u",
  "document_name": "Contrat Commercial 2025",
  "cert_symbol": "CONTRACT",
  "cert_description": "Contrat officiel certifié",
  "cert_owner": "Entreprise XYZ",
  "collection_mint_address": "",
  "affiliate_code": ""
}
```

### **Étape 3: Attendre la réponse (~30-60s)**

Le workflow retourne:

```json
{
  "success": true,
  "execution_time_ms": 45230,
  "data": {
    "storage_id": "iv_1760288714956_1u4s76u",
    "nft_mint_address": "ABC123...XYZ",
    "nft_transaction_signature": "5x8Df...9kL",
    "irys_urls": {
      "metadata": "https://gateway.irys.xyz/metadata_xxx",
      "certified": "https://gateway.irys.xyz/certified_xxx",
      "original": "https://gateway.irys.xyz/original_xxx"
    },
    "payment_signatures": {
      "main": "3hG...7pQ",
      "affiliate": null
    },
    "pricing": {
      "usd_price": 10,
      "checkhc_amount": 250.5,
      "main_payment": 250.5,
      "affiliate_payment": 0
    },
    "status": "COMPLETED",
    "solscan_url": "https://solscan.io/token/ABC123...XYZ?cluster=mainnet"
  }
}
```

---

## ⏱️ Performance

### **Temps d'exécution (estimé):**

| Étape | Durée |
|-------|-------|
| Verify storage | ~0.5s |
| Get pricing | ~0.5s |
| Check balances | ~1s |
| Swap SOL→CHECKHC (si besoin) | ~5-10s |
| Transfer main | ~2s |
| Transfer affiliate (si appli.) | ~2s |
| **Upload Irys (3 fichiers)** | **~10-20s** |
| **Create NFT** | **~5-10s** |
| Finalize | ~1s |

**Total: ~30-60s selon la taille du document**

---

## 🔍 Monitoring

### **Logs Backend**

Le backend log chaque étape avec le préfixe `[B2B FULL]`:

```
[B2B FULL] 🚀 Starting full certification process...
[B2B FULL] ✅ API Key authenticated: user_123
[B2B FULL] ✅ Private key validated, public key: ABC...
[B2B FULL] 📦 Step 1: Verifying storage record...
[B2B FULL] ✅ Storage record verified
[B2B FULL] 💰 Step 2: Getting pricing...
[B2B FULL] ✅ Pricing retrieved: {...}
[B2B FULL] 💵 Step 3: Checking balances...
[B2B FULL] 🔄 Step 4: Swapping SOL → CHECKHC...
[B2B FULL] ✅ Swap completed
[B2B FULL] 💸 Step 5: Transferring to payment wallet...
[B2B FULL] ✅ Main payment completed
[B2B FULL] ⏭️  Step 6: No affiliate, skipping
[B2B FULL] 🔧 Step 7: Preparing certification...
[B2B FULL] ✅ Certification prepared
[B2B FULL] ☁️  Step 8: Uploading to Irys...
[B2B FULL] 📄 Uploading original document...
[B2B FULL] ✅ Original document uploaded
[B2B FULL] 🖼️  Uploading certified preview...
[B2B FULL] ✅ Certified preview uploaded
[B2B FULL] 📝 Uploading metadata...
[B2B FULL] ✅ Metadata uploaded
[B2B FULL] 🎨 Step 9: Creating NFT...
[B2B FULL] ✅ NFT created: ABC123...XYZ
[B2B FULL] ✨ Step 10: Finalizing...
[B2B FULL] ✅ Finalization complete
[B2B FULL] 🎉 COMPLETE! Total time: 45230ms
```

### **Erreurs Possibles**

| Erreur | Cause | Solution |
|--------|-------|----------|
| `Invalid private key format` | Private key incorrecte | Vérifier credential Solana Wallet |
| `Storage record not found` | storage_id invalide | Vérifier l'upload du document |
| `Insufficient SOL balance` | Pas assez de SOL | Transférer du SOL au wallet |
| `Failed to get Jupiter quote` | Problème swap | Vérifier RPC Solana |
| `Failed to upload to Irys` | Problème Irys | Vérifier balance SOL, retry |
| `NFT creation failed` | Problème Metaplex | Vérifier network, retry |

---

## 🔒 Sécurité

### **Private Key:**
- ✅ Stockée uniquement dans n8n credentials (chiffré)
- ✅ Transmise **1 SEULE FOIS** en HTTPS
- ✅ Jamais loggée (remplacée par `[REDACTED]` dans les logs)
- ✅ Jamais stockée côté serveur
- ✅ Utilisée uniquement pour 4 signatures blockchain

### **Wallet Dédié Recommandé:**

```bash
# Créer wallet dédié
solana-keygen new --outfile n8n-b2b-wallet.json

# Transférer montant limité (~1-2 SOL)
solana transfer n8n-b2b-wallet.json 1.5 --from main-wallet.json
```

**💡 Best practice:** Utiliser un wallet séparé pour les opérations B2B avec montant limité.

---

## 📈 Avantages vs v2.3.0

| Critère | v2.3.0 | v2.4.0 |
|---------|--------|--------|
| **Nombre de nodes** | 13 | **2** ✅ |
| **Private key transmise** | 6 fois | **1 fois** ✅ |
| **Points d'échec** | Multiples | **1 seul** ✅ |
| **Temps execution** | ~30-60s | ~30-60s ⚖️ |
| **Maintenance** | Complexe | **Simple** ✅ |
| **Lisibilité** | Faible | **Excellente** ✅ |
| **Debugging** | Difficile | **Facile** ✅ |
| **Logs centralisés** | Non | **Oui** ✅ |
| **Transactions atomiques** | Non | **Oui** ✅ |

---

## 🆚 Différences avec l'Interface Web

### **Interface Web (`media/docs/certification`):**
- Private key: **Wallet browser de l'utilisateur** (Phantom, etc.)
- Upload Irys: **Côté client** avec wallet connecté
- NFT: **Créé par l'utilisateur** avec son wallet
- Payment: **Auto-swap + transfer via BuyCHECKHCAndCreateNFTButton**

### **Workflow B2B v2.4.0:**
- Private key: **Credentials n8n** (wallet dédié)
- Upload Irys: **Côté serveur** avec private key
- NFT: **Créé par le serveur** avec private key
- Payment: **Géré par le serveur** (swap + transfers automatiques)

**Les deux flux utilisent la MÊME logique backend ! 🎯**

---

## 📝 Exemple Complet

### **1. Upload document:**

```bash
curl -X POST https://app.photocertif.com/api/storage/docs/upload/iv_route \
  -H "X-API-Key: sk_live_ABC123..." \
  -F "file=@contrat.pdf"
```

### **2. Workflow n8n inputs:**

```json
{
  "storage_id": "iv_1760288714956_1u4s76u",
  "document_name": "Contrat Location 2025",
  "cert_symbol": "LOC2025",
  "cert_description": "Contrat de location certifié avec watermark",
  "cert_owner": "ABC Immobilier",
  "collection_mint_address": "",
  "affiliate_code": "PARTNER_XYZ"
}
```

### **3. Output:**

```json
{
  "success": true,
  "execution_time_ms": 42150,
  "data": {
    "storage_id": "iv_1760288714956_1u4s76u",
    "nft_mint_address": "9XyZ...ABC",
    "nft_transaction_signature": "5kL...8pQ",
    "irys_urls": {
      "metadata": "https://gateway.irys.xyz/QmXxX...",
      "certified": "https://gateway.irys.xyz/QmYyY...",
      "original": "https://gateway.irys.xyz/QmZzZ..."
    },
    "payment_signatures": {
      "main": "3hG7pQ...",
      "affiliate": "2fD9kL..."
    },
    "pricing": {
      "usd_price": 10,
      "checkhc_amount": 245.8,
      "main_payment": 221.22,
      "affiliate_payment": 24.58
    },
    "status": "COMPLETED",
    "solscan_url": "https://solscan.io/token/9XyZ...ABC?cluster=mainnet"
  }
}
```

### **4. Vérifier sur Solscan:**

Ouvrir: `https://solscan.io/token/9XyZ...ABC?cluster=mainnet`

---

## 🎉 Conclusion

**v2.4.0 = La simplicité ultime**

- 2 nodes au lieu de 13
- 1 appel API au lieu de 10+
- Private key transmise 1 fois au lieu de 6
- Toute la logique centralisée côté serveur
- Facile à maintenir et débugger

**Workflow Version:** v2.4.0  
**Date:** 2025-01-12  
**Auteur:** PhotoCertif Team  
**Status:** ✅ Production Ready
