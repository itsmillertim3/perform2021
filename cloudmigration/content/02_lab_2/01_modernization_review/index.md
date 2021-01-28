## Modernize the Sample App 

As we saw earlier that the sample application is a three-tiered application --> frontend, backend, database.

For our lab, another version of the application exists that breakouts each of these backend services into separate services. By putting these service into Docker images, we gain the ability to deploy the service into modern platforms like Kubernetes and Cloud managed services such as the ones from AWS shown below.

![image](../../../assets/images/lab2-eks-picture.png)

## Beyond the Lab

Over time, you can imagine that this sample application will be futher changed to add in other technologies like serverless [AWS Lambda](https://aws.amazon.com/lambda/) and other PaaS servies like [AWS RDS](https://aws.amazon.com/rds/) or [AWS DynamoDB](https://aws.amazon.com/dynamodb/) databases and virtual networking [AWS API gateway](https://aws.amazon.com/api-gateway) as shown in the picture below. 

![image](../../../assets/images/lab2-eks-picture-future.png)

💥 **TECHNICAL NOTE**: We will not cover this, but organziations are establishing DevOps approaches and estabishing Continuous Integration (CI) pipelines to build and test each service independantly. Then adding Continuous Deployment (CD) to the process too that vastly increase our ability to delivery features faster to our customers.  Dynatrace has a number of solutions to support DevOps that you can read about [here](https://www.dynatrace.com/solutions/devops/)