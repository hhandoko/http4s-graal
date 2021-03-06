import scala.io.Source

import sbt.Keys._
import sbt._

object Common {

  private val http4sVersion     = "0.19.0"
  private val gatlingVersion    = "3.0.3"
  private val logbackVersion    = "1.2.3"
  private val pureConfigVersion = "0.10.2"
  private val specs2Version     = "4.5.1"

  val settings = Seq(
    organization := "com.hhandoko",
    name := "http4s-graal",
    version := Source.fromFile("VERSION.txt").mkString,
    scalaVersion := "2.12.8",
    libraryDependencies ++= Seq(
      "ch.qos.logback"        %  "logback-classic"           % logbackVersion,
      "com.github.pureconfig" %% "pureconfig"                % pureConfigVersion,
      "org.http4s"            %% "http4s-blaze-server"       % http4sVersion,
      "org.http4s"            %% "http4s-circe"              % http4sVersion,
      "org.http4s"            %% "http4s-dsl"                % http4sVersion,
      "io.gatling.highcharts" %  "gatling-charts-highcharts" % gatlingVersion % Test,
      "io.gatling"            %  "gatling-test-framework"    % gatlingVersion % Test,
      "org.specs2"            %% "specs2-core"               % specs2Version  % Test
    )
  )
}
