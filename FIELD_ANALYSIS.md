# 🔍 Analyse des champs DigiCryptoStore Node vs API PhotoCertif

## 📋 Champs attendus par l'API `/api/storage/docs/certify/iv_route`

### **Champs OBLIGATOIRES (validés ligne 197-202) :**
```typescript
✅ name                    // Certification Name
✅ cert_symbol             // Symbol (4 uppercase letters max)
✅ cert_description        // Description
✅ cert_prop               // Owner (20 characters max)
✅ id                      // Storage ID (iv_storageid)
```

### **Champs OPTIONNELS :**
```typescript
⚪ cert_C2PA               // C2PA flag (false for docs)
⚪ collection_mint_address // NFT Collection address
⚪ external_url            // Website URL
⚪ twitter_url             // Twitter/X URL
⚪ discord_url             // Discord URL
⚪ instagram_url           // Instagram URL
⚪ telegram_url            // Telegram URL
⚪ medium_url              // Medium URL
⚪ wiki_url                // Wiki URL
⚪ youtube_url             // YouTube URL
```

---

## 📝 Champs dans le formulaire PhotoCertif (iv_CertificationForm.tsx)

### **État du formulaire (lignes 66-83) :**
```typescript
✅ name                    // Certification Name
✅ cert_symbol             // Symbol
✅ cert_description        // Description
✅ cert_prop               // Owner
❌ cert_C2PA               // COMMENTÉ (TODO: ligne 71)
❌ pinata_api              // NON UTILISÉ dans l'API
❌ pinata_api_secret       // NON UTILISÉ dans l'API
✅ collection_mint_address // Collection Mint Address
✅ external_url            // Website URL
✅ twitter_url             // Twitter/X URL
✅ discord_url             // Discord URL
✅ instagram_url           // Instagram URL
✅ telegram_url            // Telegram URL
✅ medium_url              // Medium URL
✅ wiki_url                // Wiki URL
✅ youtube_url             // YouTube URL
```

### **⚠️ PROBLÈMES IDENTIFIÉS dans le formulaire :**
1. **pinata_api** et **pinata_api_secret** - Non envoyés à l'API, champs inutiles
2. **cert_C2PA** - Commenté mais devrait être présent

---

## 🔧 Champs dans le Node DigiCryptoStore (DigiCryptoStore.node.ts)

### **Operation: 'b2bCertifyFull' (lignes 143-238) :**
```typescript
✅ inputType               // 'url' or 'base64'
✅ fileUrl                 // File URL (if inputType='url')
✅ fileData                // Base64 data (if inputType='base64')
✅ title                   // Document Title (mapped to 'name')
✅ description             // Description (optional - NOT cert_description!)
✅ fileExtension           // File extension
```

### **Operation: 'certify' - SÉPARÉE ! (lignes 270-480) :**
```typescript
✅ storageId               // Storage ID (ligne 273-285)
✅ name                    // Certification Name (ligne 288-301)
✅ cert_symbol             // Symbol (ligne 303-315)
✅ cert_description        // Description (ligne 317-332)
✅ cert_prop               // Owner (ligne 334-346)
✅ collection_mint_address // Collection (ligne 350-361)
✅ external_url            // Website URL (ligne 378-389)
✅ twitter_url             // Twitter/X URL (ligne 391-402)
✅ discord_url             // Discord URL (ligne 404-415)
✅ instagram_url           // Instagram URL (ligne 417-428)
✅ telegram_url            // Telegram URL (ligne 430-441)
✅ medium_url              // Medium URL (ligne 443-454)
✅ wiki_url                // Wiki URL (ligne 456-467)
✅ youtube_url             // YouTube URL (ligne 469-480)
```

---

## 🚨 PROBLÈMES MAJEURS IDENTIFIÉS

### **1. DOUBLON CRITIQUE : Deux opérations distinctes !**

Le node a **DEUX opérations séparées** :
- **`b2bCertifyFull`** (ligne 125-128) - Upload + Payment + Arweave + NFT
- **`certify`** (lignes 270-480) - Seulement certify avec métadonnées

**❌ PROBLÈME :** L'opération `certify` existe mais n'est **PAS listée** dans les options !

```typescript
// Lignes 123-138 - Options d'opération
options: [
  {
    name: 'NFT Documents store',
    value: 'b2bCertifyFull',    // ✅ Visible
  },
  {
    name: 'List NFTs',
    value: 'listNfts',           // ✅ Visible
  },
  // ❌ MANQUE: 'certify' operation !
],
```

### **2. CHAMPS EN DOUBLON dans 'b2bCertifyFull' :**

L'opération `b2bCertifyFull` a **deux champs "description" différents** :

