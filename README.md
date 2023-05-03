# Projet techique SupDeVinci DevOps MSI 4-23 DO A : Groupe 1

## Pré Requis 

Pour faire les installations, il est nécessaire d'avoir les prérequis suivants :

- Faire un clone du repository :
```
https://github.com/MathieuSchl/projetTechique.git
```
- Avoir un cluster Kubernetes 
- Avoir debian à jour (uniquement en On-Prem)

```sh
sudo apt-get update
```

## Installation de HELM (PAS NECESSAIRE SUR AZURE)

- Installez le paquet `snapd` en exécutant la commande suivante : 

```sh
sudo apt-get install snapd
```

- Installez Helm en utilisant la commande suivante : 

```sh
sudo snap install helm --classic
```

- Pour vérifier que Helm a été correctement installé, exécutez la commande suivante pour afficher la version de Helm : 

```sh
helm version
```
## Installation GALERA
### édition du fichier values (Gallera)
à la ligne 2, renseigner le mot de passe voulue pour l'utilisateur root de la DB :
```yaml
    rootUser:
      password: "ChangeME"
```

- Lancez l'installation de GALERA via la commande suivante : 

```shell
helm install galera oci://registry-1.docker.io/bitnamicharts/mariadb-galera -f ./Galera/values.yaml
```

vous devriez voir un pod en running au bout de quelques minutes 
```shell
kubectl get pods 
```
![](img/Galera/pod.jpg)

## Installation WORDPRESS

### édition du fichier values (Wordpress)

à la ligne 11 , renseignez le mot de passe que nous avons spcéifié plus haut pour [galllera](#édition-du-fichier-values-gallera)
```yaml
  password: "ChangeMe"
```
puis a la ligne 4 renseifnez le mot de passe qui sera utilisé pour se connecter à l'interface admin de wordpress 
```yaml
wordpressPassword: "ChangeME"
```

- Lancez la commande suivante pour lancer l'installation de WordPress :

```shell
helm install wordpress oci://registry-1.docker.io/bitnamicharts/wordpress -f ./Wordpress/values.yaml
```

## Installation Minio 
```shell
helm install minio oci://registry-1.docker.io/bitnamicharts/minio -f ./Minio/values.yaml
```

## Paramétrage du port-forward

- Pour utiliser wordpress sur le port 80, lancer la commande :

```shell
kubectl port-forward --namespace default svc/wordpress 80:80
```

## accéder à  wordpress 
on récupère l'ip externe via la commande 
```shell
kubecetl get services wordpress 
```
![](img/Azure/get-services.jpg)

en vous connectant à l'adresse ,vous dezvriez avoir accès à la page suivante :
![](img/Wordpress/homePage.jpg)

vous pouvez aussi vous connecter à l'interface  d'admin en  utilisant http://$ip-exxterne/admin
ensuite utiliser les crédentials que l'on a renseigné plutôt  
![](img/Wordpress/Admin.jpg)

une fois connecté votre installation wordpress est fonctionelle 


## création du blob storage 
une fois connecter à azure ,  
##  installation du plugin 
clliquer sur plugins puis add new 
![ajouter un nouveau plugin](img/Wordpress/add-new-plugin.jpg)


