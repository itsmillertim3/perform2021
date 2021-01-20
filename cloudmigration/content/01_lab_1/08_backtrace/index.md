## Service backtrace

Dynatrace understands your applications transactions from end to end. This transactional insight is visualized several ways like the backtrace. 

The backtrace tree view represents the sequence of services that led to this service call, beginning with the page load or user action in the browser.

## 👍 How this helps

Using the service flow and service backtrace, these two tools give you a complete picture of interdependency to the rest of the environment architecture at host, processes, services, application perspectives. 

## Review Service backtrace

Let’s now take a look at the transactions and Services by clicking on the `Transactions and services` left side Dynatrace menu.

Pick the `scripts_backend-scripts_1` service.

![image](../../../assets/images/lab1-trans-services-db.png)

On the **scripts_backend-service_1** service, click on the **Analyze Backtrace** button.

![image](../../../assets/images/lab1-service-backtrace-arrow.png)

You should be on the service backtrace page where you will see information for this specific service.

This will get more interesting in the next lab, but for the monolith backend, we can see that the backtrace is as follows:

1 . The starting point is the **scripts_backend-service_1**

2 . **scripts_backend-service_1** is called by the **scripts_front-end_1**

3 . **scripts_front-end_1** is a where end user requests start and the user sessions get captured within the **My web application** by default

![image](../../../assets/images/lab1-service-backtrace-arrows.png)
