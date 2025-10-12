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

## Future Releases

### [1.1.0] - Planned
- Batch processing optimization
- Enhanced error reporting
- Webhook notifications
- Status dashboard

### [1.2.0] - Planned
- Multi-collection support
- Advanced affiliate tracking
- Custom watermark templates
- API v2 integration

---

## Support

- 📧 Email: contact@checkhc.net
- 🌐 Website: https://www.checkhc.net
- 💬 GitHub Issues: https://github.com/checkhc/n8n-nodes-digicryptostore/issues

---

**Made by CHECKHC** 🚀
