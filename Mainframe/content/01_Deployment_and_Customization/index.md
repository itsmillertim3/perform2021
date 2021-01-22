## Deployment and Customization

In this module you will learn how to deploy a Mainframe ActiveGate and zRemote and make the definitions on the Mainframe to connect an LPAR to this zRemote.

### Step 1: Open your Dynatrace Tenant 

1. Open a browser and provide your tenant URL

   ![Lab guide example](assets/images/Deploy/001 Tenant.png)

1. Create a new file named `Dockerfile` and add the following content:

   ```docker
   FROM alpine:latest
   COPY . /app
   WORKDIR /app
   RUN apk add --no-cache wget
   ENTRYPOINT [ "sh" ]
   CMD ["hello_world.sh"]
   ```

1. Create a new file named `hello_world.sh` and add the following content:

   ```bash
   echo "Hello World from a Docker Container."
   ```

1. Ensure that the script is an executable:

   ```bash
   (bastion)$ chmod +x hello_world.sh
   ```

### Step 2. Install the Mainframe ActiveGate

1. Build the container image (`-t` specifies the repository and a tag). The `$USER` variable will tag the image with your username.

   ```bash
   (bastion)$ docker build -t acl/hello-world:$USER .
   ```

1. List all container images on your local machine.

   ```bash
   (bastion)$ docker images
   ```

1. Set another tag.

   ```bash
   (bastion)$ docker tag acl/hello-world:$USER acl/hello-world:$USER-stable
   ```

1. List all container images on your local machine.

   ```bash
   (bastion)$ docker images
   ```

### Step 3. Change the connection information on the Mainframe

1. Run the container based on a container image.

   ```bash
   (bastion)$ docker run acl/hello-world:$USER-stable
   ```
