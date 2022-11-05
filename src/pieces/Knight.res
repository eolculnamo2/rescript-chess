
@react.component
let make = (~team: Game.team) => {
  <Piece
    image={switch team {
    | White => "/images/white_knight.png"
    | Black => "/images/black_knight.png"
    }}
    pieceName="Knight"
  />
}
