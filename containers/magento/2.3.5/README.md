# Magento 2.3.5

## Dependencies

Have build [PHP 7.3](../../php/7.3) first.

## How to deploy

Build the image using Google Container Registry (GCR):

```sh
docker build --tag gcr.io/$GCP_PROJECT_ID/magento:2.3.5 . --build-arg GCP_PROJECT_ID="YOUR-PROJECT-ID"
```

Push the image

```sh
docker push gcr.io/$GCP_PROJECT_ID/magento:2.3.5
``` 

## How to run

Copy `.env.example` to `.env`, and fill out the following variables:

```sh
WEBSITE_URL=
ADMIN_PASSWORD=
DB_PASSWORD=
DB_HOST=
DB_NAME=
```

Then:

```sh
docker run --rm --name magento-235 --env-file .env -p 80:80 gcr.io/$GCP_PROJECT_ID/magento:2.3.5
```
