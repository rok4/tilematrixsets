## 4.6

### [Changed]

* Passage sur ubuntu 24.04 pour la compilation du paquet debian

## 4.5

### [Changed]

* Changement du TMS '2154_1M_MNT' : l'origine est décalée pour que les valeurs des données RGEAlti, valeurs sur le maillage, soit bien la valeur au centre du pixel dans les données de la pyramide (au niveau du bas)

## 4.4

* Ajout du TMS `2154_50cm_MNT` : l'origine est décalée pour que les valeurs des données LidarHD, valeurs sur le maillage, soit bien la valeur au centre du pixel dans les données de la pyramide (au niveau du bas).

## 4.3

### [Added]

* Duplication de TMS IGNF en leur équivalent EPSG :
    * IGNF:LAMB93 -> EPSG:2154
    * IGNF:UTM22RGFG95 -> EPSG:2972
    * IGNF:RGR92UTM40S -> EPSG:2975
    * IGNF:RGM04UTM38S -> EPSG:4471

## 4.2

### [Fixed]

* Correction du niveau du bas du TMS RGR92UTM40S_50cm

## 4.1

### [Changed]

* Les TMS installés via le paquet debian vont dans le dossier `/usr/share/rok4/tilematrixsets`

<!-- 
### [Added]

### [Changed]

### [Deprecated]

### [Removed]

### [Fixed]

### [Security] 
-->
