# n8n-nodes-digicryptostore

**DigiCryptoStore** - Secure document certification and permanent archiving on Solana blockchain with Arweave/Irys storage.

[![npm version](https://img.shields.io/npm/v/n8n-nodes-digicryptostore)](https://www.npmjs.com/package/n8n-nodes-digicryptostore)
[![Status](https://img.shields.io/badge/Status-Beta-yellow)](https://github.com/checkhc/n8n-nodes-digicryptostore)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Discord Support](https://img.shields.io/badge/Support-Discord-5865F2)](https://discord.com/channels/1324516144979382335/1429512698504151200)

> ⚠️ **Beta Status**: This node is in active development. Features are functional but we're continuously improving based on user feedback. Join our [Discord channel](https://discord.com/channels/1324516144979382335/1429512698504151200) for support and updates.

> 🚀 **Ultra-Simplified Workflow**: 2 nodes to certify documents with permanent blockchain storage

---

## 🎯 What is DigiCryptoStore?

DigiCryptoStore is an n8n community node that enables **automated document certification** on the **Solana blockchain** with **permanent Arweave storage**.

###  **Key Features:**

- 📄 **Document Certification** - PDF, DOCX, XLSX, and more
- ☁️  **Permanent Storage** - Stored forever on Arweave via Irys (cannot be deleted)
- 🎨 **NFT Proof** - Each document gets a unique NFT on Solana
- 💰 **Automated Payments** - CHECKHC tokens paid automatically from n8n wallet
- 🤖 **Zero Manual Intervention** - Complete end-to-end automation
- ⚡ **Ultra-Fast** - Complete certification in ~30-60 seconds
- 🔐 **Secure** - Private keys encrypted in n8n credentials

### **Perfect For:**

- 🏛️ Digital vaults and permanent document archiving
- 📊 High-volume B2B document certification (100s-1000s)
- ✅ Enterprise compliance and audit trails
- 🔄 Automated certification pipelines
- 🗄️ Legal document preservation with blockchain proof

---

## 🚀 Quick Start

### **1. Install**

```bash
cd ~/.n8n
npm install n8n-nodes-solana-swap n8n-nodes-digicryptostore
n8n start
```

### **2. Configure Credentials**

#### **Credential A: DigiCryptoStore API**
1. Get API key from: https://app.photocertif.com
2. In n8n: **Credentials** → **PhotoCertif API**
3. Enter URL: `https://app.photocertif.com` and your API key

#### **Credential B: Solana Wallet**
1. In n8n: **Credentials** → **Solana API**
2. Enter your wallet's private key (base58 format)
3. Recommended: Use a dedicated wallet with limited funds

### **3. Import Workflow**

1. Download: [`workflow-docs-certification-v2.4.0.json`](./workflow-docs-certification-v2.4.0.json)
2. In n8n: **Import from File**
3. Select credentials
4. Execute!

---

## 📊 How It Works

```
📝 Input Data (storage_id, document_name, owner, etc.)
     ↓
🚀 Certify My Document (1 API call)
     │
     ├─→ 1. Verify storage & get pricing
     ├─→ 2. Check SOL/CHECKHC balances
     ├─→ 3. Auto-swap SOL→CHECKHC (if needed)
     ├─→ 4. Transfer CHECKHC to payment wallet
     ├─→ 5. Upload 3 files to Arweave permanently:
     │      • Original document
     │      • Certified preview with watermark
     │      • NFT metadata JSON
     ├─→ 6. Create NFT on Solana
     └─→ 7. Finalize certification
     ↓
✅ Complete! (NFT mint, Arweave URLs, status)
```

**Total Time:** ~30-60 seconds  
**Complexity:** 2 nodes (Input + Certify)  
**Manual Steps:** 0

---

## 💰 Pricing

### **Per Certification:**

**CHECKHC Payment** (paid to DigiCryptoStore):
- ~10 USD per document (paid in CHECKHC tokens)
- Current rate: ~245 CHECKHC per certification

**Blockchain Fees** (paid in SOL from your wallet):
- Arweave storage (3 files): ~0.02-0.05 SOL
- NFT minting: ~0.01 SOL
- **Total**: ~0.03-0.06 SOL per document

### **Wallet Requirements:**

- **SOL**: 0.1-0.5 SOL for multiple certifications
- **CHECKHC**: System auto-swaps SOL→CHECKHC when needed

---

## 📚 Operations

The node provides these operations:

| Operation | Description |
|-----------|-------------|
| `Get Pricing` | Retrieve current CHECKHC pricing |
| `Upload` | Upload document (base64 or URL) |
| `Submit Certification` | Prepare certification with metadata |
| `Get Status` | Check certification progress |
| `Wait for Certification` | Poll until completion |
| `Download` | Retrieve certified document |

---

## 🔧 Advanced Features

### **URL Upload Support**

Upload from Google Drive, Dropbox, or any public URL:

```json
{
  "fileUrl": "https://drive.google.com/uc?id=YOUR_ID&export=download",
  "title": "My Document",
  "file_extension": "pdf"
}
```

### **Batch Processing**

Process multiple documents in a loop:

```json
[
  {"storage_id": "iv_xxx1", "document_name": "Contract 1"},
  {"storage_id": "iv_xxx2", "document_name": "Contract 2"}
]
```

### **Custom Collections**

Add documents to a Solana NFT collection:

```json
{
  "collection_mint_address": "YOUR_COLLECTION_MINT"
}
```

### **Affiliate System**

Track commissions with affiliate codes:

```json
{
  "affiliate_code": "PARTNER_XYZ"
}
```

---

## 📦 What Gets Stored on Arweave

Each certification uploads **3 files permanently**:

1. **Original Document** (`https://gateway.irys.xyz/...`)
   - Your original file (PDF, DOCX, etc.)
   - Permanently accessible
   
2. **Certified Preview** (`https://gateway.irys.xyz/...`)
   - 1200x1200px image with watermark
   - Shows certification code and metadata
   
3. **NFT Metadata** (`https://gateway.irys.xyz/...`)
   - JSON file with all certification data
   - Conforms to Metaplex standards

**Storage is permanent** - files cannot be deleted or modified.

---

## 🔐 Security Best Practices

### **Wallet Security:**

✅ **DO:**
- Use a dedicated wallet for n8n
- Store only necessary funds (~0.5 SOL + 10,000 CHECKHC)
- Private keys are encrypted in n8n credentials

❌ **DON'T:**
- Use your main wallet
- Store large amounts in n8n wallet
- Share your private key

### **API Key Security:**

✅ **DO:**
- Use API keys with minimum required scopes
- Rotate keys regularly
- Monitor usage logs

---

## 🐛 Troubleshooting

### **"Insufficient SOL balance"**
- Transfer more SOL to your n8n wallet
- Recommended: 0.1-0.5 SOL for multiple certifications

### **"Insufficient CHECKHC balance"**
- The workflow automatically swaps SOL→CHECKHC
- Make sure you have enough SOL for the swap

### **"API Key invalid"**
- Verify scopes: `docs:read`, `docs:upload`, `docs:write`
- Regenerate if needed

### **"Storage record not found"**
- Upload the document first via `/api/storage/docs/upload/iv_route`
- Check the `storage_id` is correct

---

## 📖 Documentation

- **[QUICK_START_DIGICRYPTOSTORE.md](./QUICK_START_DIGICRYPTOSTORE.md)** - 2-minute setup guide
- **[WORKFLOW_V2.4.0_README.md](./WORKFLOW_V2.4.0_README.md)** - Detailed workflow documentation
- **[CHANGELOG.md](./CHANGELOG.md)** - Version history

---

## 🆚 Comparison: DigiCryptoStore vs Manual Upload

| Feature | Manual Upload | DigiCryptoStore n8n |
|---------|--------------|---------------------|
| **Setup Time** | Every time | Once |
| **Time per Doc** | 5-10 min | ~30-60 sec |
| **Human Interaction** | Required | Zero |
| **Batch Processing** | Manual | Automated |
| **Payment** | Manual wallet | Automatic |
| **NFT Creation** | Manual | Automatic |
| **Monitoring** | Manual refresh | Automatic polling |
| **Scale** | Limited | Unlimited |

---

## 🔗 Links

- **Website**: https://www.checkhc.net
- **GitHub**: https://github.com/checkhc/n8n-nodes-digicryptostore
- **npm**: https://www.npmjs.com/package/n8n-nodes-digicryptostore
- **DigiCryptoStore**: https://app.photocertif.com
- **Discord Support** (Primary): https://discord.com/channels/1324516144979382335/1429512698504151200
  - Real-time community support
  - Direct access to developers
  - Share workflows and tips
- **Email Support**: contact@checkhc.net

---

## 📄 License

MIT © [CHECKHC](https://checkhc.net)

---

## 🙏 Credits

Built with:
- [n8n](https://n8n.io) - Workflow automation
- [Solana](https://solana.com) - Blockchain
- [Arweave](https://www.arweave.org) - Permanent storage
- [Irys](https://irys.xyz) - Upload protocol
- [Metaplex](https://www.metaplex.com) - NFT standard

---

**Made by CHECKHC** - Blockchain certification made easy 🚀
