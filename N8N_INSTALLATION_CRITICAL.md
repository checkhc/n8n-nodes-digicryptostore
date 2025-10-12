�� N8N COMMUNITY NODES - DOUBLE INSTALLATION CRITICAL

PROBLÈME RENCONTRÉ
==================
Le node PhotoCertif s'affichait comme "PhotoCertif" au lieu de "PhotoCertif by CHECKHC"
Le code source était correct mais l'UI n8n affichait l'ancien nom
Le problème persistait même après rebuild, réinstallation et vidage de cache

ROOT CAUSE IDENTIFIÉE
======================
n8n charge les community nodes depuis DEUX emplacements différents:

1. ~/.n8n/node_modules/n8n-nodes-photocertif/
   → Pour les dépendances npm standard
   → Installé via: cd ~/.n8n && npm install <package>

2. ~/.n8n/nodes/node_modules/n8n-nodes-photocertif/
   → Pour les community nodes installés via l'UI n8n
   → Ce répertoire a PRIORITÉ sur ~/.n8n/node_modules/
   → Installé via: cd ~/.n8n/nodes && npm install <package>

SOLUTION APPLIQUÉE
==================
Pour un community node en développement local:

1. Désinstaller des DEUX emplacements:
   cd ~/.n8n && npm uninstall n8n-nodes-photocertif
   cd ~/.n8n/nodes && npm uninstall n8n-nodes-photocertif

2. Réinstaller dans LES DEUX emplacements:
   cd ~/.n8n && npm install /path/to/package.tgz
   cd ~/.n8n/nodes && npm install /path/to/package.tgz

3. Mettre à jour la base de données SQLite:
   DELETE FROM installed_packages WHERE packageName = 'n8n-nodes-photocertif';
   DELETE FROM installed_nodes WHERE package = 'n8n-nodes-photocertif';
   INSERT INTO installed_packages/nodes...

4. Redémarrer n8n

PROCÉDURE CORRECTE INSTALLATION
================================
cd /home/greg/n8n-nodes-photocertif
rm -rf dist/
yarn build
npm pack

cd ~/.n8n
npm uninstall n8n-nodes-photocertif
npm install /home/greg/n8n-nodes-photocertif/n8n-nodes-photocertif-1.1.0.tgz

cd ~/.n8n/nodes
npm uninstall n8n-nodes-photocertif
npm install /home/greg/n8n-nodes-photocertif/n8n-nodes-photocertif-1.1.0.tgz

# Mettre à jour la DB si nécessaire
python3 << 'PYEOF'
import sqlite3
from datetime import datetime
conn = sqlite3.connect('/home/greg/.n8n/database.sqlite')
cursor = conn.cursor()
cursor.execute("DELETE FROM installed_packages WHERE packageName = 'n8n-nodes-photocertif';")
cursor.execute("DELETE FROM installed_nodes WHERE package = 'n8n-nodes-photocertif';")
now = datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')[:-3]
cursor.execute("INSERT INTO installed_packages (packageName, installedVersion, authorName, authorEmail, createdAt, updatedAt) VALUES ('n8n-nodes-photocertif', '1.1.0', 'CHECKHC', 'contact@checkhc.net', ?, ?)", (now, now))
cursor.execute("INSERT INTO installed_nodes (name, type, latestVersion, package) VALUES ('PhotoCertif by CHECKHC', 'n8n-nodes-photocertif.photoCertif', 1, 'n8n-nodes-photocertif')")
conn.commit()
conn.close()
PYEOF

cd ~/n8n
./stop-n8n.sh
./start-n8n.sh

VÉRIFICATION
============
# Vérifier les deux emplacements
cat ~/.n8n/node_modules/n8n-nodes-photocertif/package.json | grep version
cat ~/.n8n/nodes/node_modules/n8n-nodes-photocertif/package.json | grep version

# Vérifier displayName
grep displayName ~/.n8n/nodes/node_modules/n8n-nodes-photocertif/dist/nodes/PhotoCertif/PhotoCertif.node.js | head -1

RÉSULTAT FINAL
==============
✅ Recherche "CHECKHC" dans n8n UI affiche:
   - Solana by CHECKHC
   - PhotoCertif by CHECKHC

LEÇON APPRISE
=============
Toujours installer les community nodes dans ~/.n8n/nodes/ ET vérifier que l'ancienne version n'existe pas dans les deux emplacements.
Le répertoire ~/.n8n/nodes/ a priorité pour l'affichage dans l'UI.
