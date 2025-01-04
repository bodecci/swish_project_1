## How to run and deploy this application.

clone the repo
cd into the `kubernetes/terraform` directory. 
run `terraform init`
run `terraform plan`
run `terraform apply` and enter yes

this will create the namespace: swish-proj 
and create the deployment `python-r-app` with 2 replicas and create a service that exposes the deployment.

One can also expose a deployment by running. This creates a service.
`kubectl expose deployment <deployment-name> --type=NodePort --port=8080 --target-port=8080`
But it is better to use the Kubernetes declarative method used in the terraform cmds above.


### Current Build Time
The build time for the current Dockerfile is **674.4 seconds**.

---

### Monitor the Kubernetes Deployment:


**K9s for local monitoring**:
    - K9s is a terminal based dashboard that allows engineers to view pod health, pod status, inspect logs in real-time. I use K9s for realtime monitoring
    - To install, just run brew install k9s. after installtion, run k9s. This starts k9s and you can select the namespace and deployment/pod you want to view metrics, pod health.

**EFK Stack**:
    - Elasticsearch, Fluentd and Kibana (EFK) is an open-source choice for the Kubernetes log aggregation and analysis: Fluentd streams logs to Elasticsearch and you can visualize the logs in Kibana. Create dashboards in Kibana to troubleshoot pod failures, application error and/or anomalies.
    - There are several ways to deploy EFK, but a quick and easy way to install the charts for elasticsearch and kibana.

    `helm repo add elastic https://helm.elastic.co
     helm repo update
     helm install elasticsearch elastic/elasticsearch`
     once elasticsearch is running, you can port forward the service.
     `kubectl port-forward service/elasticsearch-master 9200:9200`
    
    you can verify logs are being received in elasticsearch by checking the indices: `curl -X GET "localhost:9200/_cat/indices?v"`

    deploy fluentd:
    create a configmap for fluentd.
    install fluentd chart:
    `helm install fluentd bitnami/fluentd \
    --set elasticsearch.host=elasticsearch-master \
    --set resources.requests.memory="200Mi" \
    --set resources.requests.cpu="100m" \
    --set replicas=1 \
    --set configMap=custom-fluentd-config`
    this installs fluentd daemonset to collect logs from the pods

    install the chart for kibana
    `helm install kibana elastic/kibana`
    you will need to forward Kibana to your machine
    `kubectl port-forward svc/kibana 5601:80`


    - You'd wanna create a namespace: logging/monitoring/kube-logging
    `kind: Namespace
     apiVersion: v1
     metadata:
       name: kube-logging`
    - You'd wanna create a headless service and a statefulset for Elasticsearch. A Headless service doesn't allocate a cluster IP to represent a set of pods. You create a service but set the clusterIP to none
   
    - and a Statefulset are given persistent identifiers that they retain even when they're rescheduled. This is very much needed and required for monitoring solutions.

**Prometheus and Grafana**: 
    Prometheus is a popular open-source monitoring and  alerting toolkit for Kubernetes. Prometheus scrapes metrics from Kubernetes components and displays them, including pod CPU/memory usage, pod restarts, and network traffic. And Grafana, just like the EFK stack ( where Fluentd streams logs to Elasticsearch and you can visualize the logs in Kibana), is used to visualize the metrics collected by Prometheus.

    - Install prometheus using helm. Install the helm charts for promethheus:
    `
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    helm install prometheus prometheus-community/prometheus
    `
    access prometheus: `kubectl port-forward svc/prometheus-server 9090:80`
    you can view the metrics on `http://localhost:9090`. 

    - Install Grafana : Grafana is used to visualize the metrics collected by Prometheus.
    `helm repo add grafana https://grafana.github.io/helm-charts
     helm repo update
     helm install grafana grafana/grafana
    `

    access grafana: `kubectl port-forward svc/grafana 3000:80`.
    you can view grafana on `http://localhost:3000` and log in 
    (default credentials: admin / prom-operator).

    setup prometheus as a data source: add prometheus  (http://prometheus-server:9090) as a data source.




