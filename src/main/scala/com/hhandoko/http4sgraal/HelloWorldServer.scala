package com.hhandoko.http4sgraal

import cats.effect._
import cats.implicits._
import fs2.Stream
import org.http4s.HttpApp
import org.http4s.server.Router
import org.http4s.server.blaze.BlazeServerBuilder
import org.http4s.syntax.kleisli._

object HelloWorldServer extends IOApp {

  def run(args: List[String]): IO[ExitCode] =
    ServerStream.stream[IO]
      .compile
      .drain.as(ExitCode.Success)
}

object ServerStream {

  def helloWorldApp[F[_]: Effect: ContextShift: Timer]: HttpApp[F] =
    Router("/" -> HelloWorldService[F].routes).orNotFound

  def stream[F[_]: ConcurrentEffect: Timer: ContextShift]: Stream[F, ExitCode] = {
    val host = Option(System.getenv("APP_HOST")).getOrElse("0.0.0.0")
    val port = Option(System.getenv("APP_PORT")).map(_.toInt).getOrElse(8080)

    BlazeServerBuilder[F]
      .bindHttp(port, host)
      .withHttpApp(helloWorldApp[F])
      .serve
  }

}
