1/ Installation de HELM 

- Installez le paquet snapd en exécutant la commande suivante : 

  sudo apt-get install snapd
  
- Installez Helm en utilisant la commande suivante : 

  sudo snap install helm --classic

- Pour vérifier que Helm a été correctement installé, exécutez la commande suivante pour afficher la version de Helm : 

  helm version

2/ Installation GALERA :

- Lancez l'installation de GALERA via la commande suivante : 

helm install my-galera oci://registry-1.docker.io/bitnamicharts/wordpress -f ./Galera/values.yaml

3/ Installation WORDPRESS :

- lancez la commande suivante pour lancer l'installation de WordPress :

helm install my-release oci://registry-1.docker.io/bitnamicharts/wordpress -f ./Wordpress/values.yaml
