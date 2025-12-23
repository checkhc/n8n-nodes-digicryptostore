# DigiCryptoStore Node - Upgrade Specification

## Modifications nécessaires pour utiliser l'API unifiée `/api/solmemo/create`

### 1. memoTimestamps Operation (ligne ~592-681)

**Remplacer tout le bloc depuis:**
```typescript
const hash = crypto.createHash('sha256').update(fileBuffer).digest('hex');

const requestBody: any = {
    hash,
    hash_algorithm: 'SHA-256',
    original_filename: filename,
    file_extension: fileExtension,
    file_size: fileSize,
};

if (title) requestBody.title = title;
if (description) requestBody.description = description;
if (tags) requestBody.tags = tags.split(',').map((t: string) => t.trim());

let apiEndpoint: string;
if (paymentMethod === 'credits') {
    apiEndpoint = '/api/solmemo/create-with-credit';
} else {
    const solanaCredentials = await this.getCredentials('solanaApi', i);
    requestBody.user_private_key = solanaCredentials.privateKey as string;
    apiEndpoint = '/api/storage/solmemo/create-hash';
}

const response = await axios.post(
    `${baseUrl}${apiEndpoint}`,
    requestBody,
    {
        timeout: REQUEST_TIMEOUT,
        headers: {
            'Authorization': `Bearer ${apiKey}`,
            'Content-Type': 'application/json',
        },
        ...getAxiosConfig(baseUrl),
    },
);
```

**Par:**
```typescript
const enableAI = this.getNodeParameter('enableAI', i, false) as boolean;
const aiEndpoint = this.getNodeParameter('aiEndpoint', i, 'image') as string;

const requestBody: any = {
    file_data: fileBuffer.toString('base64'),
    payment_mode: paymentMethod,
    usage_type: enableAI ? 'ai' : 'simple',
    ai_endpoint: enableAI ? aiEndpoint : undefined,
    title: title || undefined,
    description: description || undefined,
    tags: tags || undefined,
};

// For wallet payment, need private key
if (paymentMethod === 'wallet') {
    const solanaCredentials = await this.getCredentials('solanaApi', i);
    requestBody.user_private_key = solanaCredentials.privateKey as string;
}

const response = await axios.post(
    `${baseUrl}/api/solmemo/create`,
    requestBody,
    {
        timeout: enableAI ? 120000 : REQUEST_TIMEOUT, // 2min for AI, 30s for simple
        headers: {
            'Authorization': `Bearer ${apiKey}`,
            'Content-Type': 'application/json',
        },
        ...getAxiosConfig(baseUrl),
    },
);
```

### 2. Ajouter paramètres AI pour memoTimestamps (après tags, ligne ~363)

```typescript
{
    displayName: 'AI Analysis',
    name: 'enableAI',
    type: 'boolean',
    displayOptions: {
        show: {
            operation: ['memoTimestamps'],
        },
    },
    default: false,
    description: 'Enable AI analysis for images (30 credits vs 1 credit)',
},
{
    displayName: 'AI Endpoint',
    name: 'aiEndpoint',
    type: 'options',
    displayOptions: {
        show: {
            operation: ['memoTimestamps'],
            enableAI: [true],
        },
    },
    options: [
        {
            name: 'Photo Authenticity (Strict)',
            value: 'image',
            description: 'Documentary/legal proof analysis (2 levels)',
        },
        {
            name: 'Art Certification (Tolerant)',
            value: 'art',
            description: 'Creative works analysis (4 levels)',
        },
    ],
    default: 'image',
    description: 'Type of AI analysis to perform',
},
```

### 3. b2bCertifyFull Operation (ligne ~686-746)

**Remplacer:**
```typescript
requestBody = {
    file_url: imageUrl,
    ai_analysis: true,
    title: title || undefined,
    description: description || undefined,
    tags: tags || undefined,
    payment_mode: paymentMode,
};
```

**Par:**
```typescript
requestBody = {
    file_url: imageUrl,
    payment_mode: paymentMode,
    usage_type: 'ai',
    ai_endpoint: aiEndpointB2b,
    title: title || undefined,
    description: description || undefined,
    tags: tags || undefined,
};
```

**Et pour base64:**
```typescript
requestBody = {
    file_data: fileData, // Already cleaned from data URI
    payment_mode: paymentMode,
    usage_type: 'ai',
    ai_endpoint: aiEndpointB2b,
    title: title || undefined,
    description: description || undefined,
    tags: tags || undefined,
};
```

**Ajouter support wallet après le requestBody:**
```typescript
// For wallet payment, need private key
if (paymentMode === 'wallet') {
    const solanaCredentials = await this.getCredentials('solanaApi', i);
    requestBody.user_private_key = solanaCredentials.privateKey as string;
}
```

**Modifier l'appel API:**
```typescript
// Call unified SolMemo create API with AI
const response = await axios.post(
    `${baseUrl}/api/solmemo/create`, // Changed from /api/solmemo/create-with-ai
    requestBody,
    {
        timeout: 120000, // 2 minutes timeout for AI processing
        headers: {
            'Authorization': `Bearer ${apiKey}`,
            'Content-Type': 'application/json',
        },
        ...getAxiosConfig(baseUrl),
    },
);
```

### 4. Ajouter paramètre AI Endpoint pour b2bCertifyFull (avant paymentMode, ligne ~461)

```typescript
{
    displayName: 'AI Endpoint',
    name: 'aiEndpointB2b',
    type: 'options',
    displayOptions: {
        show: {
            operation: ['b2bCertifyFull'],
        },
    },
    options: [
        {
            name: 'Photo Authenticity (Strict)',
            value: 'image',
            description: 'Documentary/legal proof analysis (2 levels)',
        },
        {
            name: 'Art Certification (Tolerant)',
            value: 'art',
            description: 'Creative works analysis (4 levels)',
        },
    ],
    default: 'art',
    description: 'Type of AI analysis to perform',
},
```

