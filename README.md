# SonarQube and Scanner Docker

This repo was created to be a simple and quick alternative to work with SonarQube and Sonar Scanner on Docker. 

## Dependencies
Before you start, you first will need the following dependencies installed:

-   [Install Docker](http://docs.docker.com/installation/)
-   [Install Docker Compose](http://docs.docker.com/compose/install/)

## Running SonarQube Server

To run the SonarQube Server, use the following command: 

    docker-compose up sonar

Once the container is running, check on port 9000 if you can see this: 

[sonarqube](https://i.imgur.com/eo8ewk0.png)

Log in with your user and password and start adding the plugins necessary to scan your project. To do so, head to the 'administration' tab and click on 'marketplace'. 
After adding plugins, the server needs to be restarted in order to install, you only need to click on the 'restart server' button that pops up, no additional action required. 

Here we are using the latest official Sonar Qube image, but in case you need a particular version of SonarQube - let's say, 5.1,  you just need to alter the 'image' line on docker-compose.yml:

    sonar:
    image: sonarqube:5.1

## Running Sonar Scanner

In this repo example, the 'project' directory would be where your code is. Before running the scanner, there are a few steps you need to cover first: 

Head to docker-compose.yml and add the path to the project you wish to scan on SONAR_PROJECT_SOURCE:

    sonar-scanner:
     build: ./sonar-scanner/
     volumes:
      - ./sonar-scanner:/usr/local
     networks:
      - sonarnet
     links:
      - sonar
     command: sh sonar.sh
     container_name: sonar_scanner
     environment:
      - SONAR_HOST_URL:'http://sonar:9000'
      - SONAR_PROJECT_KEY:${PROJECT_KEY}
      - SONAR_PROJECT_NAME:${PROJECT_NAME}
      - USER_LOGIN:${USER}
      - USER_PASSWORD:${PASSWORD}
      - SONAR_PROJECT_SOURCE: ----PATH TO YOUR PROJECT----
      - SONAR_PROJECT_VERSION:0.1

Access your SonarQube server again and create a new project. 
Now go back to your docker-compose and insert your username, password, your new project name and project key on 'environment'. 

 Use the following command to run the scanner: 
 

    docker-compose up sonar-scanner



## References

-   [http://www.sonarqube.org/](http://www.sonarqube.org/)

## License

MIT License

Copyright (c) 2019 

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
