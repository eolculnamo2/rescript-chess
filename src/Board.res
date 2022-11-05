let state: Game.boardState = {
  cells: Init.Cells.make(),
  turn: Game.White,
}

type actions = MakePlay | CellClicked(int)
let reducer = (state, action) => {
  switch action {
  | MakePlay => state
  | CellClicked(id) => CellClick.make(state, id)
  }
}

let boardWidth = Belt.Int.toString(Game.width * Game.cellSize) ++ "px"
@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, state)

  <>
    <div
      style={ReactDOM.Style.make(
        ~marginBottom="2rem",
        ~display="flex",
        ~justifyContent="center",
        (),
      )}>
      <div
        style={ReactDOM.Style.make(
          ~border="4px solid black",
          ~display="flex",
          ~flexWrap="wrap",
          ~maxWidth={boardWidth},
          (),
        )}>
        {state.cells
        ->Belt.Array.mapWithIndex((i, cell) => {
          <Cell
            handleClick={id => {
              dispatch(CellClicked(id))
            }}
            key={"cell" ++ Belt.Int.toString(i)}
            cell
          />
        })
        ->React.array}
      </div>
    </div>
  </>
}
