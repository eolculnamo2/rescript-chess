
// todo check if own team, etc
let getMoveOptions = (id, team, cells: array<Game.cell>) => {
  let moveOptions = []

  let topRight = id - Game.width - 1
  if topRight > 0 && Utils.isOwnTeamCell(topRight, team, cells) == false {
    let _ = moveOptions->Js.Array2.push(id - Game.width - 1)
  }

  let top = id - Game.width
  if top > 0 && Utils.isOwnTeamCell(top, team, cells) == false {
    let _ = moveOptions->Js.Array2.push(id - Game.width)
  }

  let topLeft = id - Game.width + 1 
  if topLeft > 0 && Utils.isOwnTeamCell(topLeft, team, cells) == false {
    let _ = moveOptions->Js.Array2.push(id - Game.width + 1)
  }

  let left = id - 1
  if Boundaries.isRightBoundary(left) == false && Utils.isOwnTeamCell(left, team, cells) == false  {
    let _ = moveOptions->Js.Array2.push(id - 1)
  }

  let right = id + 1
  if Boundaries.isLeftBoundary(right) == false && Utils.isOwnTeamCell(right, team, cells) == false  {
    let _ = moveOptions->Js.Array2.push(id + 1)
  }

  let bottomRight = id + Game.width - 1
  if bottomRight < Game.area && Utils.isOwnTeamCell(bottomRight, team, cells) == false {
    let _ = moveOptions->Js.Array2.push(id + Game.width - 1)
  }

  let bottomLeft = id + Game.width + 1
  if bottomLeft < Game.area && Utils.isOwnTeamCell(bottomLeft, team, cells) == false {
    let _ = moveOptions->Js.Array2.push(id + Game.width + 1)
  }

  let bottom = id + Game.width
  if  bottom < Game.area && Utils.isOwnTeamCell(bottom, team, cells) == false {
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
