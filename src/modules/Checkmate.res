// checks for checkmate
let make = (cells: array<Game.cell>, team) => {
  let otherTeam = team == Game.White ? Game.Black : Game.White
  let kingCell = cells -> Js.Array2.find(c => c.pieceType == Game.KingCell(otherTeam))-> Belt.Option.getExn
  let moveOptions = King.getMoveOptions(kingCell.id, otherTeam, cells)
  let (isWhiteThreatening, isBlackThreatening) = kingCell.threatState

  Js.log("King")
  Js.log(kingCell)
  Js.log(Belt.Array.length(moveOptions))
  Js.log(moveOptions)
  if Belt.Array.length(moveOptions) > 0 {
    false
  } else {
    switch otherTeam {
      | Game.White => isBlackThreatening
      | Game.Black => isWhiteThreatening
    }
  }

}
