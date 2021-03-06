# SonarQube and Scanner Docker

This repo was created to be a simple and quick alternative to work with SonarQube and Sonar Scanner on Docker. 

The embedded [H2 database is not suited for production](https://hub.docker.com/_/sonarqube/), so this project runs with the supported PostgreSQL database.  

## Dependencies
Before you start, you first will need the following dependencies installed:

-   [Install Docker](http://docs.docker.com/installation/)
-   [Install Docker Compose](http://docs.docker.com/compose/install/)

Also make sure your docker host configuration follows Elasticsearch production mode [requirements](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html#docker-cli-run-prod-mode), setting the recommened values with these commands as root (Linux):

    sysctl -w vm.max_map_count=262144
    sysctl -w fs.file-max=65536
    ulimit -n 65536
    ulimit -u 4096

Or Windows: 

    docker-machine ssh
    sudo sysctl -w vm.max_map_count=262144
    exit

## Running SonarQube Server

Before you run SonarQube Server, please remind to run postgres first: 

    docker-compose up -d postgres

Now you can use the following command: 

    docker-compose up sonar

Once the sonar container is running, check on port 9000 if you can see this: 

![sonarqube](https://i.imgur.com/eo8ewk0.png)

Log in with your user and password and start adding the plugins necessary to scan your project. To do so, head to the 'administration' tab and click on 'marketplace'. 
After adding plugins, the server needs to be restarted in order to install, you only need to click on the 'restart server' button that pops up, no additional action required. 

Here we are using the latest official Sonar Qube image, but in case you need a particular version of SonarQube - let's say, 5.1,  you just need to alter the 'image' line on docker-compose.yml:

    sonar:
    image: sonarqube:5.1

## Running Sonar Scanner

In this repo example, the 'project' directory would be where your code is. Before running the scanner, there are a few steps you need to cover first: 

Head to docker-compose.yml and add the path to the project you wish to scan on SONAR_PROJECT_SOURCE:

     x-sonar-credentials: &sonar-credentials
        sonar.jdbc.url: jdbc:postgresql://postgres:5432/sonar
        sonar.jdbc.username: postgres
        sonar.jdbc.password: admin
        SONAR_HOST_URL: http://sonar:9000
        SONAR_PROJECT_KEY: ${PROJECT_KEY}
        USER_LOGIN: ${USER}
        USER_PASSWORD: ${PASSWORD}
        SONAR_PROJECT_SOURCE: path_to_your_project
        SONAR_PROJECT_VERSION: 0.1
       
   
Access your SonarQube server again and create a new project. 
Now go back to your docker-compose and insert your username, password, your new project name and project key on 'environment'. 

 Use the following command to run the scanner: 
 

    docker-compose up sonar-scanner

## References

- [http://www.sonarqube.org/](http://www.sonarqube.org/)
- [https://hub.docker.com/_/sonarqube/](https://hub.docker.com/_/sonarqube/)

## License

MIT License

Copyright (c) 2019 carlalmadureira

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
