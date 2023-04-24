# Exercism's ChatGPT Proxy

![Tests](https://github.com/exercism/chatgpt-proxy/workflows/Test/badge.svg)

This is Exercism's proxy to ChatGPT
It takes:
- an action (help, feedback)
- student's solution 
- test files

It combines these into a prompt, sends it to ChatGPT, and returns the result.

## Run as if a lambda locally

```bash
docker run --rm -p 3026:8080 chatgpt-proxy
```
