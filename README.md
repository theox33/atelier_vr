# 🎓 Atelier VR — Découverte de sites 3D (activité pour lycéens)

![notebook](https://img.shields.io/badge/atelier-VR-blue.svg) ![latex](https://img.shields.io/badge/format-LaTeX-orange.svg) ![minted](https://img.shields.io/badge/highlight-minted-green.svg) ![license](https://img.shields.io/badge/license-CC_BY--SA_4.0-lightgrey.svg)

Bienvenue ! Ce dépôt contient un tutoriel LaTeX (`atelier_vr.tex`) conçu pour une activité de découverte destinée aux lycéens. Le document montre comment créer une scène 3D simple avec A-Frame (HTML + JavaScript) et génère un PDF avec une belle coloration syntaxique grâce au paquet `minted`.

## 🎯 But
En une séance courte, les élèves pourront :

- Découvrir la structure d'une page HTML
- Manipuler des formes 3D simples avec A-Frame
- Ajouter une interactivité basique (ex. : changer la couleur d'un objet au clic)

## 📂 Contenu important
- `atelier_vr.tex` — source LaTeX (contient les exemples HTML/JS)
- `requirements.txt` — dépendances Python (actuellement : `Pygments`)
- `Makefile` — automatise la création de l'environnement et la génération du PDF

## 🚀 Générer le PDF
Suivez ces étapes simples. Copiez-collez les commandes dans un terminal (Linux / macOS). Si vous êtes sous Windows, voir la section "Windows" ci‑dessous.

1) Se placer dans le dossier du projet :

```bash
cd /chemin/vers/atelier_vr
```

2) Créer l'environnement Python local et installer Pygments (recommandé) :

```bash
make install
```

3) Construire le PDF :

```bash
make
# ou
make release
```

Le PDF final sera produit dans `build/atelier_vr.pdf` puis copié à la racine sous le nom `atelier_vr.pdf`.

4) Nettoyer les fichiers temporaires :

```bash
make clean
```

Pour tout supprimer (y compris le PDF généré) :

```bash
make distclean
```

### 🪟 Windows (PowerShell)
Si vous travaillez sous Windows sans WSL, vous pouvez créer l'environnement et installer les dépendances ainsi :

```powershell
# créer venv
python -m venv .venv
# activer (PowerShell)
.\.venv\Scripts\Activate.ps1
# installer
.venv\Scripts\pip install --upgrade pip
.venv\Scripts\pip install -r requirements.txt
# puis lancer pdflatex via Makefile (si make est disponible) ou lancer manuellement pdflatex
```

> Remarque : l'option `-shell-escape` est nécessaire pour que LaTeX puisse appeler `pygmentize` (utilisé par `minted`). Le `Makefile` préfixe le PATH avec `.venv/bin` pour que la version locale de `pygmentize` soit trouvée.

## 💡 Astuces et dépannage
- Erreur "You must have `pygmentize' installed" → vérifiez que `.venv` est activé ou que `pygmentize` est sur le PATH.
- Si vous avez des problèmes avec `latexmk`/`pdflatex`, essayez d'exécuter manuellement :

```bash
. .venv/bin/activate
PATH=.venv/bin:$PATH pdflatex -shell-escape -interaction=nonstopmode -halt-on-error atelier_vr.tex
```

- Pour réduire la taille des blocs de code dans le PDF : modifier `fontsize` dans `\\setminted{...}` dans `atelier_vr.tex`.

## 🎨 Personnalisation
- Changer le style de couleur : `\\usemintedstyle{...}` (ex : `friendly`, `monokai`, `colorful`)
- Changer l'apparence des blocs (bordure / fond) via `\\setminted{...}`

## 📚 Ressources utiles
- A-Frame: https://aframe.io/docs/
- Pygments: https://pygments.org/

---
 
## ✍️ Auteur

Ce dépôt et la conception pédagogique (contenu, exercices, exemples et mise en forme) ont été créés et rédigés par Théo AVRIL.

Informations & contact :

- Nom : Théo AVRIL
- Portfolio / site : https://theo-avril.fr/portfolio
- GitHub : https://github.com/theox33

Mainteneur : Théo AVRIL — contact via GitHub or via the portfolio site.

Détails complémentaires :

- Public visé : lycéens (niveau débutant en HTML/JS)
- Durée recommandée : 45min à 1h30min (atelier court) — à adapter selon le groupe
- Objectifs pédagogiques : compréhension de la structure HTML, usage d'A-Frame pour des scènes 3D simples, introduction à la programmation d'interactions

Licence (suggestion) : indiquez la licence que vous souhaitez appliquer (par exemple CC BY‑SA pour le contenu pédagogique). Si vous voulez, je peux ajouter un fichier `LICENSE` correspondant.

## 📝 Licence
Le contenu de ce dépôt est distribué sous la licence Creative Commons
Attribution-ShareAlike 4.0 International (CC BY‑SA 4.0). Voir le fichier
`LICENSE` à la racine pour le texte légal complet, ou la page
officielle : https://creativecommons.org/licenses/by-sa/4.0/
