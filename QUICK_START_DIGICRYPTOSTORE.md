# 🚀 Quick Start - DigiCryptoStore B2B

Get started with automated document certification in **2 minutes**.

---

## 📋 Prerequisites

- ✅ **n8n installed** (self-hosted or cloud)
- ✅ **Solana wallet** with some SOL (~0.1 SOL minimum)
- ✅ **CHECKHC tokens** (or SOL to swap)
- ✅ **DigiCryptoStore API Key** from https://app.photocertif.com

---

## ⚡ 3-Step Installation

### **Step 1: Install Required Packages**

```bash
cd ~/.n8n
npm install n8n-nodes-solana-swap n8n-nodes-digicryptostore
```

Restart n8n:
```bash
n8n start
```

### **Step 2: Configure Credentials**

#### **Credential 1: DigiCryptoStore API**
1. In n8n: **Settings** → **Credentials** → **New**
2. Search "**PhotoCertif API**" (same credential type)
3. Fill in:
   - **URL**: `https://app.photocertif.com`
   - **API Key**: Your API key from PhotoCertif dashboard

#### **Credential 2: Solana Wallet**
1. In n8n: **Settings** → **Credentials** → **New**  
2. Search "**Solana API**"
3. Fill in:
   - **Network**: Mainnet Beta
   - **RPC Endpoint**: Your Helius/QuickNode URL (or use public RPC)
   - **Private Key**: Your wallet private key (base58 format)
   - **Public Key**: Your wallet address

⚠️ **Use a dedicated wallet for n8n** (not your main wallet)

### **Step 3: Import Workflow**

1. Download: `/workflows/workflow-docs-certification-v2.4.0.json`
2. In n8n: **Workflows** → **Import from File**
3. Select credentials:
   - Node "🚀 Certify My Document" → Select your credentials
4. Save workflow

---

## 🎯 First Certification

### **Upload a Document First**

Before running the workflow, upload your document:

```bash
curl -X POST https://app.photocertif.com/api/storage/docs/upload/iv_route \
  -H "X-API-Key: YOUR_API_KEY" \
  -F "file=@document.pdf"
```

Response:
```json
{
  "success": true,
  "iv_storageid": "iv_1760288714956_1u4s76u"
}
```

### **Run the Workflow**

1. Open the workflow in n8n
2. Click **Execute Workflow**
3. Fill in the inputs:

```json
{
  "storage_id": "iv_1760288714956_1u4s76u",
  "document_name": "My Important Contract",
  "cert_symbol": "CONTRACT",
  "cert_description": "Official certified contract",
  "cert_owner": "Company XYZ",
  "collection_mint_address": "",
  "affiliate_code": ""
}
```

4. Click **Execute**
5. Wait ~30-60 seconds

### **Success Output**

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
      "affiliate": null
    },
    "pricing": {
      "usd_price": 10,
      "checkhc_amount": 245.8,
      "main_payment": 245.8,
      "affiliate_payment": 0
    },
    "status": "COMPLETED",
    "solscan_url": "https://solscan.io/token/9XyZ...ABC?cluster=mainnet"
  }
}
```

---

## 🎉 What Happened?

The workflow automatically:

1. ✅ **Verified** your storage_id
2. ✅ **Calculated** pricing (10 USD → ~245 CHECKHC)
3. ✅ **Checked** your wallet balances
4. ✅ **Swapped** SOL → CHECKHC (if needed)
5. ✅ **Transferred** CHECKHC to payment wallet
6. ✅ **Uploaded** 3 files to Arweave permanently:
   - Original document
   - Certified preview with watermark
   - NFT metadata JSON
7. ✅ **Created** NFT on Solana
8. ✅ **Finalized** certification

**Total: 1 API call, ~30-60 seconds, fully automated! 🚀**

---

## 🔍 View Your NFT

Open the Solscan URL from the response:
```
https://solscan.io/token/9XyZ...ABC?cluster=mainnet
```

You'll see:
- ✅ NFT metadata
- ✅ Owner address (your wallet)
- ✅ Collection (if specified)
- ✅ Attributes (certification date, owner, etc.)

---

## 📊 Check Permanent Storage

Your document is permanently stored on Arweave:

```bash
# Original document
https://gateway.irys.xyz/QmZzZ...

# Certified preview
https://gateway.irys.xyz/QmYyY...

# Metadata
https://gateway.irys.xyz/QmXxX...
```

**Storage is permanent** - cannot be deleted or modified! 🔒

---

## 🔄 Batch Processing

Want to certify multiple documents? Use the workflow in a loop:

```json
[
  {
    "storage_id": "iv_xxx1",
    "document_name": "Contract 1",
    "cert_owner": "Client A"
  },
  {
    "storage_id": "iv_xxx2",
    "document_name": "Contract 2",
    "cert_owner": "Client B"
  }
]
```

Each document will be certified automatically with its own NFT.

---

## 💰 Cost per Certification

**CHECKHC Payment:**
- ~10 USD (paid in CHECKHC tokens)
- ~245 CHECKHC at current rate

**Blockchain Fees (SOL):**
- Arweave storage (3 files): ~0.02-0.05 SOL
- NFT minting: ~0.01 SOL
- **Total**: ~0.03-0.06 SOL per document

---

## 🐛 Troubleshooting

### "Insufficient SOL balance"
- Transfer more SOL to your n8n wallet
- Recommended: 0.1-0.5 SOL for multiple certifications

### "Insufficient CHECKHC balance"
- The workflow will automatically swap SOL → CHECKHC
- Make sure you have enough SOL for the swap

### "API Key invalid"
- Verify your API key in credentials
- Check scopes: `docs:read`, `docs:upload`, `docs:write`

### "Storage record not found"
- Make sure you uploaded the document first
- Check the `storage_id` is correct

---

## 🚀 Next Steps

1. **Batch Processing**: Process multiple documents in a loop
2. **Monitoring**: Add notifications (email, Slack) for completion
3. **Error Handling**: Add error nodes for failed certifications
4. **Affiliate System**: Add affiliate codes for commission tracking

---

## 📚 Full Documentation

- **README.md**: Complete feature list and configuration
- **WORKFLOW_V2.4.0_README.md**: Detailed workflow documentation
- **API Reference**: https://app.photocertif.com/api/docs

---

## 💬 Support

- 📧 Email: contact@checkhc.net
- 🌐 Website: https://www.checkhc.net
- 📱 Discord: [Join our community]

---

**Created by CHECKHC** - Blockchain certification made easy 🚀
