@react.component
let make = (~selectedCard, ~opponentCard, ~onClick) => {
  let bothSelected = switch (selectedCard, opponentCard) {
  | (Some(_), Some(_)) => true
  | _ => false
  }
  <div className="play-area-container">
    <div className="play-area">
      {switch selectedCard {
      | Some(card) => <Card card faceUp=false />
      | None => <div className="empty-card-slot"> {React.string("Select a card to play...")} </div>
      }}
      {switch opponentCard {
      | Some(card) => <Card card faceUp=false />
      | None =>
        <div className="empty-card-slot">
          {React.string("Waiting for opponent to select a card...")}
        </div>
      }}
      <button onClick disabled={!bothSelected}> {React.string("Resolve")} </button>
    </div>
  </div>
}
