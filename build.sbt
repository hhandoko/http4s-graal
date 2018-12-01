lazy val root =
  (project in file("."))
    .enablePlugins(GatlingPlugin)
    .settings(Commons.settings: _*)
