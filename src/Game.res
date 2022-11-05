type team = White | Black
type pieceType =
  | Blank
  | PawnCell(team)
  | KnightCell(team)
  | RookCell(team)
  | BishopCell(team)
  | QueenCell(team)
  | KingCell(team)
let width = 8
let height = 8
let area = width * height

let cellSize = 45
let cellSizePx = cellSize->Belt.Int.toString ++ "px"
type cellState = None | Selected | MovePreview
type cell = {id: int, pieceType: pieceType, cellState: cellState}
type boardState = {
  cells: array<cell>,
  turn: team,
}


