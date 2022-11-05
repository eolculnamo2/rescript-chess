@react.component
let make = (~team: Game.team) => {
  <Piece
    image={switch team {
    | White => "/images/white_bishop.png"
    | Black => "/images/black_bishop.png"
    }}
    pieceName="Bishop"
  />
}
