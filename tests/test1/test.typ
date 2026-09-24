#import "@preview/cetz:0.5.2"
#import "/src/lib.typ": *

#set page(width: 20cm, height: 15cm, margin: 2cm)

= _classy_ test

// Example usage demonstrating multiple tags
#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    class(
      (0, 0),
      "ConfigurationStore",
      "Config",
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
  })
]
