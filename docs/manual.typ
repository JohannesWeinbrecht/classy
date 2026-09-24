#set heading(numbering: "1.")
#import "thumbnail.typ": thumbnail

#align(center)[
  #text(size: 40pt, weight: "bold")[_classy_ manual]

  #v(2cm)

  #text(size: 20pt)[_Classy_ UML class charts using CetZ]

  #v(2cm)

  #thumbnail
]


#pagebreak()

#outline()

#pagebreak()

= Examples

== Tests

#import "/tests/test1/test.typ": test as test1

#let tests = (test1,)

#for (i,t) in tests.enumerate(start: 1){
  heading("Test " + str(i), level: 3)

  t
}
