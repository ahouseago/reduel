%%raw(`import './App.css'`)

let pickRandomCard = (hand: array<Card.t>) => {
  let randomIndex = (Math.random() *. Array.length(hand)->Int.toFloat)->Math.floor->Float.toInt
  (Array.at(hand, randomIndex), randomIndex)
}

let removeElAtIdx = (arr, idx) =>
  Array.concat(Array.slice(arr, ~start=0, ~end=idx), Array.sliceToEnd(arr, ~start={idx + 1}))
// Array.reduceWithIndex(arr, [], (newArr, el, i) => i == idx ? newArr : Array.concat(newArr, [el]))

@react.component
let make = () => {
  let (hand, setHand) = React.useState(() => [Card.Attack, Counter, Rest])
  let (aiHand, setAiHand) = React.useState(() => [Card.Attack, Counter, Rest])
  let (health, setHealth) = React.useState(() => 4)
  let (aiHealth, setAiHealth) = React.useState(() => 4)
  let (selectedCard: option<Card.t>, setSelectedCard) = React.useState(() => None)
  let (selectedAiCard: option<Card.t>, setAiCard) = React.useState(() => None)

  React.useEffect1(() => {
    switch (health, aiHealth) {
    | (0, 0) => %raw(`alert("It's a draw")`)
    | (0, _) => %raw(`alert("You lose!")`)
    | (_, 0) => %raw(`alert("You win!")`)
    | _ => ()
    }
    None
  }, [health, aiHealth])

  let pickCard = (card, idx) => {
    setHand(prev =>
      switch selectedCard {
      | Some(prevSelected) => Array.concat(removeElAtIdx(prev, idx), [prevSelected])
      | None => removeElAtIdx(prev, idx)
      }
    )
    setSelectedCard(_ => Some(card))
    let (aiCard, aiIdx) = pickRandomCard(aiHand)
    setAiHand(prev =>
      switch selectedAiCard {
      | Some(prevSelected) => Array.concat(removeElAtIdx(prev, aiIdx), [prevSelected])
      | None => removeElAtIdx(prev, aiIdx)
      }
    )
    setAiCard(_ => aiCard)
  }

  let resolve = _ => {
    switch (selectedCard, selectedAiCard) {
    | (Some(Card.Attack), Some(Attack)) => {
        setHealth(prev => prev - 1)
        setAiHealth(prev => prev - 1)
      }
    | (Some(Card.Counter), Some(Attack)) => {
        setAiHealth(prev => prev - 1)
        setHand(Array.concat(_, [Counter]))
      }
    | (Some(Card.Rest), Some(Attack)) => {
        setHealth(prev => prev - 1)
        setHand(Array.concat(_, [Attack, Rest]))
      }
    | (Some(Card.Attack), Some(Counter)) => {
        setHealth(prev => prev - 1)
        setAiHand(Array.concat(_, [Counter]))
      }
    | (Some(Card.Counter), Some(Counter)) => ()
    | (Some(Card.Rest), Some(Counter)) => setHand(Array.concat(_, [Attack, Counter, Rest]))
    | (Some(Card.Attack), Some(Rest)) => {
        setAiHealth(prev => prev - 1)
        setAiHand(Array.concat(_, [Attack, Rest]))
      }
    | (Some(Card.Counter), Some(Rest)) => setAiHand(Array.concat(_, [Attack, Counter, Rest]))
    | (Some(Card.Rest), Some(Rest)) => {
        setHand(Array.concat(_, [Attack, Counter, Rest]))
        setAiHand(Array.concat(_, [Attack, Counter, Rest]))
      }
    | _ => failwith("unknown hands found during resolution")
    }
    // Discard the cards in play
    setSelectedCard(_ => None)
    setAiCard(_ => None)
  }

  <div className="App">
    <header className="App-header">
      <h1> {"Dueler"->React.string} </h1>
    </header>
    <HealthBar health=aiHealth opponent=true />
    <OpponentHand cards={aiHand} />
    <PlayArea selectedCard opponentCard={selectedAiCard} onClick={resolve} />
    <Hand hand pickCard />
    <HealthBar health />
  </div>
}
