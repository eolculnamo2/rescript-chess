let isCellThreateneed = (id, team, cells: array<Game.cell>) => {
  let cell = cells->Belt.Array.get(id)

  switch cell {
  | Some(c) => {
      let (isWhiteThreat, isBlackThreat) = c.threatState
      if team == Game.White {
        isBlackThreat
      } else {
        isWhiteThreat
      }
    }

  | None => {
      Js.log("ignoring isCellThreateneed cell because its ID is out of bounds")
      false
    }
  }
}

let getMoveOptions = (id, team, cells: array<Game.cell>) => {
  let moveOptions = []

  let topRight = id - Game.width - 1
  if (
    topRight > 0 &&
    Boundaries.isInBounds(topRight) &&
    Utils.isOwnTeamCell(topRight, team, cells) == false &&
    isCellThreateneed(topRight, team, cells) == false
  ) {
    let _ = moveOptions->Js.Array2.push(id - Game.width - 1)
  }

  let top = id - Game.width
  if (
    top > 0 &&
    Boundaries.isInBounds(top) &&
    Utils.isOwnTeamCell(top, team, cells) == false &&
    isCellThreateneed(top, team, cells) == false
  ) {
    let _ = moveOptions->Js.Array2.push(id - Game.width)
  }

  let topLeft = id - Game.width + 1
  if (
    topLeft > 0 &&
    Boundaries.isInBounds(topLeft) &&
    Utils.isOwnTeamCell(topLeft, team, cells) == false &&
    isCellThreateneed(topLeft, team, cells) == false
  ) {
    let _ = moveOptions->Js.Array2.push(id - Game.width + 1)
  }

  let left = id - 1
  if (
    Boundaries.isInBounds(left) &&
    Boundaries.isRightBoundary(left) == false &&
    Utils.isOwnTeamCell(left, team, cells) == false &&
    isCellThreateneed(left, team, cells) == false
  ) {
    let _ = moveOptions->Js.Array2.push(id - 1)
  }

  let right = id + 1
  if (
    Boundaries.isInBounds(right) &&
    Boundaries.isLeftBoundary(right) == false &&
    Utils.isOwnTeamCell(right, team, cells) == false &&
    isCellThreateneed(right, team, cells) == false
  ) {
    let _ = moveOptions->Js.Array2.push(id + 1)
  }

  let bottomRight = id + Game.width - 1
  if (
    Boundaries.isInBounds(bottomRight) &&
    bottomRight < Game.area &&
    Utils.isOwnTeamCell(bottomRight, team, cells) == false &&
    isCellThreateneed(bottomRight, team, cells) == false
  ) {
    let _ = moveOptions->Js.Array2.push(id + Game.width - 1)
  }

  let bottomLeft = id + Game.width + 1
  if (
    Boundaries.isInBounds(bottomLeft) &&
    bottomLeft < Game.area &&
    Utils.isOwnTeamCell(bottomLeft, team, cells) == false &&
    isCellThreateneed(bottomLeft, team, cells) == false
  ) {
    let _ = moveOptions->Js.Array2.push(id + Game.width + 1)
  }

  let bottom = id + Game.width
  if (
    Boundaries.isInBounds(bottom) &&
    bottom < Game.area &&
    Utils.isOwnTeamCell(bottom, team, cells) == false &&
    isCellThreateneed(bottom, team, cells) == false
  ) {
    let _ = moveOptions->Js.Array2.push(id + Game.width)
  }
  moveOptions
}

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
