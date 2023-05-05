Install liqoctl :
git clone https://github.com/liqotech/liqo.git
cd liqo
make ctl

Use liqoctl to install liqo:
liqoctl install aks --resource-group-name "${AKS_RESOURCE_GROUP}" \
        --resource-name "${AKS_RESOURCE_NAME}" \
        --subscription-name "${AKS_SUBSCRIPTION_ID}"

Generate peer command on both clusters and type the command you get:

liqoctl --context=provider generate peer-command

example of the command you will have to type on the other cluster: liqoctl peer out-of-band <cluster-name> --auth-url <auth-url> \
    --cluster-id <cluster-id> --auth-token <auth-token>

Create the namespace you want to offload and use liqoctl to offload it:

kubectl create namespace liqo-demo
liqoctl offload namespace liqo-demo

Once this is done, you create deployements on this namespace and the load will be balanced between the clusters.
