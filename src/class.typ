#import "@preview/cetz:0.5.2"

#let class(
  position,
  name,
  key,
  width: auto,
  tag: (),
  generics: (),
  padding: 5pt,
  fields: (),
  methods: (),
  ..args,
) = {
  import cetz.draw
  import cetz.styles

  draw.get-ctx(ctx => {
    // 1. Extract global canvas stroke or fallback to 1pt + black
    let base-stroke = if ctx.style.stroke != auto and ctx.style.stroke != none {
      ctx.style.stroke
    } else {
      1pt + black
    }

    // 2. Resolve styles with args.named() overriding base-stroke
    let style = styles.resolve(
      ctx.style,
      merge: (
        stroke: base-stroke,
        fill: none,
        ..args.named(),
      ),
    )

    let current-stroke = style.stroke

    // 3. Prepare inner Typst content
    let has-generics = generics != none and generics != ()

    let header-content = block(
      inset: (top: if has-generics { 7pt } else { 0pt }),
      align(center, par(justify: false)[
        #if tag != none and tag != () [
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

    let class-body = grid(
      columns: 1,
      inset: padding,
      header-content,
      grid.hline(stroke: current-stroke),
      field-content,
      grid.hline(stroke: current-stroke),
      operation-content,
    )

    // 4. Draw CeTZ elements
    draw.group(name: key, {
      draw.content(
        position,
        text(bottom-edge: "baseline", class-body),
        name: "body",
        frame: "rect",
        stroke: current-stroke,
      )

      if has-generics {
        let gen-display = if type(generics) == array { generics.join(", ") } else { generics }

        draw.content(
          "body.north-east",
          box(
            stroke: current-stroke,
            fill: none, // Set to none so dark mode background isn't covered by white
            inset: (x: 4pt, y: 4pt),
            [#gen-display],
          ),
          name: "generics",
          anchor: "center",
        )
      }
    })
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
