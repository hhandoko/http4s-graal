package com.hhandoko.http4sgraal

import cats.effect._
import io.circe.Json
import org.http4s.HttpRoutes
import org.http4s.circe._
import org.http4s.dsl.Http4sDsl
import org.http4s.server._

class HelloWorldService[F[_]](implicit F: Effect[F]) extends Http4sDsl[F] {

  def routes: HttpRoutes[F] =
    Router[F](
      "" -> rootRoutes
    )

  private[this] def rootRoutes: HttpRoutes[F] =
    HttpRoutes.of[F] {
      case GET -> Root / "hello" / name =>
        Ok(Json.obj("message" -> Json.fromString(s"Hello, ${name}")))
    }

}

object HelloWorldService {

  def apply[F[_]: Effect: ContextShift]: HelloWorldService[F] =
    new HelloWorldService[F]

}
