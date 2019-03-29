[![License](https://img.shields.io/badge/license-Apache--2.0-brightgreen.svg)](LICENSE)
[![Master Build Status](https://travis-ci.org/hhandoko/http4s-graal.svg?branch=master)](https://travis-ci.org/hhandoko/http4s-graal)

# http4s + Graal

`http4s-graal` is an experiment to get http4s web service running as native image with Graal (+ Substrate).

## Prerequisites

### Develop and Compile Dependencies

The following binaries / libraries need to be installed in order to compile the web service (including converting it to native image).
The version numbers denotes the specific version used to develop the web service, it may not work under other minor versions:

  - [Graal] v1.0.0-RC14
  - [SBT] v1.2.x

## Setup Steps

  1. Install and configure Graal:
     1. Download Graal (CE / EE) and extract to a folder of your choice 
     1. Add Graal binaries folder (`bin`) to `PATH`, e.g. `export PATH=~/graalvm-ce-1.0.0-rc14/bin:$PATH`
  1. Install SBT:
     - Instructions for [Windows](https://www.scala-sbt.org/1.0/docs/Installing-sbt-on-Windows.html)
     - Instructions for [Mac](https://www.scala-sbt.org/1.0/docs/Installing-sbt-on-Mac.html)
     - Instructions for [Linux](https://www.scala-sbt.org/1.0/docs/Installing-sbt-on-Linux.html)
  1. Create the uber-jar by running `sbt assembly` on the project root
  1. Create the native image by running `native-image -H:+ReportUnsupportedElementsAtRuntime -jar target/scala-2.12/http4s-graal-assembly-0.0.1-SNAPSHOT.jar`
  1. Start the web service with `./http4s-graal-assembly-0.0.1-SNAPSHOT`

Now you can visit [`localhost:8080`](http://localhost:8080) from your browser.

Alternatively:
  1. Run `./scripts/graal/bin/setup.sh` to download and setup Graal.
  1. Run `./scripts/graal/bin/dist.sh` to create a native image distribution under the `/dist` directory.

## Docker Images

Several Dockerfiles have been provided to allow project compilation and packaging, targeting multiple runtime
environments. It utilises multi-stage Docker builds, so no other dependency is required apart from Docker itself.
All containers by default will be accessible at port 9080, e.g. [`localhost:9080`](http://localhost:9080).

Run `./scripts/graal/bin/build.sh -i <image>` where image is one of the following:

  - `zulu8` (default) Azul Zulu 8 on Ubuntu 18.04
  - `zulu11` Azul Zulu 11 on Ubuntu 18.04
  - `graal` GraalVM on Oracle Linux 7 (slim)
  - `native` Graal + Substrate native image on Oracle Linux 7 (slim)

_NOTE: http4s Docker containers will be constrained to 1 CPU and 4GB of memory._

## Container Management and Monitoring

[Portainer] is an open-source web-based Docker management UI. It allows viewing of container stats in realtime: CPU and
memory usage, networking, and processes running in the container.

  1. Run `./scripts/portainer/bin/setup.sh` to pull the latest Portainer image and create the data volume.
  1. Run `./scripts/portainer/bin/start.sh` to start the Portainer container:
     - [`localhost:9000`](http://localhost:9000) Portainer web UI

## Gatling Load Testing

[Gatling] is an open-source load and performance testing framework based on Scala, Akka and Netty.

  1. Run `sbt gatling:test` to download, setup, and run Gatling load testing simulation(s).

## Contributing

We follow the "[feature-branch]" Git workflow.

  1. Commit changes to a branch in your fork (use `snake_case` convention):
     - For technical chores, use `chore/` prefix followed by the short description, e.g. `chore/do_this_chore`
     - For new features, use `feature/` prefix followed by the feature name, e.g. `feature/feature_name`
     - For bug fixes, use `bug/` prefix followed by the short description, e.g. `bug/fix_this_bug`
  1. Rebase or merge from "upstream"
  1. Submit a PR "upstream" to `develop` branch with your changes

Please read [CONTRIBUTING] for more details.

## License

```
    Copyright (c) 2018 - 2019 Herdy Handoko

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
```

`http4s-graal` is released under the Apache Version 2.0 License. See the [LICENSE] file for further details.

[CONTRIBUTING]: https://github.com/hhandoko/diskusi/blob/master/CONTRIBUTING.md
[feature-branch]: http://nvie.com/posts/a-successful-git-branching-model/
[Gatling]: https://gatling.io/
[Graal]: https://www.graalvm.org/
[LICENSE]: https://github.com/hhandoko/diskusi/blob/master/LICENSE.txt
[Portainer]: https://portainer.io/
[SBT]: https://www.scala-sbt.org/
