// Add syntax for type lambdas
// See: https://github.com/non/kind-projector
addCompilerPlugin("org.spire-math" %% "kind-projector" % "0.9.6")

// Add `assembly` task for creating uber-jar
// See: https://github.com/sbt/sbt-assembly
addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.14.6")

// Pass recommended Scala compiler flags
// See: https://github.com/DavidGregory084/sbt-tpolecat
addSbtPlugin("io.github.davidgregory084" % "sbt-tpolecat" % "0.1.3")

// Enable app restarts for better development experience
// See: https://github.com/spray/sbt-revolver
addSbtPlugin("io.spray" % "sbt-revolver" % "0.9.1")

// Pass partial unification Scala compiler flag
// See: https://github.com/fiadliel/sbt-partial-unification
addSbtPlugin("org.lyranthe.sbt" % "partial-unification" % "1.1.0")
