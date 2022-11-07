let horizontalNeighbors = id => {
  let neighbors = []
  let idBehind = id - 1
  let idAhead = id + 1

  if Boundaries.isRightBoundary(idBehind) == false {
    let _ = neighbors->Js.Array2.push(idBehind)
  }
  if Boundaries.isLeftBoundary(idAhead) == false {
    let _ = neighbors->Js.Array2.push(idAhead)
  }
  neighbors
}
let verticalNeighbors = id => [id + Game.width, id - Game.width]

let getMoveOptions = (id, team, cells: array<Game.cell>) => {
  let topMoveOptions = horizontalNeighbors(id - Game.width * 2)
  let bottomMoveOptions = horizontalNeighbors(id + Game.width * 2)
  let rightMoveOptions = switch Boundaries.crossesHorizontalBoundary(id, id + 2) {
  | true => []
  | false => verticalNeighbors(id + 2)
  }
  let leftMoveOptions = switch Boundaries.crossesHorizontalBoundary(id - 2, id) {
  | true => []
  | false => verticalNeighbors(id - 2)
  }

  Belt.Array.concatMany([
    topMoveOptions,
    bottomMoveOptions,
    rightMoveOptions,
    leftMoveOptions,
  ])->Js.Array2.filter(cellId => {
    let isInBounds = cellId >= 0 && cellId < Game.area
    let isSameTeam = switch Belt.Array.get(cells, cellId) {
    | Some(cell) =>
      switch Utils.getTeamFromPieceType(cell.pieceType) {
      | Some(t) => t == team
      | None => false
      }
    | None => false
    }
    isInBounds && isSameTeam == false
  })
}

@react.component
let make = (~team: Game.team) => {
  <Piece
    image={switch team {
    | White => "/images/white_knight.png"
    | Black => "/images/black_knight.png"
    }}
    pieceName="Knight"
  />
}
