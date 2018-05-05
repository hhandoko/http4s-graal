import scala.io.Source

import sbt.Keys._
import sbt._

object Commons {

  private val http4sVersion  = "0.18.9"
  private val logbackVersion = "1.2.3"
  private val specs2Version  = "4.1.0"

  val settings = Seq(
    organization := "com.hhandoko",
    name := "http4s-graal",
    version := Source.fromFile("VERSION.txt").mkString,
    scalaVersion := "2.12.6",
    libraryDependencies ++= Seq(
      "ch.qos.logback" %  "logback-classic"     % logbackVersion,
      "org.http4s"     %% "http4s-blaze-server" % http4sVersion,
      "org.http4s"     %% "http4s-circe"        % http4sVersion,
      "org.http4s"     %% "http4s-dsl"          % http4sVersion,
      "org.specs2"     %% "specs2-core"         % specs2Version % Test
    )
  )
}
