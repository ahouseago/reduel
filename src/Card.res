type t = Attack | Counter | Rest

let toString = card =>
  switch card {
  | Attack => "Attack"
  | Counter => "Counter"
  | Rest => "Rest"
  }

@react.component
let make = (
  ~card: t,
  ~faceUp: bool,
  ~rotation: float=0.0,
  ~onClick: option<JsxEvent.Mouse.t => unit>=?,
) => {
  let description = switch card {
  | Attack => <p> {React.string("Deal 1 damage.")} </p>
  | Counter =>
    <p>
      {String.concat(
        "If opponent attacks, block the damage, deal 1 damage, ",
        "and return this card to your hand.",
      )->React.string}
    </p>
  | Rest =>
    <>
      <p> {React.string("Draw 1 attack.")} </p>
      <p>
        {String.concat(
          "If you didn't take any damage this turn, draw a counter ",
          "(TODO: and discard one attack or counter).",
        )->React.string}
      </p>
      <p> {React.string("Return this card to your hand.")} </p>
    </>
  }

  let transform = Array.joinWith(
    [
      `rotateZ(${Float.toString(rotation)}deg)`,
      `rotateY(${Float.toString(0.0 -. rotation)}deg)`,
      "rotateX(-5deg)",
    ],
    " ",
  )

  <div
    className="card"
    style={{
      transform: transform,
    }}
    onClick={switch onClick {
    | Some(handler) => handler
    | None => _ => ()
    }}>
    {faceUp
      ? <div className="card-face">
          <h2> {card->toString->React.string} </h2>
          description
        </div>
      : <>
          <div className={"card-face card-front"} />
          <div className={"card-face card-back"}>
            <h2> {card->toString->React.string} </h2>
            description
          </div>
        </>}
  </div>
}
