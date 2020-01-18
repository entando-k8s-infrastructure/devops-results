oc login -u  admin-entando -p $OPENSHIFT_SERV_RUN_PWD openshift.serv.run:8443
docker login -u admin-entando -p $(oc whoami -t) docker-registry-default.apps.serv.run
for i in $(kubectl get configmap image-versions -n entando -o 'go-template={{ range $key, $value := .data }}{{$key}}{{":"}}{{$value}}{{"\n"}}{{end}}'); do
  docker pull docker-registry-default.apps.serv.run/entando/$i
  docker tag docker-registry-default.apps.serv.run/entando/$i entando/$i
  docker push  entando/$i
done
