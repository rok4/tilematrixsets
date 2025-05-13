# Tile Matrix Sets

Ces grilles sont utilisées dans le projet ROK4 au niveau de la génération des pyramides de données, puis au niveau du serveur pour la diffusion

## Comment définit-on une matrice de tuiles à partir des niveaux de jeux de matrice de tuile ?

On utilise la classe ```TileMatrixSet()``` avec laquelle on instancie un objet lié à cette classe,

à partir du bucket de stockage ```s3://tilematrixsets/PM.json``` par exemple

![ROK4 TMS](https://github.com/rok4/core-python/blob/feature/doc-new-users/HOWTO.md#cas-dusage-simple-avec-le-tilematrixset-pm)

On peut ainsi aisément accéder :
*   à son identifiant,
*   à son chemin,
*   aux coordonnées de l'origine X et Y du point,
*   à la résolution (taille de la cellule),
*   à la taille de la tuile en largeur et et en hauteur,
*   à la taille de la matrice en largeur et en hauteur.

On peut récupérer aussi l'emprise d'une boundary box avec les extrémités des coordonnées de rangées et de colonnes des tuiles à l'aide la fonction
```bbox_to_tiles(bounding box (xmin, ymin, xmax, ymax)``` dans le système de coordonnées du TMS c'est-à-dire longitude min, max et latitude min et
max)

On peut aussi récupérer dans un tuple les indices de la tuile et des pixels de la pyramide à partir des coordonnées des points avec la fonction  ```point_to_indices(x, y)```

![ROK4 EXPLOITATION JSON TMS](https://github.com/rok4/core-python/blob/feature/doc-new-users/HOWTO.md#exploitation-des-donn%C3%A9es-dun-fichier-json-dun-tilematrixset-exemple--pmjson)



## Installation via le paquet debian

Télécharger le paquet [sur GitHub](https://github.com/rok4/tilematrixsets/releases/).

```
apt install ./rok4-tilematrixsets-<version>-linux-all.deb
```

Les fichiers seront installés dans le dossier `/usr/share/rok4/tilematrixsets`.
