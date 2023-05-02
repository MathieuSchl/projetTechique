# projetTechique
on lance d'abord   galera via la commande suivante :

```helm install my-galera  oci://registry-1.docker.io/bitnamicharts/wordpress -f ./Galera/values.yaml```
puis on install  wordpress 
```helm install my-release oci://registry-1.docker.io/bitnamicharts/wordpress -f ./Wordpress/values.yaml```
