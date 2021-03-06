myapp
=================

[![Build Status](https://travis-ci.org/koudaiii/myapp.svg?branch=master)](https://travis-ci.org/koudaiii/myapp)

CodeZine Sample Application

* [Requirement](#requirement)
* [Usage](#usage)
* [Deployment](#deployment)
   * [Console](#console)
   * [Migrate](#migrate)
   * [Cron](#cron)
* [Author](#author)
* [License](#license)

Requirement
-------------

- homebrew
  - nodenv
  - rbenv
  - ruby-build
  - postgresql
  - docker
  - kubectl
  - minikube

See `.ruby-version` and `.node-version` files for versions in use.

Usage
-------------

- Bootstrap

```shell-session
$ script/bootstrap

  CodeZine Sample Application

    開発者のための実装系Webマガジン

  + Environment variable file (.env) found.
  + nodenv found.
  + node 8.3.0 found.
  + yarn found.
  + Installing npm packages.
    > yarn install
  + npm packages installation completed.
  + PostgreSQL is running.
  + ruby 2.4.1 fonud.
  + Installing gems.
  + Gem installation completed.

  セットアップ完了

  Run 'script/server'
  And you can see 'open localhost:5000'
```

- Run

```shell-session
$ script/server
```

`$ open http://localhost:5000`


Deployment
-------------

- locally(Using minikube)

use https://github.com/kubernetes/minikube

```shell-session
$ minikube status
minikube: Stopped
localkube:
kubectl:

$ minikube start
Starting local Kubernetes v1.7.0 cluster...
Starting VM...


$ kubectl config current-context
minikube
```

```shell-session
# Create Namespace
$ kubectl create -f kubernetes/namespace.yaml

# Create nginx.conf
$ kubectl create -f kubernetes/nginx-config.yaml

# Create dotenv
$ kubectl create -f kubernetes/dotenv.yaml

# Create HorizontalPodAutoscaler
$ kubectl create -f kubernetes/myapp-hpa.yaml

# Create Service
$ kubectl create -f kubernetes/myapp-svc.yaml

# Create Database
$ kubectl create -f kubernetes/db/
service "postgres" created
deployment "postgres" created

# Create Deployment
$ kubectl create -f kubernetes/myapp.yaml
```

```shell-session
# Open Browser
$ minikube service myapp -n myapp
```

### Console

```shell-session
$ script/k8s-console
```

### Migrate

```shell-session
$ script/k8s-migrate
```

### Cron

```shell-session
$ kubectl create -f kubernetes/jobs/myapp-job.yaml
cronjob "myapp-job" created

$ kubectl get cronjob -n myapp
NAME        SCHEDULE       SUSPEND   ACTIVE    LAST-SCHEDULE
myapp-job   */15 * * * *   False     0         <none>
```

Author
-------------

[@koudaiii](https://github.com/koudaiii)

License
-------------

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
