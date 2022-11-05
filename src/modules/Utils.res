exception CellNotFound
let getTeamFromPieceType = pieceType => {
  switch pieceType {
  | Game.Blank => None
  | Game.PawnCell(team) => Some(team)
  | Game.KnightCell(team) => Some(team)
  | Game.RookCell(team) => Some(team)
  | Game.BishopCell(team) => Some(team)
  | Game.QueenCell(team) => Some(team)
  | Game.KingCell(team) => Some(team)
  }
}

let isCellOccupied = (cellId, cells: array<Game.cell>) => {
  switch cells-> Js.Array2.find(c => c.id == cellId) {
    | Some(c) => c.pieceType != Game.Blank
    | None => raise(CellNotFound)
   }
}
