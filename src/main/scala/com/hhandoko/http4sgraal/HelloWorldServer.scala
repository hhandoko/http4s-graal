package com.hhandoko.http4sgraal

import scala.concurrent.ExecutionContext

import cats.effect.{Effect, IO}
import fs2.StreamApp
import org.http4s.HttpService
import org.http4s.server.blaze.BlazeBuilder

object HelloWorldServer extends StreamApp[IO] {
  import scala.concurrent.ExecutionContext.Implicits.global

  def stream(args: List[String], requestShutdown: IO[Unit]): fs2.Stream[IO, StreamApp.ExitCode] = ServerStream.stream[IO]
}

object ServerStream {

  def helloWorldService[F[_]: Effect]: HttpService[F] = new HelloWorldService[F].service

  def stream[F[_]: Effect](implicit ec: ExecutionContext): fs2.Stream[F, StreamApp.ExitCode] =
    BlazeBuilder[F]
      .bindHttp(8080, "0.0.0.0")
      .mountService(helloWorldService, "/")
      .serve
}
