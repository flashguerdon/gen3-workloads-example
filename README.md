Gen3 ArgoCD Workloads Repository
================================

This repository provides configuration for the Gen3 EKS Blueprints pipelines, enabling the deployment and management of applications in a Gen3 environment using ArgoCD. It follows the **app of apps** pattern, where multiple applications can be managed and deployed efficiently through a single ArgoCD instance.

Overview
--------

The `dev` environment is pre-configured with basic settings for ArgoCD and Gen3. However, you will need to provide the following:

-   **Certificate ARN** from AWS Certificate Manager (ACM)
-   **Valid domain** for your application

Gen3-specific settings can be found in `gen3-values.yaml`, which contains the necessary configuration details for deploying Gen3 applications.

ArgoCD can be accessed using the LoadBalancer DNS name provisioned for the ArgoCD server.

**Disclaimer:** This basic configuration is intended for demonstration purposes only and should **not** be used in a production environment. For advanced, production-ready configurations, please consult the official [ArgoCD documentation](https://argo-cd.readthedocs.io/) and Gen3 guidelines.

This repository facilitates the deployment of Gen3 in AWS, as outlined in the [Gen3 Helm documentation](https://helm.gen3.org/).

Getting Started
---------------

To use this repository, you will need to **fork** it to your own GitHub account. Once you have forked the repository, ensure that you have the required dependencies and follow the instructions in the `gen3-values.yaml` file for your specific configuration.

For more information on using the Gen3 EKS Blueprints, please refer to the [Gen3 EKS Pipeline repository](https://github.com/AustralianBioCommons/gen3-eks-pipeline).