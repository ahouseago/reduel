@react.component
let make = (~cards) => {
  let rotation = (idx: int) => (Array.length(cards) - 1)->Int.toFloat *. -2.5 +. Int.toFloat(idx * 5)

  <div className="opponent-hand">
    {cards
    ->Array.mapWithIndex((card, i) =>
      <Card key={String.concat(Card.toString(card), Int.toString(i))} card faceUp=false rotation={rotation(i)}/>
    )
    ->React.array}
  </div>
}
