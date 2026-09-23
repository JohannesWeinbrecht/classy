#import "@preview/cetz:0.5.2"

#let class(
  position,
  name,
  key,
  width: auto,
  tag: (), // Defaulted to an empty array
  generics: (),
  padding: 5pt,
  fields: (),
  methods: (),
) = {
  // Check if generics exist to determine if extra top spacing is needed
  let has-generics = generics != none and generics != ()

  let header-content = block(
    // Add 10pt of top inset if there are generics, otherwise 0pt
    inset: (top: if has-generics { 7pt } else { 0pt }),
    align(center, par(justify: false)[
      #if tag != none and tag != () [
        // Check if tag is an array; if so, join with a comma
        #let tag-display = if type(tag) == array { tag.join(", ") } else { tag }
        _«#tag-display»_ \
      ]
      *#name*
    ]),
  )

  let field-content = if fields != () {
    par(justify: false, fields.map(f => [#f]).join([\ ]))
  } else { [] }

  let operation-content = if methods != () {
    par(justify: false, methods.map(m => [#m]).join([\ ]))
  } else { [] }

  let columns = if width == auto { 1 } else { (width,) }

  let class-body = grid(
    columns: 1,
    inset: padding,
    header-content,
    grid.hline(),
    field-content,
    grid.hline(),
    operation-content,
  )

  cetz.draw.group(name: key, {
    cetz.draw.content(
      position,
      text(bottom-edge: "baseline", class-body),
      name: "body",
      frame: "rect",
    )

    if has-generics {
      let gen-display = if type(generics) == array { generics.join(", ") } else { generics }

      cetz.draw.content(
        "body.north-east",
        box(
          stroke: 1pt,
          fill: white,
          inset: (x: 4pt, y: 4pt),
          [#gen-display],
        ),
        name: "generics",
        anchor: "center",
      )
    }
  })
}
#let simple-class(
  position,
  name,
  key,
  width: auto,
  tag: (), // Defaulted to an empty array
  generics: (),
  padding: 8pt,
  style: none
) = {
  // Check if generics exist to determine if extra top spacing is needed
  let has-generics = generics != none and generics != ()

  let header-content = block(
    // Add 10pt of top inset if there are generics, otherwise 0pt
    inset: (top: if has-generics { 7pt } else { 0pt }),
    align(center, par(justify: false)[
      #if tag != none and tag != () [
        // Check if tag is an array; if so, join with a comma
        #let tag-display = if type(tag) == array { tag.join(", ") } else { tag }
        _«#tag-display»_ \
      ]
      *#name*
    ]),
  )

  let columns = if width == auto { 1 } else { (width,) }

  let class-body = grid(
    columns: 1,
    inset: padding,
    header-content,
  )

  cetz.draw.group(name: key, {
    cetz.draw.content(
      position,
      text(bottom-edge: "baseline", class-body),
      name: "body",
      frame: "rect",
    )

    if has-generics {
      let gen-display = if type(generics) == array { generics.join(", ") } else { generics }

      cetz.draw.content(
        "body.north-east",
        box(
          stroke: 1pt,
          fill: white,
          inset: (x: 4pt, y: 4pt),
          [#gen-display],
        ),
        name: "generics",
        anchor: "center",
      )
    }
  })
}
