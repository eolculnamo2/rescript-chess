@react.component
let make = (~team: Game.team) => {
  <Piece
    image={switch team {
    | White => "/images/white_rook.png"
    | Black => "/images/black_rook.png"
    }}
    pieceName="Rook"
  />
}
