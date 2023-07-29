let empty = "♡"
let full = "♥"

let healthBar = (~total, ~current) =>
  Array.make(~length=total, empty)->Array.mapWithIndex((_, i) => i < current ? full : empty)

@react.component
let make = (~health, ~opponent: option<bool>=?) => {
  let bar = healthBar(~total=4, ~current=health)

  <div className={`health-container ${opponent == Some(true) ? "enemy-hp" : ""}`}>
    {bar
    ->Array.mapWithIndex((str, i) => <span key={Int.toString(i)}> {React.string(str)} </span>)
    ->React.array}
  </div>
}
