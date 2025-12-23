# 🎉 Release Notes v1.2.4 - SolMemo Integration

**Release Date:** 2025-10-31
**Package:** n8n-nodes-digicryptostore
**Type:** Minor Update (New Feature)

---

## ✨ What's New

### **📝 SolMemo Node Added!**

Cette version introduit le **SolMemo node** - un système révolutionnaire de timestamping blockchain avec détection IA et authentification C2PA.

#### **Trois Modes de Certification:**

1. **🔐 Hash Simple (1 credit - €0.08)**
   - Timestamping SHA-256 sur Solana
   - Fichier JAMAIS uploadé (RGPD parfait)
   - 30 secondes, 100% automatisé

2. **🤖 AI Strict + C2PA (30 credits - €0.90)**
   - Hash + Analyse IA (Humain vs IA)
   - Métadonnées C2PA (standard Adobe)
   - Parfait pour photos documentaires

3. **🎨 AI Art + C2PA (30 credits - €0.90)**
   - Hash + Analyse IA (5 niveaux)
   - Accepte post-production artistique
   - Parfait pour art numérique

### **📄 DigiCryptoStore Node Enhanced**

- Renommage "B2B Certify Full" → "NFT Documents store" (plus clair)
- Version dynamique affichée (v1.2.4)
- Documentation améliorée

---

## 📊 Key Features

### **SolMemo Highlights:**

✅ **Privacy-First** - Mode hash-only (GDPR compliant)
✅ **AI Detection** - Détection contenu IA automatique
✅ **C2PA Standard** - Compatible Adobe/Microsoft/BBC
✅ **Blockchain Proof** - Solana immutable timestamping
✅ **Low Cost** - À partir de €0.08 par certification
✅ **Free Tier** - 30 crédits gratuits/mois

### **Use Cases:**

- 📸 **Photography** - Prouver authenticité humaine
- 🎨 **Digital Art** - Protection contre copies IA
- 📝 **Confidential Docs** - Hash-only (fichier reste local)
- 🏢 **IP Protection** - Timestamp instantané
- 🗞️ **Journalism** - Vérification authenticité photos

---

## 🔧 Technical Changes

### **Files Modified:**

1. **nodes/SolMemo/SolMemo.node.ts** ✨ NEW
   - Nouveau node pour timestamping
   - 3 modes: simple, ai_strict, ai_art
   - Intégration API SolMemo

2. **nodes/DigiCryptoStore/DigiCryptoStore.node.ts**
   - Renommage opération "NFT Documents store"
   - Version dynamique `${packageJson.version}`

3. **README.md**
   - Section complète SolMemo
   - Comparaison 2 nodes
   - Vision CHECKHC "Certified Human Data Layer"
   - Market opportunity ($22B TAM)

4. **package.json**
   - Version 1.2.4
   - Keywords ajoutés: ai-detection, c2pa, solmemo
   - Description mise à jour

5. **NPM_PUBLICATION_GUIDE.md** ✨ NEW
   - Guide complet publication npm
   - Pourquoi publier
   - Procédure étape par étape

---

## 📦 Installation

### **Nouvelle Installation:**

```bash
npm install n8n-nodes-digicryptostore@1.2.4
```

### **Mise à Jour depuis v1.2.3:**

```bash
cd ~/.n8n/nodes
npm update n8n-nodes-digicryptostore
```

**Puis redémarrer n8n:**
```bash
n8n stop
n8n start
```

---

## 🎯 Breaking Changes

❌ **Aucun breaking change**

Tous les workflows existants utilisant DigiCryptoStore continueront de fonctionner sans modification.

---

## 📈 Migration Guide

### **Pour utilisateurs existants:**

Rien à faire ! La version 1.2.4 est 100% compatible avec vos workflows actuels.

### **Pour tester SolMemo:**

1. Créer nouveau workflow
2. Ajouter node "SolMemo by CHECKHC"
3. Configurer credentials (même que DigiCryptoStore)
4. Choisir mode certification
5. Exécuter !

---

## 🌟 Highlights

### **Pourquoi cette release est importante:**

1. **🎯 Market Expansion**
   - Nouvelle audience: Photographes, artistes, créateurs
   - Cas d'usage RGPD (hash-only)
   - Prix ultra-compétitif (€0.08)

2. **📊 Strategic Positioning**
   - "Certified Human Data Layer for AI Era"
   - Combat AI flood (34M images IA/jour)
   - Standard C2PA (industrie)

3. **💰 Revenue Opportunity**
   - DigiCryptoStore: B2B (~€10/doc)
   - SolMemo: B2C + Volume (€0.08-0.90)
   - Dual revenue streams

4. **🚀 Network Effects**
   - Plus de créateurs → Plus de données certifiées
   - Plus de données → Plus d'IA companies intéressées
   - Flywheel effect

---

## 📊 Metrics & Goals

### **Target Metrics (6 months):**

**npm Downloads:**
- Month 1: 50/week
- Month 3: 200/week
- Month 6: 500/week

**Active Users:**
- DigiCryptoStore: 100+ enterprises
- SolMemo: 1,000+ creators
- Total certifications: 50,000+

**Revenue Impact:**
- DigiCryptoStore: €50k/month
- SolMemo: €20k/month
- Total: €70k/month (€840k/year)

---

## 🐛 Known Issues

### **Beta Status:**
- SolMemo en beta active
- Feedback bienvenu sur Discord
- Améliorations continues

### **Limitations:**
- C2PA nécessite upload fichier (modes AI)
- Processing time 2-3 min (modes AI)
- Max file size 10MB

---

## 🔗 Resources

### **Documentation:**
- README.md (complet avec SolMemo)
- NPM_PUBLICATION_GUIDE.md (publication npm)
- QUICK_START guides existants

### **Support:**
- Discord: https://discord.com/channels/1324516144979382335/1429512698504151200
- Email: contact@checkhc.net
- GitHub Issues: https://github.com/checkhc/n8n-nodes-digicryptostore/issues

### **Platform:**
- CHECKHC: https://www.checkhc.net
- Platform: https://photocertif.checkhc.net
- npm: https://www.npmjs.com/package/n8n-nodes-digicryptostore

---

## 🙏 Thanks

Merci à la communauté n8n pour le support continu !

**Next Release:** v1.3.0 (prévue dans 4-6 semaines)
- Améliorations SolMemo basées sur feedback
- Nouvelles features DigiCryptoStore
- Performance optimizations

---

**Built with ❤️ by CHECKHC Team**
