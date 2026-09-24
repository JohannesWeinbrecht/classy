#import "@preview/cetz:0.5.2": *

#set page(height: auto, margin: 5mm, fill: none)

// style thumbnail for light and dark theme
#let theme = sys.inputs.at("theme", default: "light")
#set text(white) if theme == "dark"


#set text(22pt)

#let thumbnail = {
  align(center)[
    #canvas({
      import draw: *
      import "../src/lib.typ": *

      if theme == "dark"{
        set-style(stroke: (paint: white))
      }

      class(
        (0,0),
        "CetZ",
        "cetz",
        tag: ("Singleton"), // Now accepts multiple tags
        generics: (),
        fields: (),
        methods: ()
      )
      class(
        (rel:(0, -3), to: "cetz.south"),
        "Classy",
        "classy"
      )
      inheritance("classy", "cetz")
    })
  ]
}

#thumbnail
