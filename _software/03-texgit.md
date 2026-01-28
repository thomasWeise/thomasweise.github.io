---
title: "texgit: Accessing Git Repositories from LaTeX"
permalink: /software/texgit
read_time: false
toc: false
author_profile: true
---

`texgit` is a preprocessor for accessing files from `git`&nbsp;repositories from LaTeX.
It has two components, namely the Python package [`texgit`](/texgit_py) and the LaTeX style [`texgit`](/texgit_tex).
Together, they enable you to automatically download `git`&nbsp;repositories, include files from these repositories in your LaTeX documents or even execute them and capture their outputs.
The process is similar to BibTeX:
The requests for repositories and files are collected from the LaTeX document during the first LaTeX run.
This is done by the [`texgit`](/texgit_tex) LaTeX package&nbsp;(which stores the requests into the `aux` file).
During this first LaTeX run, the contents of the requested files are returned as empty strings.
Then the [`texgit`](/texgit_py) Python program is executed, which downloads the repositories, executes programs in them if requested, and collects the files and outputs locally.
During the second LaTeX run, these contents are available and can be included in the LaTeX document in any way you like.

For more information, see

- [`texgit`](/texgit_tex) LaTeX package
- [`texgit`](/texgit_py) Python program
