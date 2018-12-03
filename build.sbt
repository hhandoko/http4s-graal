lazy val root =
  (project in file("."))
    .enablePlugins(GatlingPlugin)
    .settings(Common.settings: _*)
