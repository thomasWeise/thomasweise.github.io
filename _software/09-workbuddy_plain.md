---
title: "Plain WorkBuddy in a Docker Container"
permalink: /workbuddy_plain
read_time: false
toc: true
author_profile: true
tags: ["ai", "docker", "workbuddy"]
last_modified_at: 2026-11-23
---

This is a plain [Docker](https://www.docker.com) image of the [WorkBuddy](https://www.workbuddy.cn) agent based on [Ubuntu](https://ubuntu.com) {% include taglink.liquid tag="linux" %}.
You can find the image at [`ghcr.io/thomasweise/workbuddy_plain`](https://github.com/thomasWeise/workbuddy_plain/pkgs/container/workbuddy_plain).
WorkBuddy normally runs in a Chrome Sandbox. 
However, here we put it *additionally* into a Docker container.
So it runs in a sandbox inside a container.
This has two advantages:
**(1)**&nbsp;We can keep the system isolated from the {% include taglink.liquid tag="ai" %} agent, thus minimizing potential problems.
**(2)**&nbsp;By putting WorkBuddy into a container, we can develop images where all the software and tools that WorkBuddy needs are installed together in a consistent image.
For example, in [`workbuddy_cs`](https://thomasweise.github.io/workbuddy_cs), we put a computer science pipeline on top this plain installation.