1. **Description (ligne 211-223)** - Pour l'upload initial
   ```typescript
   name: 'description',  // Optional description
   ```

2. **cert_description (ligne 317-332)** - Pour la certification
   ```typescript
   name: 'cert_description',  // Detailed description (required)
   ```

**❌ CONFUSION :** Deux champs description différents !

### **3. Champs manquants pour flow complet :**

Si on utilise `b2bCertifyFull`, on doit passer :
- Upload params (fileUrl, title, description)
- **MAIS AUSSI** certification params (cert_symbol, cert_prop, cert_description, etc.)

**❌ ACTUELLEMENT :** Les champs de certification ne sont affichés que pour operation='certify'

---

## ✅ SOLUTION RECOMMANDÉE

### **Option A : Simplifier avec une seule opération complète**

Fusionner tout dans `b2bCertifyFull` :

```typescript
// Upload parameters
- inputType (url/base64)
- fileUrl / fileData
- fileExtension

// Certification parameters (TOUS affichés)
- name (Certification Name) - REQUIRED
- cert_symbol - REQUIRED
- cert_description - REQUIRED
- cert_prop (Owner) - REQUIRED
- collection_mint_address - OPTIONAL
- external_url - OPTIONAL
- twitter_url - OPTIONAL
- discord_url - OPTIONAL
- instagram_url - OPTIONAL
- telegram_url - OPTIONAL
- medium_url - OPTIONAL
- wiki_url - OPTIONAL
- youtube_url - OPTIONAL
```

**Supprimer :**
- ❌ Le champ `description` (ligne 211-223) - remplacé par `cert_description`
- ❌ Le champ `title` - utiliser directement `name` (Certification Name)
- ❌ L'opération `certify` séparée (ou la rendre visible)

### **Option B : Clarifier les deux opérations**

Garder deux opérations distinctes :

1. **Upload Only** - Juste upload le fichier
2. **NFT Documents store** (b2bCertifyFull) - Tout en un

Et **ajouter** l'opération `certify` dans les options si on veut permettre de certifier un document déjà uploadé.

---

## 📊 Comparaison finale

| Champ | API ✅ | Formulaire Web ✅ | Node (certify) ✅ | Node (b2bCertifyFull) ❌ |
|-------|--------|-------------------|-------------------|--------------------------|
| name | ✅ REQ | ✅ REQ | ✅ REQ | ❌ Nommé 'title' |
| cert_symbol | ✅ REQ | ✅ REQ | ✅ REQ | ❌ ABSENT |
| cert_description | ✅ REQ | ✅ REQ | ✅ REQ | ❌ ABSENT |
| cert_prop | ✅ REQ | ✅ REQ | ✅ REQ | ❌ ABSENT |
| id/storageId | ✅ REQ | ✅ | ✅ REQ | ❌ Créé par upload |
| collection_mint_address | ⚪ OPT | ✅ OPT | ✅ OPT | ❌ ABSENT |
| external_url | ⚪ OPT | ✅ OPT | ✅ OPT | ❌ ABSENT |
| twitter_url | ⚪ OPT | ✅ OPT | ✅ OPT | ❌ ABSENT |
| discord_url | ⚪ OPT | ✅ OPT | ✅ OPT | ❌ ABSENT |
| instagram_url | ⚪ OPT | ✅ OPT | ✅ OPT | ❌ ABSENT |
| telegram_url | ⚪ OPT | ✅ OPT | ✅ OPT | ❌ ABSENT |
| medium_url | ⚪ OPT | ✅ OPT | ✅ OPT | ❌ ABSENT |
| wiki_url | ⚪ OPT | ✅ OPT | ✅ OPT | ❌ ABSENT |
| youtube_url | ⚪ OPT | ✅ OPT | ✅ OPT | ❌ ABSENT |

---

## 🎯 CONCLUSION

**PROBLÈMES CRITIQUES :**

1. ❌ **Opération 'certify' existe mais n'est PAS VISIBLE** dans le sélecteur
2. ❌ **b2bCertifyFull ne contient PAS les champs de certification obligatoires**
3. ❌ **Doublon de champs 'description' vs 'cert_description'**
4. ❌ **'title' devrait être 'name' (Certification Name)**

**RÉSULTAT :**
Le node `b2bCertifyFull` ne peut PAS fonctionner car il manque **TOUS** les champs obligatoires de certification :
- cert_symbol
- cert_description  
- cert_prop

**ACTION REQUISE :**
Refactoriser le node pour :
1. Ajouter TOUS les champs de certification dans `b2bCertifyFull`
2. OU rendre l'opération `certify` visible
3. OU supprimer l'opération `certify` si non utilisée
4. Unifier les noms de champs (title → name, description → cert_description)
