package com.hhandoko.http4sgraal

import scala.concurrent.duration._
import scala.util.Random

import io.gatling.core.Predef._
import io.gatling.http.Predef._

class BasicSimulation extends Simulation {

  val httpConf =
    http
    .baseUrl("http://localhost:9080")
    .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
    .doNotTrackHeader("1")
    .acceptLanguageHeader("en-GB,en;q=0.5")
    .acceptEncodingHeader("gzip, deflate, br")
    .userAgentHeader("Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:63.0) Gecko/20100101 Firefox/63.0")

  val scn =
    scenario("Hello World!")
    .exec(http("Hello World request").get(s"/hello/${Random.alphanumeric.take(10).mkString}!"))

  setUp(
    scn.inject(constantUsersPerSec(500) during(5 minutes))
      .protocols(httpConf)
  )
}
