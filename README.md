# n8n-nodes-digicryptostore

<div align="center">

[![npm version](https://img.shields.io/npm/v/n8n-nodes-digicryptostore)](https://www.npmjs.com/package/n8n-nodes-digicryptostore)
[![Status](https://img.shields.io/badge/Status-Beta-yellow)](https://github.com/checkhc/n8n-nodes-digicryptostore)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![CHECKHC](https://img.shields.io/badge/Powered_by-CHECKHC-orange?style=flat&logo=solana)](https://www.checkhc.net)
[![Discord Support](https://img.shields.io/badge/Support-Discord-5865F2)](https://discord.com/channels/1324516144979382335/1429512698504151200)

### 📄 **Document Certification with Permanent Blockchain Storage**
### 🚀 **Ultra-Simplified Workflow: 2 Nodes Only**

**Powered by [CHECKHC](https://www.checkhc.net) - The Web3 Certification Ecosystem**

[🌐 Visit CHECKHC.net](https://www.checkhc.net) | [📦 DigiCryptoStore Platform](https://app.photocertif.com) | [💬 Discord Community](https://discord.com/channels/1324516144979382335/1429512698504151200)

</div>

---

> ⚠️ **Beta Status**: This node is in active development. Features are functional but we're continuously improving based on user feedback. Join our [Discord channel](https://discord.com/channels/1324516144979382335/1429512698504151200) for support and updates.

---

## 🎯 What is DigiCryptoStore?

DigiCryptoStore is an n8n community node that enables **automated document certification** on the **Solana blockchain** with **secure permanent storage**.

###  **Key Features:**

- 📄 **Document Certification** - PDF, DOCX, XLSX, and more
- ☁️  **Flexible Storage** - Permanent (for monetization) or Erasable (GDPR compliant)
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
npm install n8n-nodes-digicryptostore
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

## 🏢 About CHECKHC

**[CHECKHC](https://www.checkhc.net)** is a pioneering Web3 ecosystem for digital content certification and authentication.

### **Our Solutions:**

- 📄 **[DigiCryptoStore](https://app.photocertif.com)** - Document Certification with Secure Blockchain Storage
- 🎨 **[PhotoCertif](https://app.photocertif.com)** - Image & Art Certification with AI Authentication
- 🪙 **CHECKHC Token** - Native utility token on Solana blockchain
- 🔗 **Blockchain Integration** - Solana + Secure Decentralized Storage
- 🤖 **AI-Powered** - Advanced detection for authenticity verification

### **Why Choose CHECKHC?**

- ✅ **Flexible Storage** - Permanent or Erasable (GDPR-compliant options)
- ✅ **Blockchain Proof** - Immutable NFT certificates on Solana
- ✅ **Full Automation** - Complete end-to-end automation with n8n
- ✅ **Enterprise Ready** - High-volume B2B document workflows
- ✅ **Ultra-Fast** - ~30-60 seconds per certification
- ✅ **Open Source** - Transparent & community-driven

### **🚀 Get Started:**

1. **Explore:** Visit [www.checkhc.net](https://www.checkhc.net)
2. **Try it:** Sign up at [app.photocertif.com](https://app.photocertif.com)
3. **Get CHECKHC Tokens:** [Buy on Jupiter](https://jup.ag/swap/SOL-CHECKHC)
4. **Automate:** Install this n8n node for B2B workflows
5. **Join Community:** [Discord Channel](https://discord.com/channels/1324516144979382335/1429512698504151200)

### **💼 Enterprise Solutions:**

Looking for custom integration or high-volume licensing?

📧 Contact: **contact@checkhc.net**  
🌐 Website: **[www.checkhc.net](https://www.checkhc.net)**

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
