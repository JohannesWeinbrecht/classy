#import "@preview/cetz:0.5.2"
#import "/src/lib.typ": *

#set page(height: auto, margin: 5mm, fill: none)

#let test = {
  align(center)[
  #cetz.canvas({
    import cetz.draw: *

    class(
      (0, 0),
      "ConverterBase",
      "converter-base",
      tag: ("abstract",), // Now accepts multiple tags
      generics: "Model",
      fields: (
        [\+ debug: bool],
      ),
      methods: (
        [\+ from_gdf(core_model: CoreModel, name: str): Model],
        [\+ to_gdf(model: Model): CoreModel],
        [\- pre_export(core_model: CoreModel, name: str): CoreModel],
        [\- _export(core_model: CoreModel, name: str): Model_],
        [\- post_export(model: Model, name: str): Model],
        [\- pre_import(model: Model): Model],
        [\- _import(model: Model): CoreModel_],
        [\- post_import(core_model: CoreModel): None],
      )
    )
    class(
      (rel: (0, -3), to: "converter-base.south-east"),
      "PandaPowerConverter",
      "pp-converter",
      tag: (), // Now accepts multiple tags
      generics: (),
      fields: (
        [run_plausibility_check: bool],
        [plausibility_output_path: str | None],
        [plausibility_result: PlausibilityResult | None]
      ),
      methods: (
        [\- export(core_model: CoreModel, name: str): Model],
        [\- import(model: Model): CoreModel],
      )
    )
    class(
      (rel: (-0, -3), to: "converter-base.south-west"),
      "PyPSAConverter",
      "pypsa-converter",
      tag: (), // Now accepts multiple tags
      generics: (),
      fields: (),
      methods: (
        [\- export(core_model: CoreModel, name: str): Model],
        [\- import(model: Model): CoreModel],
      )
    )

    specialization("pp-converter","converter-base", assignments: ([Model #sym.arrow PandaPowerModel]))
    specialization("pypsa-converter","converter-base", assignments: ([Model #sym.arrow pypsa.Network]))

  })
]
}

#test
