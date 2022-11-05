@react.component
let make = (~team: Game.team) => {
  <Piece
    image={switch team {
    | White => "/images/white_queen.png"
    | Black => "/images/black_queen.png"
    }}
    pieceName="Queen"
  />
}

