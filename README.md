# Projet techique SupDeVinci DevOps MSI 4-23 DO A : Groupe 1  , Partie 2 

## Pré Requis 

Pour faire les installations, il est nécessaire d'avoir les prérequis suivants :

- Faire un clone du repository :
```
git clone https://github.com/MathieuSchl/projetTechique.git && cd projetTechique/
```
- Avoir au moins deux  cluster Kubernetes Azure , dans des régions différente   
- Avoir helm et jq d'installés, 

/!\ pour la simplicité de ce guide , les deux cluster azure seront nommés cluster1 et cluster2


## instalation de cert manager  ( cluster1 et cluster2)
admiralty a besoin de cert-amanger ( sur les deux clusters ) pour pouvoir fonctionner , procéder comme suit pour installer 

on ajoute le repo helm de jetstack 
```
helm repo add jetstack https://charts.jetstack.io
```
vous devriez voir cette sortie 

![](img/Admiralty/Cert-manager/helm_add_repo.jpg)

ou celle ci 

![](img/Admiralty/Cert-manager/repo_exisiting.png)

on va ensuite mettre à jour les repo helm 
```
helm repo update
```

a la fin de l'update ce message apparait 

![](img/Admiralty/update_helm_repo.jpg)

nous allons maintenant procéder à l'installation  de cert-manager 

attention : 
- il ne faut pas avoir de namespace "cert-manager" sur vôtre cluster  ( vérifier avec ``` kubectl get namespaces```)
- il ne faut pas qu'un release helm nommée "cert-mamanger" existe  ( vérifier avec ``` helm list -A```)

on install cert-manager avec la commande suivante  (cela peut prendre plus ou moins de temps en fonction de la puissance du cluster )
```
helm install cert-manager jetstack/cert-manager      --namespace cert-manager --create-namespace     --version v1.11.0 --set installCRDs=true     --wait 
``` 
si tout vas bien ce message appairait

![](img/Admiralty/Cert-manager/notes.png)
à ce stade, cert-manager est oppérationel.


## instalation d'admirality ( cluster1 et cluster2)

ici encore il faut ajouter le repo helm 
```
helm repo add admiralty https://charts.admiralty.io
```
puis on mets à jour les repos

```
helm repo update
```


nous allons maintenant procéder à l'installation  de Admiralty 

attention : 
- cert-manager doit être installé (  vérifier avec ``` helm list -n cert-manager ```)) si ce n'est pas le cas, suivre cette [procédure](#instalation-de-cert-manager--cluster1-et-cluster2)  
- il ne faut pas avoir de namespace "admiralty" sur vôtre cluster  ( vérifier avec ``` kubectl get namespaces```)
- il ne faut pas qu'un release helm nommée "cert-mamanger" existe  ( vérifier avec ``` helm list -A```)

on lance  l'install d'amdiralty avec la commande suivante :
```
helm install admiralty admiralty/multicluster-scheduler --namespace admiralty --create-namespace  --version 0.15.1 --wait 
```
si tout vas bien , le message suivant apprait 

![](img/Admiralty/notes.png)

à ce stade Admiralty est installé  nous pouvons maintenant passé à sa configuration 


## configuration d'admiralty 
### préambule 
À ce stade , nous  allons installer une achitecture type master/slave , le cluster1 sera le master  et le cluster2 le slave
cela veut dire que cluster1 pourra répartir des pods sur les deux cluster , le custer 2 lui ne pourra pas gérer la répartition

### génération d'un compte  de service  ( Cluster2 uniquement)

nous allons créer un compte de service sur le cluster2 qui permettra à notre master (CLuster1) d'envoyer les pods 

pour cela on créer un compte de service  
```
kubectl create serviceaccount cluster2
```
si tout vas bien ce message apparait , 

![](img/Admiralty/SA_Cluster2.png)

puis on genère un TOKEN pour ce SA  (/!\\pas d'output pour cette commande)
```
  TOKEN=$(kubectl create token cluster2)
```
nous de vons maintenant récupérer l'ip de l'api de KUB , sur Azure , il faut regarder dans la section networking 
![](img/Admiralty/ip.png)

on export cette IP dans une variable IP 
```
IP=cluster.[...].io
```
enfin on génère une config qu'on enverra à CLuster1  (/!\\ le port 443 peut différer en fonction des providers )
```
"  CONFIG=$(kubectl config view \
    --minify --raw --output json | \
    jq '.users[0].user={token:"'$TOKEN'"} | .clusters[0].cluster.server="https://'$IP':443"')
"
```