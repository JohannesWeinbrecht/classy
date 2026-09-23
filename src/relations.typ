
#import "@preview/cetz:0.5.2"
#let padding = 0.5em

#let association(
  ..points,
  name: none,
) = {
  cetz.draw.line(
    ..points,
    stroke: black,
    mark: (end: "straight", scale: 2),
    name: name,
  )
}
#let bi-association(
  ..points,
) = {
  cetz.draw.line(
    ..points,
    stroke: black,
    mark: (start: "straight", end: "straight", scale: 2),
  )
}

#let inheritance(
  ..points,
) = {
  cetz.draw.line(
    ..points,
    stroke: black,
    mark: (end: ">", scale: 2),
  )
}

#let aggregation(
  ..points,
) = {
  cetz.draw.line(
    ..points,
    stroke: black,
    mark: (start: "diamond", scale: 2),
  )
}

#let realization(
  ..points,
) = {
  cetz.draw.line(
    ..points,
    stroke: (paint: black, dash: "dashed"),
    mark: (end: ">", scale: 2),
  )
}

#let composition(
  ..points,
) = {
  cetz.draw.line(
    ..points,
    stroke: black,
    mark: (start: "diamond", fill: black, scale: 2),
  )
}

#let specialization(
  from,
  to,
  assignments: (),
  label-offset: (0, 0), // New parameter to shift the label (x, y)
) = {
  import cetz.draw: *

  group({
    line(
      from,
      to,
      stroke: (dash: "dashed"),
      mark: (end: ">", scale: 2),
      name: "edge",
    )

    if assignments != none and assignments != () {
      let formatted-assignments = if type(assignments) == array {
        assignments.map(a => [«#a»]).join([\ ])
      } else {
        [«#assignments»]
      }

      // Apply the relative offset from the middle of the line
      content(
        (rel: label-offset, to: "edge.mid"),
        box(
          fill: white,
          inset: (x: 4pt, y: 2pt),
          align(center, formatted-assignments),
        ),
        anchor: "center",
      )
    }
  })
}
