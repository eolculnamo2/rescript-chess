// maps threats of entire board to give feedback for check/checkmate related plays

exception NoTeamException

module ThreatComparator = Belt.Id.MakeComparable({
  type t = (Game.team, int)
  // stolen from docs
  let cmp = ((a0, a1), (b0, b1)) =>
    switch Pervasives.compare(a0, b0) {
    | 0 => Pervasives.compare(a1, b1)
    | c => c
    }
})

let make = (cells: array<Game.cell>) => {
  let set = Belt.MutableSet.make(~id=module(ThreatComparator))

  for i in 0 to Belt.Array.length(cells) - 1 {
    let cell = cells->Belt.Array.get(i)->Belt.Option.getExn
    let team = Utils.getTeamFromPieceType(cell.pieceType)
    let newPreviews = switch cell.pieceType {
    | Game.PawnCell(t) => Pawn.getMoveOptions(cell.id, t, cells)
    | Game.RookCell(t) => Rook.getMoveOptions(cell.id, t, cells)
    | Game.KnightCell(t) => Knight.getMoveOptions(cell.id, t, cells)
    | Game.BishopCell(t) => Bishop.getMoveOptions(cell.id, t, cells)
    | Game.KingCell(t) => King.getMoveOptions(cell.id, t, cells)
    | Game.QueenCell(t) => Queen.getMoveOptions(cell.id, t, cells)
    | _ => []
    }
    for j in 0 to Belt.Array.length(newPreviews) - 1 {
      let previewId = newPreviews->Belt.Array.get(j)->Belt.Option.getExn
      switch team {
      | Some(t) => set->Belt.MutableSet.add((t, previewId))
      | None => raise(NoTeamException)
      }
    }
  }

  Belt.MutableSet.toArray(set)
}
