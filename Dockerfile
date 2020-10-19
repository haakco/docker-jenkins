FROM jenkins/jenkins:latest

ARG PROXY=''

ENV DEBIAN_FRONTEND="noninteractive" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    TERM="xterm" \
    TZ="Africa/Johannesburg"

USER root

RUN apt-get -o Acquire::http::proxy="$PROXY" update && \
    apt-get -o Acquire::http::proxy="$PROXY" -qy dist-upgrade && \
    apt-get -o Acquire::http::proxy="$PROXY" -qy install \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common sudo && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) \
       stable" && \
    apt-get -o Acquire::http::proxy="$PROXY" update && \
    apt-get -o Acquire::http::proxy="$PROXY" -qy install \
      docker-ce docker-ce-cli containerd.io && \
    apt-get -o Acquire::http::proxy="$PROXY" -qy dist-upgrade && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

RUN usermod -aG docker jenkins &&
    groupadd --gid 1001 dockerext &&
    usermod -aG dockerext jenkins

USER jenkins

RUN /usr/local/bin/install-plugins.sh \
        display-url-api blueocean-github-pipeline google-container-registry-auth docker-build-publish ssh-credentials \
        github-api junit trilead-api matrix-auth blueocean-pipeline-editor run-condition blueocean-pipeline-api-impl \
        blueocean-bitbucket-pipeline blueocean-commons pipeline-stage-tags-metadata scm-api blueocean-config \
        blueocean-events plugin-util-api docker-workflow mailer workflow-api dockerhub-notification pipeline-model-api \
        handlebars maven-plugin checks-api ssh-slaves slack momentjs authentication-tokens font-awesome-api \
        workflow-multibranch javadoc blueocean-pipeline-scm-api ace-editor docker-commons snakeyaml-api workflow-job \
        blueocean-rest windows-slaves blueocean-core-js docker-build-step workflow-aggregator variant cloudbees-folder \
        oauth-credentials workflow-cps git-server pipeline-stage-step docker-java-api mercurial \
        jenkins-multijob-plugin ldap conditional-buildstep blueocean-git-pipeline favorite pipeline-stage-view \
        pipeline-rest-api build-notifications github-pullrequest github-branch-source pam-auth lockable-resources \
        jackson2-api jquery3-api structs blueocean command-launcher apache-httpcomponents-client-4-api blueocean-i18n \
        jquery-detached htmlpublisher blueocean-jira pipeline-model-definition workflow-scm-step jira icon-shim jsch \
        blueocean-personalization script-security pipeline-model-extensions performance durable-task \
        workflow-durable-task-step timestamper parameterized-trigger pipeline-graph-analysis credentials \
        jenkins-design-language github git-client pipeline-build-step popper-api matrix-project \
        antisamy-markup-formatter job-dsl workflow-cps-global-lib blueocean-jwt jdk-tool blueocean-dashboard \
        blueocean-rest-impl credentials-binding dashboard-view github-oauth bouncycastle-api ant docker-plugin \
        blueocean-web preSCMbuildstep plain-credentials bitbucket view-job-filters envinject-api ansicolor \
        bootstrap4-api workflow-basic-steps pipeline-milestone-step cloudbees-bitbucket-branch-source built-on-column \
        pipeline-input-step blueocean-autofavorite sse-gateway workflow-support handy-uri-templates-2-api echarts-api \
        external-monitor-job token-macro envinject okhttp-api workflow-step-api branch-api async-http-client \
        google-oauth-plugin blueocean-display-url monitoring git pubsub-light
