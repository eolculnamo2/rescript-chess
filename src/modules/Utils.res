exception CellNotFound(string)
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
    | None => raise(CellNotFound("No cell found in isCellOccupied"))
   }
}
let checkOppositeTeam = (id, cells: array<Game.cell>, team) => {
  let currentCell = switch cells->Belt.Array.get(id) {
    | Some(c) => c
    | None => raise(CellNotFound(`No currentCell in checkOppositeTeam at id ${id -> Belt.Int.toString}`))
  }
  let currentCellTeam = getTeamFromPieceType(currentCell.pieceType)
  switch currentCellTeam {
  | Some(t) => t != team
  | None => false
  }
}

let isOwnTeamCell = (id, team, cells: array<Game.cell>): bool => {
  let cell = cells->Belt.Array.get(id)
  switch cell {
  | Some(c) =>
    getTeamFromPieceType(c.pieceType)
    ->Belt.Option.map(t => t == team)
    ->Belt.Option.getWithDefault(false)

  | None => false
  }
}
