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
