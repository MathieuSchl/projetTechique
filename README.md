                                                                                                                                            
```
  _                                    _       __ 
 | |                                  | |     /_/ 
 | |__    _ __    ___  __   __   ___  | |_    ___ 
 | '_ \  | '__|  / _ \ \ \ / /  / _ \ | __|  / _ \
 | |_) | | |    |  __/  \ V /  |  __/ | |_  |  __/
 |_.__/  |_|     \___|   \_/    \___|  \__|  \___|
 ```                                                                                                                     
# Projet techique SupDeVinci DevOps MSI 4-23 DO A : Groupe 1


## Pré Requis 

Pour faire les installations, il est nécessaire d'avoir les prérequis suivants :

- Faire un clone du repository :
```
https://github.com/MathieuSchl/projetTechique.git
```
- On oublie pas de folow et cliquer sur la cloche pour avoir les dernières nouveautés de mathieu ! ;)
- Avoir un cluster Kubernetes
- Avoir debian à jour

```
sudo apt-get update
```

## Installation de HELM (PAS NECESSAIRE SUR AZURE)

- Installez le paquet `snapd` en exécutant la commande suivante : 

```
sudo apt-get install snapd
```

- Installez Helm en utilisant la commande suivante : 

```
sudo snap install helm --classic
```

- Pour vérifier que Helm a été correctement installé, exécutez la commande suivante pour afficher la version de Helm : 

```
helm version
```
## Installation GALERA

- Lancez l'installation de GALERA via la commande suivante : 

```
helm install galera oci://registry-1.docker.io/bitnamicharts/wordpress -f ./Galera/values.yaml
```

## Installation WORDPRESS

- Lancez la commande suivante pour lancer l'installation de WordPress :

```
helm install wordpress oci://registry-1.docker.io/bitnamicharts/wordpress -f ./Wordpress/values.yaml
```

## Installation Minio 
```
helm install minio oci://registry-1.docker.io/bitnamicharts/minio -f ./Minio/values.yaml
```

## Paramétrage du port-forward

- Pour utiliser wordpress sur le port 80, lancer la commande :

```
kubectl port-forward --namespace default svc/wordpress 80:80
```
