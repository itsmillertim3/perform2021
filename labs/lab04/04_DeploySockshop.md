## Deploy Sock Shop Sample Application

This lab will require accessing the EKS Bastion Host you were assigned for this session.

### Deploy SockShop
1.  Clone the application deployment files from the 20201 HoT Github repo
  ```
  git clone https://github.com/itsmillertim3/perform2021.git
  ```
 ![GitSockShop](../assets/lab4-downloadsockshop.png)
 
2.  On the EKS Bastion Host navigate to the "k8s-apps" directory and deploy sockshop
  ```
  ./deploy-sockshop.sh
  ```

### Validate SockShop Dev instance
1. List all objects
  ```
   kubectl get all -n dev
  ```

  ![SockShopDevRunning](../assets/lab4-devrunning1.png)

2. Wait a couple of minutes until all the pods are Ready and Running and the LoadBalancer objects have EXTERNAL-IPs
  ![SockShopDevRunning](../assets/lab4-devrunning2.png)  
  
3. Copy the external IP for the load balancer into notepad (Dev) and add ":8080". 8080 is the port number for the application.

4. Validate the Dev instance
   - Use the External IP of service/front-end and port 8080  
   ![SockShopDevWeb](../assets/lab4-sockshopui.png)  
   - Register an account
   - Purchase an item

### Validate SockShop Production instance
1. List all objects
  ```
  kubectl get all -n production
  ```
  
 ![SockShopDevRunning](../assets/lab4-prodrunning1.png)

2. Wait a couple of minutes until all the pods are Ready and Running and the LoadBalancer objects have EXTERNAL-IPs
 ![SockShopDevRunning](../assets/lab4-prodrunning2.png)  

3. Copy the external IP for the load balancer into notepad (Prod) and add ":8080". 8080 is the port number for the application.

4. Validate the Prod instance
  - Use the External IP of service/front-end and port 8080  
  ![SockShopDevWeb](../assets/lab4-sockshopuiprod.png)  
  - Register an account
  - Purchase an item
