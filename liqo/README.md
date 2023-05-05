# Projet techique SupDeVinci DevOps MSI 4-23 DO A : Groupe 1 - Partie 2

## Installation de Liqo

### Pré Requis 

- Avoir deux clusters kubernetes
- Avoir go d'installé sur chacun des clusters

### Installation

- Installer liqoctl :

```sh
git clone https://github.com/liqotech/liqo.git
cd liqo
make ctl
```


- Mise en place des variables d'environement
```sh
# The resource group where the cluster is created
export AKS_RESOURCE_GROUP=your-resource-group
# The name of AKS cluster resource on Azure
export AKS_RESOURCE_NAME=your-cluster-name
# The name of the subscription associated with the AKS cluster
export AKS_SUBSCRIPTION_ID=your-subscription-name
```
- Installer liqo avec liqoctl
```sh
./liqoctl install aks --resource-group-name "${AKS_RESOURCE_GROUP}" \
        --resource-name "${AKS_RESOURCE_NAME}" \
        --subscription-name "${AKS_SUBSCRIPTION_ID}"
Generate peer command on both clusters and type the command you get:
./liqoctl --context=provider generate peer-command
```
La dernière commande devrait en générer une autre comme celle-là : 

```sh
./liqoctl peer out-of-band <cluster-name> --auth-url <auth-url> \
    --cluster-id <cluster-id> --auth-token <auth-token>
```

- Créer les namespaces et utiliser liqoctl pour les offload 

```sh
kubectl create namespace liqo-demo
./liqoctl offload namespace liqo-demo
```

Vous pouvez désormais créer les déploiements sur ces namespaces et la charge sera répartie entre les deux clusters.
