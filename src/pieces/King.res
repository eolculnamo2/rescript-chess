@react.component
let make = (~team: Game.team, ~turn) => {
  <Piece
    image={switch team {
    | White => "/images/white_king.png"
    | Black => "/images/black_king.png"
    }}
    pieceName="Bishop"
    turn
  />
}
