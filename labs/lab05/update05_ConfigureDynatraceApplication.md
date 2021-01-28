## Configure Dynatrace Application

This lab exercise will create a Dynatrace application for the Sock Shop application that was deployed. 

### Create Application
1.  Navigate to Applications and then select "My Web Application".
 
 ![Applications](../assets/lab5-applications.png)
 
2.  This is the default application bucket that catches all URLs for servers and services that are instrumented with Dynatrace. Scroll towards the bottom to "Top x Include Domains".
 
  ![Applications1](../assets/lab5-applications1.png)
  
3. Click on View Details
   - Both dev and prod Sock Shop domains are listed. They should match what you copied to notepad.
  
   ![Applications2](../assets/lab5-applications1b.png)
   
4. Expand the domain and click on "Create New Application".

   ![TransferDomain](../assets/lab5-transferdomain.png)
   
5. Click "Create"
   
   ![CreateApplication](../assets/lab5-createapplication.png)
   
6. Navigate back to Application in the Dynatrace menu and select Applications. Select the application you just created. You will see the application is named by the domain selected. Once you have selected the application, use the elypsis and select edit.

   ![EditApplication](../assets/lab5-editapplication.png)


