# Develop & Publish Sample Edge Application

This page contains the bash scripts code to publish the Sample Edge Application.

## Content

- [Prerequisites](#prerequisites)
- [Publish](#publish)

### Prerequisites

Install the following tools:
- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [make](https://www.gnu.org/software/make/)
- [docker](https://www.ibm.com/links?url=https%3A%2F%2Fdocs.docker.com%2Fget-docker%2F)

## Publish

1) Log in to your edge node with the user id **ibm-workshop** created during IEAM agent deployment.

> Note: For edge node only Linux operating system is supported.

```markdown
cd /home/ibm-workshop/workspace
git clone https://github.com/gargpriyank/sample-edge-app.git
cd sample-edge-app
```

2) Update the following environment variables in `env.sh` file.

```markdown
docker login -u <docker_user_name> -p <docker_password> # Provide the docker user name and password.

export HZN_ORG_ID=sandbox-edge-workshop-ieam-cluster # Provide the organization id of IEAM management hub.
export HZN_EXCHANGE_USER_AUTH=iamapikey:<api_key>   # Provide the API Key to connect to IEAM management hub.
export EVENTSTREAMS_TOPIC_NAME=<eventstreams_topic_name>    # Provide the IBM Event Streams topic name.
export EVENTSTREAMS_BROKER_URL=<eventstreams_broker_url>    # Provide the IBM Event Streams broker URL.
export EVENTSTREAMS_API_KEY=<eventstreams_api_key>  # Provide the IBM Event Streams API Key.
```

3) Publish the sample edge application.

```markdown
./publishApp.sh
```

## Next Step
- [Register Sample Edge Application With Node Policy](sample-edge-app-register.md)