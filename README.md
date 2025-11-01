# n8n-nodes-digicryptostore

<div align="center">

[![npm version](https://img.shields.io/npm/v/n8n-nodes-digicryptostore)](https://www.npmjs.com/package/n8n-nodes-digicryptostore)
[![Status](https://img.shields.io/badge/Status-Beta-yellow)](https://github.com/checkhc/n8n-nodes-digicryptostore)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![CHECKHC](https://img.shields.io/badge/Powered_by-CHECKHC-orange?style=flat&logo=solana)](https://www.checkhc.net)
[![Discord Support](https://img.shields.io/badge/Support-Discord-5865F2)](https://discord.com/channels/1324516144979382335/1429512698504151200)

### 🔐 **Blockchain Certification for Digital Content**
### 📝 **Two Powerful Nodes: DigiCryptoStore + SolMemo**

**Powered by [CHECKHC](https://www.checkhc.net) - The Certified Human Data Layer for the AI Era**

[🌐 CHECKHC.net](https://www.checkhc.net) | [📦 App Platform](https://app2.photocertif.com) | [💬 Discord Support](https://discord.com/channels/1324516144979382335/1429512698504151200)

</div>

---

> ⚠️ **Beta Status**: This package is in active development. Features are functional but we're continuously improving based on user feedback. Join our [Discord channel](https://discord.com/channels/1324516144979382335/1429512698504151200) for support and updates.

---

## 🎯 What's Inside This Package?

This n8n community package provides **two powerful nodes** for blockchain-based content certification:

### 📄 **1. DigiCryptoStore** - NFT Document Certification
Permanent document certification with NFT minting on Solana blockchain. Perfect for legal documents, contracts, and archival storage.

### 📝 **2. SolMemo** - Hash Timestamping + AI Verification ✨ **NEW!**
Privacy-first blockchain timestamping with optional AI detection and C2PA authenticity. Perfect for photos, images, and confidential files.

###  **Combined Key Features:**

#### DigiCryptoStore Features:
- 📄 **Document Certification** - PDF, DOCX, XLSX, and more
- 🎨 **NFT Minting** - Each document gets a unique NFT on Solana
- ☁️  **Permanent Storage** - Arweave decentralized storage
- 💰 **Automated Payments** - CHECKHC tokens paid automatically

#### SolMemo Features:
- 🔐 **Privacy-First** - Hash-only mode (file never leaves your device)
- 🤖 **AI Detection** - Optional AI analysis (human vs AI content)
- 🏷️ **C2PA Standard** - Industry-standard authenticity metadata
- ⚡ **Ultra-Fast** - 30 seconds for simple hash, 2 minutes with AI
- 💸 **Low Cost** - From 1 credit (€0.08) for hash-only

#### Common Features:
- 🔒 **Blockchain Proof** - Immutable timestamping on Solana
- 🤖 **Full Automation** - Zero manual intervention
- 🔐 **Secure** - Private keys encrypted in n8n credentials
- 🇪🇺 **GDPR Compliant** - Privacy by design

### **Perfect For:**

#### Use DigiCryptoStore for:
- 🏛️ Digital vaults and permanent document archiving
- 📊 High-volume B2B document certification (100s-1000s)
- ✅ Enterprise compliance and audit trails
- 🗄️ Legal document preservation with NFT proof

#### Use SolMemo for:
- 📸 **Photography** - Prove your images are human-created
- 🎨 **Digital Art** - Protect against AI copies
- 📝 **Confidential Documents** - Hash-only (GDPR compliant)
- 🏢 **IP Protection** - Timestamp creative work instantly
- 🗞️ **Journalism** - Verify photo authenticity with AI + C2PA

---

## 🚀 Quick Start

### **1. Install**

```bash
cd ~/.n8n
npm install n8n-nodes-digicryptostore
n8n start
```

### **2. Configure Credentials**

#### **Credential A: DigiCryptoStore API**
1. Get API key from: https://app2.photocertif.com
2. In n8n: **Credentials** → **PhotoCertif API**
3. Enter URL: `https://app2.photocertif.com` and your API key

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

### **Simple 4-Step Process:**

```
1. 📤 Upload Your Document
   → PDF, DOCX, XLSX, or any file type
   → Add title, description, and owner information

2. 💳 Automated Payment
   → Pay a few CHECKHC tokens (~10 USD)
   → No manual wallet interaction needed

3. ✅ Certification & Verification
   → Advanced verification process
   → NFT certificate created on blockchain
   → Unique proof of authenticity

4. 🎉 Get Your Results
   → NFT certificate in your wallet
   → Permanent certification proof
   → Downloadable certified document
```

**⏱️ Total Time:** ~30-60 seconds  
**🤖 Automation:** 100% automated (zero manual steps)  
**📦 Storage Options:**
- **Permanent** - For assets you want to monetize or keep forever
- **Erasable** - GDPR-compliant option (personal data can be deleted on request)

---

## 💰 Pricing

### **Per Certification:**

**CHECKHC Payment** (paid to DigiCryptoStore):
- ~10 USD per document (paid in CHECKHC tokens)
- Current rate: ~245 CHECKHC per certification

**Blockchain Fees** (paid in SOL from your wallet):
- Secure storage: ~0.02-0.05 SOL
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

## 📦 What You Get

Each certification includes:

1. **🎫 NFT Certificate**
   - Unique blockchain proof on Solana
   - Verifiable authenticity
   - Transferable ownership

2. **📄 Certified Document**
   - Your original file with certification
   - Watermarked preview for sharing
   - Downloadable anytime

3. **🔒 Verification Data**
   - All certification metadata
   - Cryptographic proof of authenticity
   - Compliant with industry standards

**🇪🇺 GDPR Compliance:**
- Choose **permanent storage** (ideal for NFT monetization)
- Or **erasable storage** (personal data can be deleted on request)

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

## 📝 SolMemo - Privacy-First Blockchain Timestamping

### **🎯 What is SolMemo?**

SolMemo is a revolutionary blockchain timestamping node that combines **privacy**, **AI detection**, and **industry standards** (C2PA).

**Three Certification Modes:**

1. **🔐 Simple Hash (1 credit - €0.08)**
   - SHA-256 hash timestamped on Solana
   - File **NEVER leaves your device** (GDPR perfect)
   - Perfect for confidential documents
   - 30 seconds, fully automated

2. **🤖 AI Strict + C2PA (30 credits - €0.90)**
   - Hash + AI analysis (2-level detection: Human/AI)
   - C2PA authenticity metadata (Adobe standard)
   - Perfect for documentary photos, legal evidence
   - 2-3 minutes processing

3. **🎨 AI Art + C2PA (30 credits - €0.90)**
   - Hash + AI analysis (5-level detection: 100% human → 100% AI)
   - Accepts artistic post-production
   - Perfect for digital art, creative photography
   - 2-3 minutes processing

### **⚡ Quick Comparison:**

| Feature | Simple Hash | AI + C2PA |
|---------|-------------|-----------|
| **Privacy** | ✅ File stays local | ⚠️ File uploaded |
| **Cost** | 💸 1 credit (€0.08) | 💰 30 credits (€0.90) |
| **Speed** | ⚡ 30 seconds | 🔄 2-3 minutes |
| **Use Case** | Documents, IP, Contracts | Photos, Art, Journalism |
| **Proof** | Hash + Blockchain | Hash + AI + C2PA + Blockchain |

### **🔧 SolMemo Operations:**

| Operation | Description |
|-----------|-------------|
| `Create Memo` | Create blockchain memo with optional AI + C2PA |
| `List Memos` | Retrieve all your blockchain timestamped files |

### **📊 SolMemo Workflow Example:**

```json
{
  "operation": "createMemo",
  "certificationMode": "simple",  // or "ai_strict" or "ai_art"
  "fileData": "base64...",        // or use "fileUrl"
  "title": "My Photo",
  "author": "John Doe",
  "description": "Original shot 2025",
  "iv_storageid": "optional-storage-id"
}
```

**Output:**
```json
{
  "success": true,
  "memo": {
    "iv_storageid": "iv_xxx...",
    "blockchain_signature": "5xABc...",
    "hash_sha256": "abc123...",
    "ai_analysis": {  // Only if AI mode
      "is_ai_generated": false,
      "confidence": 0.95,
      "model": "strict"
    },
    "c2pa_created": true,  // Only if AI mode
    "c2pa_download_url": "https://...",
    "verification_url": "https://app2.photocertif.com/verify/xxx"
  }
}
```

### **🌟 Why Choose SolMemo?**

✅ **Privacy by Design** - Hash mode keeps files local  
✅ **AI-Proof** - Detect AI-generated content automatically  
✅ **Industry Standard** - C2PA compatible (Adobe, Microsoft, BBC)  
✅ **Blockchain Immutable** - Solana timestamping (400ms finality)  
✅ **Low Cost** - From €0.08 per timestamping  
✅ **Free Tier** - 30 free credits/month for all users  

### **📸 Perfect for Photographers & Artists:**

> 🎨 **Protect your work in the AI era**
> 
> With 34 million AI images created daily, proving your work is human-made has never been more critical. SolMemo provides:
> - Blockchain proof of creation date
> - AI analysis confirming human authorship
> - C2PA metadata for industry compliance
> - All automated from n8n

---

## 🔗 Links

- **🌐 Official Website**: https://www.checkhc.net
- **📦 App Platform**: https://app2.photocertif.com
- **📚 GitHub**: https://github.com/checkhc/n8n-nodes-digicryptostore
- **📦 npm Package**: https://www.npmjs.com/package/n8n-nodes-digicryptostore
- **Discord Support** (Primary): https://discord.com/channels/1324516144979382335/1429512698504151200
  - Real-time community support
  - Direct access to developers
  - Share workflows and tips
- **Email Support**: contact@checkhc.net

---

## 📄 License

MIT © [CHECKHC](https://checkhc.net)

---

## 🏢 About CHECKHC - The Certified Human Data Layer

**[CHECKHC](https://www.checkhc.net)** is building the **Certified Human Data Layer for the AI Era**.

### **🎯 Our Mission:**

In a world flooding with AI-generated content (34M images/day), we provide **forensic-grade certification** to prove human authorship and prevent AI training collapse.

### **🛠️ Our Solutions:**

#### For Individuals & Creators:
- 📝 **[SolMemo](https://app2.photocertif.com)** - Privacy-first hash timestamping (from €0.08)
- 🎨 **Image Certification** - AI detection + C2PA authenticity
- 📸 **Free Tier** - 30 credits/month for all users
- 🪙 **$CHECKHC Token** - Earn by certifying, spend on services

#### For Enterprises & B2B:
- 📄 **DigiCryptoStore** - NFT document certification with permanent storage
- 🤖 **n8n Automation** - This package! Full workflow automation
- 🏢 **API Access** - Bulk certification, custom integration
- 💼 **White-Label** - Private blockchain certification platform

#### For AI Companies:
- 🧬 **Certified Training Data** - Human-verified datasets
- ✅ **EU AI Act Compliant** - Regulation-ready from day one
- 🔬 **Forensic Proof** - Prevent AI-to-AI training collapse
- 📊 **Dataset Marketplace** - Access to certified human data

### **🌟 Why CHECKHC Leads the Market:**

**Technical Edge:**
- 🔐 **Triple Validation** - Hash + Blockchain + AI + C2PA
- 🔒 **Privacy by Design** - GDPR-compliant hash-only mode
- ⚡ **Solana Speed** - 400ms blockchain finality
- 💸 **Low Cost** - 200x cheaper than Ethereum alternatives

**Ecosystem Advantage:**
- 🪙 **Token Utility** - $CHECKHC powers entire ecosystem
- 🔄 **Two-Sided Marketplace** - Creators supply, AI companies demand
- 📈 **Network Effects** - More users = more value = more adoption
- 🌐 **Open Standards** - C2PA, Solana, decentralized storage

**First-Mover Lead:**
- ⏰ **18-24 months ahead** - Competitors just starting
- 🎯 **Market Timing** - EU AI Act enforcement 2025
- 💰 **$22B TAM** - Growing 30%/year
- 🚀 **Proven Tech** - Already deployed, already working

### **📈 Market Opportunity:**

```
AI Training Data Market:        $10B/year (growing 50%/year)
Content Authenticity Market:    $15B/year (2027 projection)
Digital Notarization Market:    $3B/year
Creator Tools Market:           $5B/year
──────────────────────────────────────────────────────
Total Addressable Market:       $22B/year (2027)
CHECKHC Target (Year 3):        10-20% market share
```

**Our Vision:** Become the **industry standard** for human content certification, like DocuSign is for e-signatures.

### **🚀 Get Started Today:**

#### For Creators:
1. **Try for Free:** Get 30 credits/month → [app2.photocertif.com](https://app2.photocertif.com)
2. **Install n8n:** Automate your workflow with this package
3. **Join Community:** [Discord](https://discord.com/channels/1324516144979382335/1429512698504151200)

#### For Enterprises:
1. **Book Demo:** See bulk certification in action
2. **Pilot Program:** Test with your documents/images
3. **Custom Integration:** API, white-label, or n8n automation

📧 Contact: **contact@checkhc.net**  
🌐 **Official Website: [www.checkhc.net](https://www.checkhc.net)** ⭐  
💼 Platform: **[app2.photocertif.com](https://app2.photocertif.com)**  

### **🪙 Get $CHECKHC Tokens:**

- **Buy:** [Jupiter Aggregator](https://jup.ag/swap/SOL-CHECKHC)  
- **Earn:** Certify content and earn tokens  
- **Stake:** Coming soon - Governance + rewards  

**Token Address:** `5tpkrCVVh6tjjve4TuyP8MXBwURufgAnaboaLwo49uau`

---

## 🙏 Credits

Built with ❤️ by the **[CHECKHC](https://www.checkhc.net)** team.

**Powered by:**
- [n8n](https://n8n.io) - Workflow automation platform
- [Solana](https://solana.com) - High-performance blockchain
- Leading decentralized storage technologies
- Industry-standard NFT protocols

---

**Made by CHECKHC** - Making blockchain certification easy & accessible 🚀
