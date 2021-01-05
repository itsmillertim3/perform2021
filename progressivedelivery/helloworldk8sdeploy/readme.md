# Hello World Deployment

This is a simple Hello World deployment using the official [Docker Hello World Container](https://hub.docker.com/_/hello-world)
The deployment.yaml can be customized to test out how Dynatrace detects version, application and environment meta data!

To deploy it - simple do this:
1. Edit deployment.yaml and put in your custom metadata
2. Create a namespace in k8s, e.g: kubectl create ns studentxxx-helloworld
3. Apply deployment.yaml, e.g: kubectl apply -f deployment.yaml -n studentxxx-helloworld