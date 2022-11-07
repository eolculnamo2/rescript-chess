// todo check if own team, etc
let getMoveOptions = (id, team, cells: array<Game.cell>) => {
  let moveOptions = []
  if id - Game.width - 1 > 0 {
    let _ = moveOptions->Js.Array2.push(id - Game.width - 1)
  }
  if id - Game.width > 0 {
    let _ = moveOptions->Js.Array2.push(id - Game.width)
  }
  if id - Game.width + 1 > 0 {
    let _ = moveOptions->Js.Array2.push(id - Game.width + 1)
  }
  if Boundaries.isRightBoundary(id - 1) == false {
    let _ = moveOptions->Js.Array2.push(id - 1)
  }
  if Boundaries.isLeftBoundary(id + 1) == false {
    let _ = moveOptions->Js.Array2.push(id + 1)
  }
  if id + Game.width - 1 < Game.area {
    let _ = moveOptions->Js.Array2.push(id + Game.width - 1)
  }
  if id + Game.width + 1 < Game.area {
    let _ = moveOptions->Js.Array2.push(id + Game.width + 1)
  }
  if id + Game.width < Game.area {
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
