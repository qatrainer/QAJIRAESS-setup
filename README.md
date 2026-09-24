September 2025 -updated v4

** Use docker version >= 29.0.0**

To start the Jira Server DC v11.2 and postgres 17.x database

1. Make sure docker is running and the engine is started.

2. Clone the git repository to your docker host: https://github.com/qatrainer/QAJIRAESS-setup.git jira-11.2

3. Request a trial extension to your previous trial licence (max 90 days per licence)  for Jira Datacenter 11.2 from Atlassian

4. Open a cmd or terminal prompt on the docker host and copy and paste the following  commands:

4.1 cd jira-11.2

4.2 docker compose up -d && docker compose logs -f jira

Jira  is now available on http://localhost:8080 or http://<Public_IP>:8080

Continue the setup in the browser...





Confluence Server 

To start the Confluence Server

1. Make sure docker desktop is running and the engine is started.

2. Open a cmd or terminal prompt and copy and paste the following docker command:

docker run -v confluence-home1:/var/atlassian/application-data/confluence --name="confluence" -d -p 8090:8090 atlassian/confluence


Confluence is now available on http://localhost:8090 or http://<public-ip>:8090


Continue the setup in the browser...
