# terraform-aws-php

What does it do?

- It creates 3 instances in AWS: (app, dbmaster, dbslave)
- It installs and configures a Cluster DB (postgres) in master-slave using dbmaster and dbslave 
- It configures one docker app (nginx+php+fpm) and deploy it on app 
    - the app start a web server (nginx) with 2 endpoints / and /blacklisted
    - in endpoint / run a function in php that works only with the query string ?n=X where x are the first n numbers in fibonacci series
    - in endpoint /blacklisted blocks the origin IP address and saves it in the DB

How to run?

- edit the files:
    - group_vars/all.yml.sample and rename to group_vars/all.yml
    - ansible.cfg

- run the playbook:
    - ansible-playbook playbook.yml

Tested using Ubuntu 18.04
