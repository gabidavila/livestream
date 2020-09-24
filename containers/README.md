# Containers

These are custom containers added to the repository to make it usable when deploying applications on [Google Cloud Platform](https://cloud.google.com).

## Current Containers

### Magento

Version [2.3.5](magento/2.3.5/Dockerfile) based of the `php` [7.3](php/7.3/Dockerfile) image with custom php modules necessary to run the application.

I know industry practice is to use `nginx` for it, however for Proof of Concept (POC) I am using the `apache2` version. Feel free to PR with your own customization.
