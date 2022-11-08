exception InvalidState(string)
let createMoveOptions = (id, pieceType, cells) => {
  switch pieceType {
  | Game.PawnCell(t) => Pawn.getMoveOptions(id, t, cells)
  | Game.RookCell(t) => Rook.getMoveOptions(id, t, cells)
  | Game.KnightCell(t) => Knight.getMoveOptions(id, t, cells)
  | Game.BishopCell(t) => Bishop.getMoveOptions(id, t, cells)
  | Game.KingCell(t) => King.getMoveOptions(id, t, cells)
  | Game.QueenCell(t) => Queen.getMoveOptions(id, t, cells)
  | _ => []
  }
}
let handleSelectedFromNone = (i, cell: Game.cell, clickedId, previewOptions) => {
  if i == clickedId && cell.pieceType != Game.Blank {
    {...cell, cellState: Game.Selected}
  } else if previewOptions->Js.Array2.find(p => p == i)->Belt.Option.isSome {
    {...cell, cellState: Game.MovePreview}
  } else {
    {...cell, cellState: Game.None}
  }
}

let alternateTurn = turn => turn == Game.White ? Game.Black : Game.White
let make = (state: Game.boardState, clickedId) => {
  let cellToSelect = state.cells->Js.Array2.find(c => clickedId == c.id)->Belt.Option.getExn

  switch cellToSelect.cellState {
  | None =>
    switch (state.turn, Utils.getTeamFromPieceType(cellToSelect.pieceType)) {
    | (turn, Some(t)) if turn == t => {
        let movePreviewOptions = createMoveOptions(clickedId, cellToSelect.pieceType, state.cells)
        {
          ...state,
          cells: state.cells->Belt.Array.mapWithIndex((i, c) => {
            handleSelectedFromNone(i, c, clickedId, movePreviewOptions)
          }),
        }
      }

    | (_, _) => {
        ...state,
        cells: state.cells->Belt.Array.map(c => {
          {...c, cellState: None}
        }),
      }
    }

  | Selected => {
      ...state,
      cells: state.cells->Belt.Array.map(c => {
        {...c, cellState: None}
      }),
    }

  | MovePreview => {
      let selectedCell = switch state.cells->Js.Array2.find(c => c.cellState == Game.Selected) {
      | Some(c) => c
      | None => raise(InvalidState("Preview cell selected without a cell in the Selected State"))
      }
      let newCells = state.cells->Belt.Array.mapWithIndex((i, c) => {
        if c.id == clickedId {
          {...selectedCell, cellState: None, id: i, threatState: (false, false)}
        } else if selectedCell.id == i {
          {...c, pieceType: Game.Blank, cellState: None, threatState: (false, false)}
        } else {
          {...c, cellState: None, threatState: (false, false)}
        }
      })

      // update threats
      let threatenedCells = MapThreats.make(newCells)
      let newCellsWithThreats = newCells->Belt.Array.map(cell => {
        let newThreatState =
          threatenedCells
          ->Js.Array2.filter(((_, id)) => id == cell.id)
          ->Belt.Array.reduce(cell.threatState, (agg, cur) => {
            let (team, _) = cur
            Utils.updateThreatState(agg, team, true)
          })
        {...cell, threatState: newThreatState}
      })

      let isCheckmate = Checkmate.make(newCellsWithThreats, state.turn)

      {
        /* ...state, */
        winner: switch (state.turn, isCheckmate) {
        | (_, false) => None
        | (Game.White, true) => Some(Game.White)
        | (Game.Black, true) => Some(Game.Black)
        },
        turn: alternateTurn(state.turn),
        cells: newCellsWithThreats,
      }
    }
  }
}
