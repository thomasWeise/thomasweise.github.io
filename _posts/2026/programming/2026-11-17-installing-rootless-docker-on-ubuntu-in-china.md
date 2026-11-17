---
title: "Installing Rootless Docker on Ubuntu in China"
date: 2026-11-17
last_modified_at: 2026-11-17
tags: ["linux", "bash", "docker"]
toc: false
---

Recently, I wanted to install [Docker](https://www.docker.com) to run some processes isolated from my [Ubuntu](https://ubuntu.com) 26.04.1&nbsp;LTS {% include taglink.liquid tag="linux" -%} system.

I have no background in security, but it seemed a good idea to install it in [*rootless mode*](https://docs.docker.com/engine/security/rootless).
This means that the Docker daemon and containers run as non-root users.
If some process inside goes haywire and captures the container or even the daemon, at least it won't have root privileges.
It can see and do what the normal user can see or do on my system, but it cannot really install packages or modify other protected parts of the system configuration.

Additionally, I am located in China mainland.
Therefore, I want to use China-domestic package repository and registry mirrors.
This leads to much better performance.
Also, the setup should be compliant with domestic requirements regarding system security, at least I hope that it is.

Here are the steps that I took in order to make this work.
I put them into two {% include taglink.liquid tag="bash" %} scripts, which can easily be step-by-step into the shell.
You can download them from [`rootlessDockerCN1.sh`](https://thomasweise.github.io/scripts/linuxSetup/rootlessDockerCN1.sh) and [`rootlessDockerCN2.sh`](https://thomasweise.github.io/scripts/linuxSetup/rootlessDockerCN2.sh).
You would first execute `rootlessDockerCN1.sh` step-by-step, then reboot, then execute `rootlessDockerCN2.sh` step-by-step, and then reboot.

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linuxSetup/rootlessDockerCN1.sh}}
{% endhighlight %}

Reboot now.

{% highlight bash %}
{{download https://thomasweise.github.io/scripts/linuxSetup/rootlessDockerCN2.sh}}
{% endhighlight %}

Reading the scripts, you will notice some inconsistencies.
For example, the registry mirrors stored for the root-daemon and for the rootless one are different.
Well, this is the order of the commands I executed.
It worked.
So I will not uninstall everything to try again with different commands&hellip;

Anyway.
After rebooting again, you can execute

{% highlight bash %}
docker run hello-world:latest
{% endhighlight %}

Notice that you do *not* need `sudo` to run this, it will run as a normal process under your current user.
Nice.