### 5. Récupérer aiEndpointB2b dans b2bCertifyFull (ligne ~688)

```typescript
const aiEndpointB2b = this.getNodeParameter('aiEndpointB2b', i, 'art') as string;
```

### 6. Mettre à jour les descriptions des Payment Method

**memoTimestamps:**
- Credits: "Use pre-purchased subscription credits"
- Wallet: "Pay with CHECKHC tokens (requires Solana credential)"

**b2bCertifyFull:**
- Credits (default): "Use subscription credits (requires active plan)"
- Wallet: "Pay with wallet (requires Solana credential)"

## 7. Ajouter validation du type de fichier (SÉCURITÉ)

**Avant l'appel API, valider le type de fichier via magic bytes :**

### Pour memoTimestamps (avec enableAI = true)

Ajouter après la récupération du fichier (ligne ~605) :

```typescript
if (enableAI) {
  // Validate file type using magic bytes
  const header = fileBuffer.slice(0, 12);
  
  let isValidForAI = false;
  
  // Check JPEG (FF D8 FF)
  if (header[0] === 0xFF && header[1] === 0xD8 && header[2] === 0xFF) {
    isValidForAI = true;
  }
  // Check PNG (89 50 4E 47 0D 0A 1A 0A)
  else if (header[0] === 0x89 && header[1] === 0x50 && header[2] === 0x4E && 
           header[3] === 0x47 && header[4] === 0x0D && header[5] === 0x0A && 
           header[6] === 0x1A && header[7] === 0x0A) {
    isValidForAI = true;
  }
  // Check WebP (RIFF...WEBP)
  else if (header[0] === 0x52 && header[1] === 0x49 && header[2] === 0x46 && 
           header[3] === 0x46 && header[8] === 0x57 && header[9] === 0x45 && 
           header[10] === 0x42 && header[11] === 0x50) {
    isValidForAI = true;
  }
  
  if (!isValidForAI) {
    throw new NodeOperationError(
      this.getNode(),
      'AI analysis only supports JPEG, PNG, and WebP images',
      { itemIndex: i }
    );
  }
}
```

### Pour b2bCertifyFull (AI toujours activé)

Ajouter après la récupération du fichier (si file_url) ou du base64 :

```typescript
// Validate file type for AI analysis
const fileBuffer = /* already loaded buffer */;
const header = fileBuffer.slice(0, 12);

let isValidForAI = false;

// Check JPEG, PNG, WebP (same logic as above)
if (header[0] === 0xFF && header[1] === 0xD8 && header[2] === 0xFF) {
  isValidForAI = true;
} else if (header[0] === 0x89 && header[1] === 0x50 && header[2] === 0x4E && 
           header[3] === 0x47 && header[4] === 0x0D && header[5] === 0x0A && 
           header[6] === 0x1A && header[7] === 0x0A) {
  isValidForAI = true;
} else if (header[0] === 0x52 && header[1] === 0x49 && header[2] === 0x46 && 
           header[3] === 0x46 && header[8] === 0x57 && header[9] === 0x45 && 
           header[10] === 0x42 && header[11] === 0x50) {
  isValidForAI = true;
}

if (!isValidForAI) {
  throw new NodeOperationError(
    this.getNode(),
    'AI analysis only supports JPEG, PNG, and WebP images',
    { itemIndex: i }
  );
}
```

**Alternative : Créer une fonction utilitaire**

Créer `utils/validateFileType.ts` :

```typescript
export function isValidForAI(buffer: Buffer): boolean {
  const header = buffer.slice(0, 12);
  
  // JPEG
  if (header[0] === 0xFF && header[1] === 0xD8 && header[2] === 0xFF) return true;
  
  // PNG
  if (header[0] === 0x89 && header[1] === 0x50 && header[2] === 0x4E && 
      header[3] === 0x47 && header[4] === 0x0D && header[5] === 0x0A && 
      header[6] === 0x1A && header[7] === 0x0A) return true;
  
  // WebP
  if (header[0] === 0x52 && header[1] === 0x49 && header[2] === 0x46 && 
      header[3] === 0x46 && header[8] === 0x57 && header[9] === 0x45 && 
      header[10] === 0x42 && header[11] === 0x50) return true;
  
  return false;
}
```

Puis dans le node :
```typescript
import { isValidForAI } from './utils/validateFileType';

if (enableAI && !isValidForAI(fileBuffer)) {
  throw new NodeOperationError(
    this.getNode(),
    'AI analysis only supports JPEG, PNG, and WebP images',
    { itemIndex: i }
  );
}
```

---

## Résultat Attendu

Après ces modifications, le node n8n supportera :
- ✅ API unifiée `/api/solmemo/create` pour tous les flux
- ✅ Mode credits et wallet pour memoTimestamps et b2bCertifyFull
- ✅ Choix entre endpoint `image` (strict) et `art` (tolérant)
- ✅ AI optionnel pour memoTimestamps
- ✅ AI toujours activé pour b2bCertifyFull
- ✅ Retour complet avec `irys_url`, `payment_signature`, `ai_results`
- ✅ **Validation sécurisée du type de fichier via magic bytes (JPEG/PNG/WebP uniquement)**

## APIs Obsolètes Supprimées

- ❌ `/api/solmemo/create-with-credit`
- ❌ `/api/solmemo/create-with-ai`
- ❌ `/api/storage/solmemo/create-hash`

## API Unifiée

- ✅ `/api/solmemo/create` (gère credits + wallet + simple + ai)
