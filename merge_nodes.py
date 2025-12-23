#!/usr/bin/env python3
"""
Fusionne DigiCryptoStore avec les opérations B2B et List NFTs
en excluant les champs interdits (Storage ID, Affiliate Code, Collection Mint)
"""

# Lire le fichier actuel (base SolMemo)
with open('nodes/DigiCryptoStore/DigiCryptoStore.node.ts', 'r', encoding='utf-8') as f:
    current = f.read()

# Lire l'ancien fichier complet
with open('nodes/DigiCryptoStore/DigiCryptoStore.node.OLD_BEFORE_UNIFY.ts', 'r', encoding='utf-8') as f:
    old_full = f.read()

# Trouver où insérer les paramètres B2B (avant CREATE CERTIFICATE PARAMETERS)
insert_pos = current.find('// CREATE CERTIFICATE PARAMETERS')
if insert_pos == -1:
    print("❌ Impossible de trouver le point d'insertion")
    exit(1)

# Extraire les paramètres B2B de l'ancien fichier (sans les champs interdits)
# Chercher la section B2B CERTIFY FULL PARAMETERS
b2b_start = old_full.find('// B2B CERTIFY FULL PARAMETERS')
b2b_end = old_full.find('// LIST NFTs PARAMETERS', b2b_start)

if b2b_start == -1 or b2b_end == -1:
    print("❌ Impossible de trouver les sections B2B")
    exit(1)

b2b_section = old_full[b2b_start:b2b_end]

# Supprimer les 3 champs interdits
lines_to_remove = []
skip_until = None

output_lines = []
for i, line in enumerate(b2b_section.split('\n')):
    # Détecter le début d'un champ à supprimer
    if "displayName: 'Storage ID'" in line and "storageIdB2b" in b2b_section[max(0, b2b_section.find(line)-200):b2b_section.find(line)+500]:
        skip_until = '},\n'
        continue
    elif "displayName: 'Collection Mint Address'" in line:
        skip_until = '},\n'
        continue
    elif "displayName: 'Affiliate Code'" in line:
        skip_until = '},\n'
        continue
    
    # Skip lines jusqu'au prochain },
    if skip_until:
        if line.strip() == '},':
            skip_until = None
        continue
    
    output_lines.append(line)

b2b_clean = '\n'.join(output_lines)

# Extraire List NFTs parameters
list_nft_start = old_full.find('// LIST NFTs PARAMETERS')
# Chercher la fin (avant execute ou autre section majeure)
list_nft_end = old_full.find('],\n\t};', list_nft_start)

if list_nft_start == -1 or list_nft_end == -1:
    print("❌ Impossible de trouver List NFTs parameters")
    exit(1)

list_nft_section = old_full[list_nft_start:list_nft_end]

# Insérer dans le fichier actuel
before = current[:insert_pos]
after = current[insert_pos:]

new_content = before + b2b_clean + '\n\n\t\t\t' + list_nft_section + '\n\n\t\t\t// ============================================\n\t\t\t' + after

# Écrire le nouveau fichier
with open('nodes/DigiCryptoStore/DigiCryptoStore.node.ts', 'w', encoding='utf-8') as f:
    f.write(new_content)

print("✅ Paramètres B2B et List NFTs ajoutés")
print(f"📊 Longueur: {len(new_content)} caractères")
