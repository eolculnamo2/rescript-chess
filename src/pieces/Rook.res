exception CellNotFound(string)
let rec addOptionsTo0 = (~moveOptions=[], id, team, cells: array<Game.cell>) => {
  let isOppositeTeam = Utils.checkOppositeTeam(id, cells, team)
  if id > Game.width && isOppositeTeam == false {
    let nextCell = switch cells->Belt.Array.get(id - Game.width) {
      | Some(c) => c
      | None => raise(CellNotFound("No nextCell in addOptionsTo0"))
    }
    switch Utils.getTeamFromPieceType(nextCell.pieceType) {
    | Some(t) if t == team => moveOptions
    | Some(_) | None =>
      addOptionsTo0(
        id - Game.width,
        team,
        cells,
        ~moveOptions=moveOptions->Belt.Array.concat([id - Game.width]),
      )
    }
  } else {
    moveOptions
  }
}
let rec addOptionsToArea = (~moveOptions=[], id, team, cells: array<Game.cell>) => {
  let isOppositeTeam = Utils.checkOppositeTeam(id, cells, team)
  if id < Game.area - Game.width && isOppositeTeam == false {
    let nextCell = switch cells->Belt.Array.get(id + Game.width)  {
      | Some(c) => c
      | None => raise(CellNotFound(`No nextCell in addOptionsToArea with id: ${id->Belt.Int.toString}`))
    }
    switch Utils.getTeamFromPieceType(nextCell.pieceType) {
    | Some(t) if t == team => moveOptions
    | Some(_) | None =>
      addOptionsToArea(
        id + Game.width,
        team,
        cells,
        ~moveOptions=moveOptions->Belt.Array.concat([id + Game.width]),
      )
    }
  } else {
    moveOptions
  }
}

type horizontalDir = Left | Right
let rec addHorizontalOptions = (~moveOptions=[], id, team, cells: array<Game.cell>, direction) => {
  let isOppositeTeam = Utils.checkOppositeTeam(id, cells, team)
  let isBoundaryCell =
    direction == Left ? Boundaries.isLeftBoundary(id) : Boundaries.isRightBoundary(id)
  let nextId = direction == Left ? id - 1 : id + 1

  if isOppositeTeam || isBoundaryCell {
    moveOptions
  } else {
    let nextCell = cells->Belt.Array.get(nextId)->Belt.Option.getExn
    switch Utils.getTeamFromPieceType(nextCell.pieceType) {
    | Some(t) if t == team => moveOptions
    | Some(_) | None =>
      addHorizontalOptions(
        nextId,
        team,
        cells,
        direction,
        ~moveOptions=moveOptions->Belt.Array.concat([nextId]),
      )
    }
  }
}

let getMoveOptions = (id, team, cells: array<Game.cell>) => {
  let upOptions = addOptionsTo0(id, team, cells)
  let downOptions = addOptionsToArea(id, team, cells)
  let horizontalOptionsLeft = addHorizontalOptions(id, team, cells, Left)
  let horizontalOptionsRight = addHorizontalOptions(id, team, cells, Right)
  Belt.Array.concatMany([upOptions, downOptions, horizontalOptionsLeft, horizontalOptionsRight])
}

@react.component
let make = (~team: Game.team, ~turn) => {
  <Piece
    image={switch team {
    | White => "/images/white_rook.png"
    | Black => "/images/black_rook.png"
    }}
    pieceName="Rook"
    turn
  />
}
