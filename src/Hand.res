// type card2 = Attack("Deal 1 damage.")
// | Counter("")

@react.component
let make = (~hand, ~pickCard) => {
  let rotation = (idx: int) => (Array.length(hand) - 1)->Int.toFloat *. -2.5 +. Int.toFloat(idx * 5)

  let transform = idx =>
    Array.joinWith(
      [
        `rotateZ(${Float.toString(rotation(idx))}deg)`,
        `rotateY(${Float.toString(0.0 -. rotation(idx))}deg)`,
        "rotateX(-5deg)",
      ],
      " ",
    )

  <div className="hand-container">
    <div className="card-container">
      {Array.mapWithIndex(hand, (card, i) =>
        <Card
          key={String.concat(Card.toString(card), Int.toString(i))}
          card
          faceUp=true
          transform={transform(i)}
          onClick={_ => pickCard(card, i)}
        />
      )->React.array}
    </div>
  </div>
}
