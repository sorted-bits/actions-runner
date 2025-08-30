# Github Actions Runner Docker

## Credits

This is based on the following articles:

- [Alessandro Baccini Medium blog](https://baccini-al.medium.com/how-to-containerize-a-github-actions-self-hosted-runner-5994cc08b9fb) 
- [Testdriven.io blog](https://testdriven.io/blog/github-actions-docker/)

## What is it

This is a Docker image that adds an Action Runner to your organisation or repository, based on the environment variables you set for your Docker container.

## How do I use this:

First determine if you want to add an Action Runner to a repository or an organisation.

#### Organization
1. Visit the [personal access tokens](https://github.com/settings/personal-access-tokens/new) creation page on Github and create a new fine-grained access token.
2. Set the **token name**, **resource owner** (organisation) and **expiration**.
3. Select the right repository access
4. In the **Permissions** field, under the **Organizations** tab, add the `self-hosted runners` permission with `read and write`.
5. Generate the token and store it somewhere safe (like a password manager).
6. Run your docker container
```docker
docker run \
  --detach \
  --env ORG=<ORG-NAME> \
  --env ACCESS_TOKEN=<ACCESS-TOKEN> \
  --env RUNNER_GROUP=<RUNNER GROUP NAME> \ # Optional runner group, otherwise Default
  --name runner \
  runner-image
  ```

  #### Repository

  1. Visit the [personal access tokens](https://github.com/settings/personal-access-tokens/new) creation page on Github and create a new fine-grained access token.
2. Set the **token name**, **resource owner** (organisation) and **expiration**.
3. Select the right repository access
4. TBD (Don't have runner permissions on my account?)
99. Run your docker container

```docker
docker run \
  --detach \
  --env REPO=<REPO-NAME> \
  --env ACCESS_TOKEN=<ACCESS-TOKEN> \
  --env RUNNER_GROUP=<RUNNER GROUP NAME> \ # Optional runner group, otherwise Default
  --name runner \
  runner-image
  ```

  **Tip:** Your `<REPO-NAME>` should contain your username as well, e.g. `wimhaanstra/some-repo`

