## Insights into Version Awareness

Dynatrace's Real time inventory view is fueled by its new *Version detection* capability.
If you are interested in all the details please have a look at [Version detection strategies](https://www.dynatrace.com/support/help/how-to-use-dynatrace/release-monitoring/version-detection-strategies/)

Essentially there are three sources of version meta data

### For Kubernetes: Labels & Annotations

Dynatrace follows the [k8s Recommended Labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/) using
* **Version** from `app.kubernetes.io/version` 
* **Application** from `app.kubernetes.io/part-of` 

Additionally it takes
* **Environment** from the k8s namespace
* **Component** from the name of the Process Group Instance

In order for Dynatrace to import k8s labels and annotations please follow the instructions on [Organize Kubernetes deployments by tags](https://www.dynatrace.com/support/help/technology-support/cloud-platforms/kubernetes/other-deployments-and-configurations/leverage-tags-defined-in-kubernetes-deployments/) 

The k8s environment we are using in the HOT class has enabled OneAgent to pull this data from our staging, production and keptn namespaces.

### For any process: Environment Variables

Version awareness also works for any type of process that doesn't live in k8s. Here Dynatrace looks for 3 specific environment variables on that process:
* **Version** from DT_APPLICATION_RELEASE_VERSION 
* **Application** from DT_APPLICATION_NAME
* **Environment** DT_APPLICATION_ENVIRONMENT

Additionally it takes
* **Component** from the name of the Process Group Instance

### For any process: Version from Deployment Events

A third option exists which is related to [Dynatrace Deployment Events](https://www.dynatrace.com/support/help/how-to-use-dynatrace/problem-detection-and-analysis/basic-concepts/event-types/info-events/#deployment)

If your deployment automation, e.g: Jenkins, GitLab, Azure DevOps, Keptn, Harness ... can send a custom deployment event to the Dynatrace Process Group Instance, Dynatrace will use the Version field of that event for the actual version!
