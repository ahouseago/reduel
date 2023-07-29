@react.component
let make = (~cards) => {
  let rotation = (idx: int) =>
    Array.joinWith(
      [
        `rotateZ(${Float.toString(Int.toFloat(idx * 2) -. Array.length(cards)->Int.toFloat)}deg)`,
        `rotateY(${// 5,
          // Array.length(cards) / 2 - idx,
          // -(Array.length(cards) - 1)->Int.toFloat -. Int.toFloat(idx * 2),
          // Float.toString(Int.toFloat(idx * 2) -. Array.length(cards)->Int.toFloat)
          Int.toString(0)}deg)`,
        `rotateX(-1deg)`,
      ],
      " ",
    )

  <div className="opponent-hand">
    {cards
    ->Array.mapWithIndex((card, i) =>
      <Card
        key={String.concat(Card.toString(card), Int.toString(i))}
        card
        faceUp=false
        transform={rotation(i)}
      />
    )
    ->React.array}
  </div>
}
