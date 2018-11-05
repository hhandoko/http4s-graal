package com.hhandoko.http4sgraal

import cats.effect.IO
import org.http4s._
import org.http4s.implicits._
import org.specs2.Specification
import org.specs2.matcher.MatchResult

class HelloWorldServiceSpec extends Specification { def is = s2"""

  HelloWorld service
    should return 200 OK status      $uriReturns200
    should return "Hello, world"     $uriReturnsHelloWorld
  """

  private[this] val retHelloWorld: Response[IO] = {
    val getHW = Request[IO](Method.GET, Uri.uri("/hello/world"))
    new HelloWorldService[IO].service.orNotFound(getHW).unsafeRunSync()
  }

  private[this] def uriReturns200: MatchResult[Status] =
    retHelloWorld.status must beEqualTo(Status.Ok)

  private[this] def uriReturnsHelloWorld: MatchResult[String] =
    retHelloWorld.as[String].unsafeRunSync() must beEqualTo("""{"message":"Hello, world"}""")
}
