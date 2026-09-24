#import "@preview/cetz:0.5.2"
#import "/src/lib.typ": *

#set page(height: auto, margin: 5mm, fill: none)

#let test = {
align(center)[
  #cetz.canvas({
    import cetz.draw: *

    class(
      (0, 0),
      "ConfigurationStore",
      "config",
      tag: ("interface", "singleton"), // Now accepts multiple tags
      generics: "T",
      fields: (
        "- instance: ConfigurationStore",
      ),
      methods: (
        "+ getInstance(): ConfigurationStore",
        [_- loadConfig(): void_]
      )
    )

    class(
      (rel: (5, 0), to: "config.east"),
      "CetZ",
      "cetz",
      tag: ("Singleton"), // Now accepts multiple tags
      generics: (),
      fields: (),
      methods: ()
    )
    class(
      (rel:(0, -5), to: "cetz.south"),
      "Classy",
      "classy"
    )
    inheritance("classy", "cetz")

  })
]
}
#test
