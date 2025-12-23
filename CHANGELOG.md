# Changelog

All notable changes to **n8n-nodes-digicryptostore** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2025-01-12

### 🎉 Initial Release

**DigiCryptoStore** - Fork from `n8n-nodes-photocertif` with exclusive focus on document certification (media/docs).

### Added
- **Ultra-simplified workflow v2.4.0**: 2 nodes instead of 13
  - Node 1: Input Data
  - Node 2: Certify My Document (does everything)
- **Unified API endpoint**: `/api/storage/docs/b2b-certify-full`
  - Single API call for complete certification
  - Automatic SOL→CHECKHC swap
  - Automatic CHECKHC transfers (main + affiliate)
  - Permanent Arweave storage (3 files: original, preview, metadata)
  - NFT creation on Solana
  - Complete in ~30-60 seconds
- **Permanent Arweave/Irys storage**: All documents stored permanently
- **Automated B2B workflow**: Zero human intervention required
- **Private key transmission**: Transmitted once in HTTPS (not 6 times)
- **Documentation**:
  - `README.md`: Complete consolidated guide
  - `QUICK_START_DIGICRYPTOSTORE.md`: 2-minute setup
  - `WORKFLOW_V2.4.0_README.md`: Detailed workflow documentation

### Changed
- **Package renamed**: `n8n-nodes-photocertif` → `n8n-nodes-digicryptostore`
- **Focus**: Document certification only (media/docs)
- **Removed**: All media/image, media/image2, media/image3 references
- **Simplified**: From 13 nodes to 2 nodes
- **Centralized**: All business logic moved to backend

### Removed
- **Obsolete workflows**: v1.1.0, v2.0.0, v2.1.0, v2.2.0
- **Obsolete documentation**: 28 redundant/obsolete MD files removed
- **Image certification**: media/image2 workflows and documentation
- **Art certification**: Removed to focus exclusively on documents

### Fixed
- **Private key security**: Now transmitted once instead of 6 times
- **Error handling**: Centralized in single endpoint with rollback support
- **Transaction atomicity**: All operations in single request
- **Logging**: Unified backend logs with `[B2B FULL]` prefix

### Technical Details
- **Dependencies**: Requires `n8n-nodes-solana-swap` v1.6.1+
- **Blockchain**: Solana mainnet-beta
- **Storage**: Arweave via Irys
- **Payment**: CHECKHC tokens (auto-swap from SOL)
- **NFT Standard**: Metaplex
- **Backend**: Next.js 15.1.5

### Pricing
- **Service**: ~10 USD per certification (paid in CHECKHC)
- **Blockchain fees**: ~0.03-0.06 SOL per document
  - Arweave storage (3 files): ~0.02-0.05 SOL
  - NFT minting: ~0.01 SOL

### Security
- Private keys encrypted in n8n credentials
- API keys with scoped permissions
- Dedicated wallet recommended (~0.5 SOL + 10,000 CHECKHC)
- HTTPS transmission for all sensitive data

### Performance
- Complete certification: ~30-60 seconds
- 3 Irys uploads: ~10-20 seconds
- NFT creation: ~5-10 seconds
- Automatic retries and error handling

---

## [1.2.0] - 2025-01-26

### 🎉 NEW: SolMemo Node with C2PA Support

**Major Addition**: New **SolMemo** node for blockchain timestamping with AI detection and C2PA authenticity.

### Added
- **NEW Node: SolMemo by CHECKHC**
  - Blockchain timestamping on Solana
  - AI authenticity detection (2 modes: Documentary/Artistic)
  - C2PA content authenticity metadata
  - Credit-based pricing (ultra-competitive)
  
- **4 Operations**:
  1. **Create Certificate**: Upload + timestamp with optional AI
  2. **Get Status**: Check certification status
  3. **Create C2PA File**: Generate C2PA-embedded file (images only)
  4. **Download C2PA**: Download authenticity file

- **AI Detection Features**:
  - Documentary mode: 2-level strict analysis (legal/proof photos)
  - Artistic mode: 4-level tolerant analysis (art/NFT)
  - Human vs AI probability scoring
  - Confidence levels and certification reasons
  
- **C2PA Integration**:
  - FREE for images (solo mode)
  - Auto-bundled with AI analysis (30 credits)
  - Blockchain hash embedded in manifest
  - AI results in custom assertions
  - 4-hour temporary storage (GDPR compliant)
  - Industry-standard Content Authenticity Initiative

### Pricing
- **Simple cert**: 1 credit (~0.10€)
- **AI + C2PA bundled**: 30 credits (~3€)
- **C2PA solo**: FREE (images only)

**Comparison**:
- Truepic: $50/inspection
- SolMemo: 0.33€/cert (Business plan)
- **150x cheaper!**

### B2C Plans
- Starter: 9€/month = 100 credits
- Premium: 25€/month = 400 credits

### B2B Plans
- Business: 99€/month = 300 certs (flat rate)
- Business Pro: 299€/month = 1,500 certs (flat rate)
- Enterprise: 999€/month = 10,000 certs (flat rate)

### Technical Details
- **API Endpoints**: 4 new SolMemo APIs
- **File Support**: Images (JPEG, PNG, WebP)
- **Max File Size**: 10MB
- **Timeouts**: 30s standard, 60s with AI, 300s C2PA
- **Security**: Bearer auth, HTTPS only, localhost dev support
- **C2PA Expiration**: 4 hours (auto-cleanup)

### Documentation
- `SOLMEMO_README.md`: Complete SolMemo guide
- C2PA workflow examples
- AI detection use cases
- Pricing comparison tables

### Changed
- **Package description**: Added "AI detection" and "C2PA authenticity"
- **Keywords**: Added "solmemo", "c2pa", "content-authenticity", "ai-detection", "timestamp"
- **Version**: 1.1.1 → 1.2.0

---

## Future Releases

### [1.3.0] - Planned
- Batch processing for SolMemo
- Webhook notifications
- Enhanced error reporting
- Status dashboard

---

## Support

- 📧 Email: contact@checkhc.net
- 🌐 Website: https://www.checkhc.net
- 💬 GitHub Issues: https://github.com/checkhc/n8n-nodes-digicryptostore/issues

---

**Made by CHECKHC** 🚀
