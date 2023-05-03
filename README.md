# Projet techique SupDeVinci DevOps MSI 4-23 DO A : Groupe 1

## Pré Requis 

Pour faire les installations, il est nécessaire d'avoir les prérequis suivants :

- Faire un clone du repository :
```
git clone https://github.com/MathieuSchl/projetTechique.git && cd projetTechique/
```
- Avoir un cluster Kubernetes 
- Avoir debian à jour (uniquement en On-Prem)

```sh
sudo apt-get update
```

## Installation de HELM (PAS NECESSAIRE SUR AZURE)

- Installer le paquet `snapd` en exécutant la commande suivante : 

```sh
sudo apt-get install snapd
```

- Installer Helm en utilisant la commande suivante : 

```sh
sudo snap install helm --classic
```

- Pour vérifier que Helm a été correctement installé, exécutez la commande suivante pour afficher la version de Helm : 

```sh
helm version
```
## Installation GALERA
### Edition du fichier values (Gallera)
Le fichier `values` est dans le dossier `gallera/values.yaml`
A la ligne 2, renseigner le mot de passe voulue pour l'utilisateur root de la DB :
```yaml
    rootUser:
      password: "ChangeME"
```

- Lancer l'installation de GALERA via la commande suivante : 

```shell
helm install galera oci://registry-1.docker.io/bitnamicharts/mariadb-galera -f ./Galera/values.yaml
```

Vous devriez voir un pod en running au bout de quelques minutes 
```shell
kubectl get pods 
```
![](img/Galera/pod.jpg)

## Installation WORDPRESS

### Edition du fichier values (Wordpress)

Le fichier `values` est dans le dossier `Wordpress/values.yaml`
A la ligne 11 , renseigner le mot de passe que nous avons spécifié plus haut pour [gallera](#Edition-du-fichier-values-gallera)
```yaml
  password: "ChangeMe"
```
Puis a la ligne 4, renseigner le mot de passe qui sera utilisé pour se connecter à l'interface admin de wordpress 
```yaml
wordpressPassword: "ChangeME"
```

- Lancer la commande suivante pour lancer l'installation de WordPress :

```shell
helm install wordpress oci://registry-1.docker.io/bitnamicharts/wordpress -f ./Wordpress/values.yaml
```

## Accéder à  wordpress 
On récupère l'ip externe via la commande 
```shell
kubectl get services wordpress 
```
![](img/Azure/get-services.jpg)

#### En vous connectant à l'adresse, vous devriez avoir accès à la page suivante :
![](img/Wordpress/homePage.jpg)

#### Vous pouvez aussi vous connecter à l'interface  d'admin en  utilisant `http://$ip-externe/admin`, ensuite utiliser les credentials que l'on a renseigné plutôt
![](img/Wordpress/Admin.jpg)

#### Une fois connecté, votre installation Wordpress est fonctionnelle

![](img/Wordpress/dahsboard.jpg)


## Création du blob storage
#### Une fois connecter à azure, cherchez storage ou  stockage dans la barre de recherche  puis cliquez sur "comptes de stockage" ou "Storage Account"
![](img/Azure/blob%20sotrage%201.png)

#### Ensuite, renseigner le nom du blob, puis cliquer sur review
![](img/Azure/blob%20sotrage%202.png)

#### Enfin cliquer sur créer 
![](img/Azure/blob%20sotrage%203.png)

#### Pour créer un conteneur dans ce storage account, cliquez sur "containers" puis sur `create` 
![](img/Azure/create%20container.png)

#### A droite entrer un nom et sélectionner "blob" dans public accesss level  enfin cliquez sur create 
![](img/Azure/container%20creation%202.png) 

#### Ensuite cliquer sur le storage account et aller dans la section "access key" ou "clé d'accès" puis afficher et copier la clé d'accès 
![](img/Azure/access%20keys.png)

## Jointure du blob à wordpress 
### Installation du plugin
Connecter vous à l'interface d'admin [cf](#accéder-à-wordpress)

Cliquer sur `plugins` puis `add new` 

![ajouter un nouveau plugin](img/Wordpress/add-new-plugin.jpg)

Ensuite dans la barre de recherche saisissez `Microsoft Azure Storage for WordPress` puis cliquer sur `Install Now`
![](img/Wordpress/install-plugin.jpg)

Cliquer ensuite sur "Activate"
![](img/Wordpress/activate.jpg)

### Configuration du plugin 
On accède à la page de configuration d'azure en cliquant sur `Settings` pour sur `Microsoft Azure`
![](img/Wordpress/Azure-Setting.jpg)

Dans la partie `Store Account Name` renseigner le nom du blob storage créé plus haut 
![](img/Wordpress/storeaccountName.jpg)

Dans la partie "Store Account Key" renseigner le secret généré par azure   
![](img/Wordpress/Store%20Account%20Key.jpg)

Appuyer sur `entrer`, puis cliquez sur le conteneur créé précédemment
![](img/Azure/default_container.png)

Appuyez sur en `Entrer` ou cliquez sur `save change` en bas de page 

![](img/Azure/Save.png)
